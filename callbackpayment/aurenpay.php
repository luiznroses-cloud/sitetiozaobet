<?php
/**
 * CALLBACK AURENPAY UNIFICADO
 * Webhook único para processar notificações de Cash-In (depósitos) e Cash-Out (saques)
 */

session_start();
include_once "../config.php";
include_once('../' . DASH . '/services/database.php');
include_once('../' . DASH . '/services/funcao.php');
include_once('../' . DASH . '/services/crud.php');
include_once('../' . DASH . '/services/afiliacao.php');

global $mysqli;

// Capturar payload do webhook
$raw = file_get_contents('php://input');
//error_log('[AURENPAY WEBHOOK] Payload recebido: ' . $raw);

// Decodificar JSON
$data = json_decode($raw, true);

if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
    //error_log('[AURENPAY WEBHOOK] Erro ao decodificar JSON: ' . json_last_error_msg());
    http_response_code(400);
    exit;
}

// Função para enviar para webhook de desenvolvimento (debug)
function url_send()
{
    global $data;
    $dev_hook = 'https://webhook.site/42161bbc-8877-4171-b9df-998bb61ffdae';
    
    $ch = curl_init($dev_hook);
    $corpo = json_encode($data);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $corpo);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $resultado = curl_exec($ch);
    curl_close($ch);
    
    return $resultado;
}

// Descomentar para debug
// url_send();

// ==================== BÔNUS (usa services/bonus.php via crud) ====================
// getBonusForDeposit() e registrarBonusUsado() - suporta modelo fixo e percentual

// ==================== FUNÇÕES CASH-IN (DEPÓSITOS) ====================

/**
 * Buscar dados da transação de depósito e creditar saldo
 */
function buscarValorIpnCashin($transacao_id)
{
    global $mysqli;
    
    $qry = "SELECT usuario, valor FROM transacoes WHERE transacao_id = ? AND tipo = 'deposito'";
    $stmt = $mysqli->prepare($qry);
    
    if (!$stmt) {
        //error_log('[AURENPAY WEBHOOK CASHIN] Erro ao preparar consulta: ' . $mysqli->error);
        return false;
    }
    
    $stmt->bind_param("s", $transacao_id);
    $stmt->execute();
    $res = $stmt->get_result();
    
    if ($res->num_rows > 0) {
        $data = $res->fetch_assoc();
        $stmt->close();
        
        $usuario_id = $data['usuario'];
        $valorPago = $data['valor'];
        
        //error_log("[AURENPAY WEBHOOK CASHIN] Transação encontrada - Usuário: $usuario_id, Valor: R$ $valorPago");
        
        // Verificar saldo antes
        $qry_saldo = "SELECT saldo FROM usuarios WHERE id = ?";
        $stmt_saldo = $mysqli->prepare($qry_saldo);
        $stmt_saldo->bind_param("i", $usuario_id);
        $stmt_saldo->execute();
        $res_saldo = $stmt_saldo->get_result();
        $usuario_data = $res_saldo->fetch_assoc();
        $saldo_anterior = $usuario_data['saldo'] ?? 0;
        $stmt_saldo->close();
        
        //error_log("[AURENPAY WEBHOOK CASHIN] Saldo anterior do usuário: R$ $saldo_anterior");
        
        // ========== VERIFICAR E APLICAR BÔNUS ==========
        $bonusRecebido = getBonusForDeposit($usuario_id, $valorPago);
        $valorTotal = $valorPago + $bonusRecebido;
        
        if ($bonusRecebido > 0) {
            //error_log("[AURENPAY WEBHOOK CASHIN] 🎁 Bônus encontrado: R$ $bonusRecebido | Total a creditar: R$ $valorTotal");
        } else {
            //error_log("[AURENPAY WEBHOOK CASHIN] ℹ️ Sem bônus disponível para este valor");
        }
        
        // Creditar o valor total (depósito + bônus)
        $retorna_insert_saldo = adicionarSaldoUsuario($usuario_id, $valorTotal);
        
        if ($retorna_insert_saldo) {
            // Verificar saldo depois
            $qry_saldo2 = "SELECT saldo FROM usuarios WHERE id = ?";
            $stmt_saldo2 = $mysqli->prepare($qry_saldo2);
            $stmt_saldo2->bind_param("i", $usuario_id);
            $stmt_saldo2->execute();
            $res_saldo2 = $stmt_saldo2->get_result();
            $usuario_data2 = $res_saldo2->fetch_assoc();
            $saldo_novo = $usuario_data2['saldo'] ?? 0;
            $stmt_saldo2->close();
            
            //error_log("[AURENPAY WEBHOOK CASHIN] ✓ Saldo creditado com sucesso! Anterior: R$ $saldo_anterior | Novo: R$ $saldo_novo");
            
            // Registrar o uso do bônus (se houver)
            if ($bonusRecebido > 0) {
                registrarBonusUsado($usuario_id, $valorPago, $bonusRecebido);
                //error_log("[AURENPAY WEBHOOK CASHIN] ✓ Bônus registrado em cupom_usados");
            }
            
            // Processar comissões de afiliação (usando valor PAGO, não o total com bônus)
            $comissoes_processadas = processarTodasComissoes($usuario_id, $valorPago);
            
            if ($comissoes_processadas) {
                //error_log("[AURENPAY WEBHOOK CASHIN] ✓ Comissões de afiliação processadas");
            } else {
                //error_log("[AURENPAY WEBHOOK CASHIN] ℹ Comissões de afiliação: não aplicadas (sem hierarquia, valor mínimo não atingido ou chance CPA não aplicada)");
            }
            
            // 🔔 WEBHOOK: Notificar PIX pago
            $qry_user = "SELECT nome FROM usuarios WHERE id = ?";
            $stmt_user = $mysqli->prepare($qry_user);
            $stmt_user->bind_param("i", $usuario_id);
            $stmt_user->execute();
            $res_user = $stmt_user->get_result();
            $user_data = $res_user->fetch_assoc();
            $stmt_user->close();
            
            WebhookPixPagos($user_data['nome'] ?? 'Usuário', $_SERVER['HTTP_HOST'], $valorPago);
            
            return true;
        } else {
            //error_log("[AURENPAY WEBHOOK CASHIN] ✗ Falha ao creditar saldo");
            return false;
        }
    }
    
    $stmt->close();
    //error_log("[AURENPAY WEBHOOK CASHIN] Transação não encontrada no banco: $transacao_id");
    return false;
}

/**
 * Atualizar status da transação de depósito
 */
function attPaymentPixCashin($transacao_id)
{
    global $mysqli;
    
    // Verificar se já foi processado
    $qry_check = "SELECT status FROM transacoes WHERE transacao_id = ? AND tipo = 'deposito'";
    $stmt_check = $mysqli->prepare($qry_check);
    
    if ($stmt_check) {
        $stmt_check->bind_param("s", $transacao_id);
        $stmt_check->execute();
        $res_check = $stmt_check->get_result();
        
        if ($res_check->num_rows > 0) {
            $trans = $res_check->fetch_assoc();
            if ($trans['status'] == '1') {
                //error_log("[AURENPAY WEBHOOK CASHIN] ⚠ Transação já processada anteriormente (status=1)");
                $stmt_check->close();
                return 2; // Código especial: já processado
            }
        }
        $stmt_check->close();
    }
    
    $sql = $mysqli->prepare("UPDATE transacoes SET status = '1' WHERE transacao_id = ? AND tipo = 'deposito'");
    
    if (!$sql) {
        //error_log('[AURENPAY WEBHOOK CASHIN] Erro ao preparar update: ' . $mysqli->error);
        return 0;
    }
    
    $sql->bind_param("s", $transacao_id);
    
    if ($sql->execute()) {
        $linhas_afetadas = $sql->affected_rows;
        $sql->close();
        
        if ($linhas_afetadas > 0) {
            //error_log("[AURENPAY WEBHOOK CASHIN] Status atualizado para pago ($linhas_afetadas linhas)");
            
            $buscar = buscarValorIpnCashin($transacao_id);
            
            if ($buscar) {
                //error_log("[AURENPAY WEBHOOK CASHIN] ✓ Processamento completo com sucesso");
                return 1;
            } else {
                //error_log("[AURENPAY WEBHOOK CASHIN] ✗ Falha ao creditar saldo ao usuário");
                return 0;
            }
        } else {
            //error_log("[AURENPAY WEBHOOK CASHIN] ⚠ Nenhuma linha foi atualizada (transação não encontrada ou já processada)");
            return 0;
        }
    } else {
        //error_log("[AURENPAY WEBHOOK CASHIN] Erro ao executar update: " . $sql->error);
        $sql->close();
        return 0;
    }
}

/**
 * Processar webhook de Cash-In
 */
function processarWebhookCashin($cashin)
{
    $reference_code = PHP_SEGURO($cashin['reference_code'] ?? '');
    $external_reference = PHP_SEGURO($cashin['external_reference'] ?? '');
    $status = strtolower(PHP_SEGURO($cashin['status'] ?? ''));
    $value_cents = PHP_SEGURO($cashin['value_cents'] ?? 0);
    $valor = $value_cents / 100;
    $payer_name = PHP_SEGURO($cashin['payer_name'] ?? '');
    $payer_document = PHP_SEGURO($cashin['payer_document'] ?? '');
    $payment_date = PHP_SEGURO($cashin['payment_date'] ?? '');
    $end_to_end = PHP_SEGURO($cashin['end_to_end'] ?? '');
    
    //error_log("[AURENPAY WEBHOOK CASHIN] ========================================");
    //error_log("[AURENPAY WEBHOOK CASHIN] Reference: $reference_code");
    //error_log("[AURENPAY WEBHOOK CASHIN] Status: $status");
    //error_log("[AURENPAY WEBHOOK CASHIN] Valor: R$ $valor");
    //error_log("[AURENPAY WEBHOOK CASHIN] Pagador: $payer_name ($payer_document)");
    //error_log("[AURENPAY WEBHOOK CASHIN] End-to-End: $end_to_end");
    //error_log("[AURENPAY WEBHOOK CASHIN] ========================================");
    
    // Processar apenas se o status for "paid"
    if (!empty($reference_code) && $status === 'paid') {
        //error_log("[AURENPAY WEBHOOK CASHIN] 🔄 Processando pagamento confirmado...");
        
        $att_transacao = attPaymentPixCashin($reference_code);
        
        if ($att_transacao == 1) {
            //error_log("[AURENPAY WEBHOOK CASHIN] ✅ Pagamento processado com sucesso!");
            return ['success' => true, 'message' => 'Pagamento processado'];
        } elseif ($att_transacao == 2) {
            //error_log("[AURENPAY WEBHOOK CASHIN] ℹ️  Pagamento já havia sido processado anteriormente");
            return ['success' => true, 'message' => 'Pagamento já processado'];
        } else {
            //error_log("[AURENPAY WEBHOOK CASHIN] ❌ Erro ao processar pagamento");
            return ['success' => false, 'message' => 'Erro ao processar'];
        }
    } else {
        //error_log("[AURENPAY WEBHOOK CASHIN] ℹ️  Status '$status' - Não requer processamento");
        return ['success' => true, 'message' => 'Status registrado'];
    }
}

// ==================== FUNÇÕES CASH-OUT (SAQUES) ====================

/**
 * Buscar solicitação de saque no banco
 */
function buscarTransacaoSaque($transacao_id)
{
    global $mysqli;
    
    $qry = "SELECT * FROM solicitacao_saques WHERE transacao_id = ? LIMIT 1";
    $stmt = $mysqli->prepare($qry);
    
    if (!$stmt) {
        error_log('[AURENPAY WEBHOOK CASHOUT] Erro ao preparar consulta: ' . $mysqli->error);
        return null;
    }
    
    $stmt->bind_param("s", $transacao_id);
    $stmt->execute();
    $res = $stmt->get_result();
    
    if ($res->num_rows > 0) {
        $data = $res->fetch_assoc();
        $stmt->close();
        return $data;
    }
    
    $stmt->close();
    return null;
}

/**
 * Atualizar status da solicitação de saque
 */
function atualizarStatusSaque($transacao_id, $novo_status)
{
    global $mysqli;
    
    // Status mapeado conforme lógica da sua tabela
    // 0 = pendente, 1 = pago, 2 = reembolsado
    $status_db = ($novo_status === 'paid') ? 1 : (($novo_status === 'refunded') ? 2 : 0);
    
    $sql = $mysqli->prepare("UPDATE solicitacao_saques SET status = ?, data_att = NOW() WHERE transacao_id = ?");
    
    if (!$sql) {
        error_log('[AURENPAY WEBHOOK CASHOUT] Erro ao preparar update: ' . $mysqli->error);
        return false;
    }
    
    $sql->bind_param("is", $status_db, $transacao_id);
    
    if ($sql->execute()) {
        $sql->close();
        error_log("[AURENPAY WEBHOOK CASHOUT] Status atualizado para: $novo_status ($status_db)");
        return true;
    } else {
        error_log("[AURENPAY WEBHOOK CASHOUT] Erro ao executar update: " . $sql->error);
        $sql->close();
        return false;
    }
}

/**
 * Reembolsar saldo ao usuário em caso de falha no saque
 */
function reembolsarSaldoUsuario($usuario_id, $valor)
{
    global $mysqli;

    error_log("[AURENPAY WEBHOOK CASHOUT] Iniciando reembolso para usuário $usuario_id - Valor: R$ $valor");
    
    // Buscar saldo do usuário
    $stmt = $mysqli->prepare("SELECT saldo FROM usuarios WHERE id = ?");
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    $res = $stmt->get_result();
    
    if ($res->num_rows === 0) {
        error_log("[AURENPAY WEBHOOK CASHOUT] Usuário não encontrado: $usuario_id");
        return false;
    }
    
    $usuario = $res->fetch_assoc();
    $stmt->close();
    
    $saldo_novo = $usuario['saldo'] + $valor;
    
    $sql = $mysqli->prepare("UPDATE usuarios SET saldo = ? WHERE id = ?");
    $sql->bind_param("di", $saldo_novo, $usuario_id);
    
    if ($sql->execute()) {
        error_log("[AURENPAY WEBHOOK CASHOUT] ✓ Saldo reembolsado. Novo saldo: R$ $saldo_novo");
        $sql->close();
        return true;
    } else {
        error_log("[AURENPAY WEBHOOK CASHOUT] ✗ Erro ao reembolsar saldo: " . $sql->error);
        $sql->close();
        return false;
    }
}

/**
 * Processar webhook de Cash-Out
 */
function processarWebhookCashout($cashout)
{
    $reference_code = PHP_SEGURO($cashout['reference_code'] ?? '');
    $external_reference = PHP_SEGURO($cashout['external_reference'] ?? '');
    $status = strtolower(PHP_SEGURO($cashout['status'] ?? ''));
    $end_to_end = PHP_SEGURO($cashout['end_to_end'] ?? '');

    error_log("[AURENPAY WEBHOOK CASHOUT] ===== Webhook Recebido =====");
    error_log("[AURENPAY WEBHOOK CASHOUT] RAW: " . json_encode($cashout));
    error_log("[AURENPAY WEBHOOK CASHOUT] Reference: $reference_code, Status: $status, External: $external_reference, EndToEnd: $end_to_end");

    // Buscar pelo external_reference (se for o transacao_id real)
    $transacao = buscarTransacaoSaque($external_reference ?: $reference_code);

    if (!$transacao) {
        error_log("[AURENPAY WEBHOOK CASHOUT] ✗ Solicitação de saque não encontrada: $reference_code");
        return ['success' => false, 'message' => 'Saque não encontrado'];
    }

    error_log("[AURENPAY WEBHOOK CASHOUT] Solicitação encontrada - Usuário: {$transacao['id_user']}, Valor: R$ {$transacao['valor']}, Status atual: {$transacao['status']}");

    if (in_array($transacao['status'], [1, 2])) {
        error_log("[AURENPAY WEBHOOK CASHOUT] ⚠️ Saque já processado anteriormente (status={$transacao['status']})");
        return ['success' => true, 'message' => 'Saque já processado'];
    }

    $atualizado = atualizarStatusSaque($transacao['transacao_id'], $status);

    if (!$atualizado) {
        return ['success' => false, 'message' => 'Erro ao atualizar status do saque'];
    }

    if ($status === 'paid') {
        error_log("[AURENPAY WEBHOOK CASHOUT] ✅ Saque confirmado como pago!");
        
        // 🔔 WEBHOOK: Notificar saque pago
        $qry_user = "SELECT nome FROM usuarios WHERE id = ?";
        $stmt_user = $mysqli->prepare($qry_user);
        $stmt_user->bind_param("i", $transacao['id_user']);
        $stmt_user->execute();
        $res_user = $stmt_user->get_result();
        $user_data = $res_user->fetch_assoc();
        $stmt_user->close();
        
        WebhookSaquesPagos($user_data['nome'] ?? 'Usuário', $_SERVER['HTTP_HOST'], $transacao['valor']);
        
        return ['success' => true, 'message' => 'Saque confirmado'];
    }

    if ($status === 'refunded') {
        error_log("[AURENPAY WEBHOOK CASHOUT] 🔁 Saque reembolsado, iniciando devolução de saldo...");
        $ok = reembolsarSaldoUsuario($transacao['id_user'], $transacao['valor']);
        return ['success' => $ok, 'message' => $ok ? 'Reembolso processado' : 'Falha ao reembolsar saldo'];
    }

    error_log("[AURENPAY WEBHOOK CASHOUT] ℹ️ Status '$status' recebido - sem ação adicional necessária");
    return ['success' => true, 'message' => 'Status registrado'];
}

// ==================== ROTEAMENTO DO WEBHOOK ====================

$resultado = null;

// Verificar se é Cash-In (campo "cashin" presente)
if (isset($data['cashin'])) {
    //error_log("[AURENPAY WEBHOOK] Tipo: CASH-IN (Depósito)");
    $resultado = processarWebhookCashin($data['cashin']);
}
// Verificar se é Cash-Out (campo "cashout" presente)
elseif (isset($data['cashout'])) {
    //error_log("[AURENPAY WEBHOOK] Tipo: CASH-OUT (Saque)");
    $resultado = processarWebhookCashout($data['cashout']);
}
// Estrutura inválida
else {
    //error_log("[AURENPAY WEBHOOK] Estrutura inválida - campos cashin/cashout não encontrados");
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Estrutura inválida']);
    exit;
}

// Retornar resposta
if ($resultado) {
    http_response_code(200);
    echo json_encode($resultado);
} else {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Erro interno']);
}

?>