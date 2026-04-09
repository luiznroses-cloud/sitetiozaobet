<?php
/**
 * CALLBACK NEXTPAY
 * Webhook para processar notificações de Cash-In (depósitos) e Cash-Out (saques) da NextPay
 * 
 * ATUALIZAÇÃO: Adicionado suporte para webhooks de cashout
 */
 
//ini_set('display_errors', 1);
//error_reporting(E_ALL);
//ini_set('log_errors', 1);
//ini_set('error_log', __DIR__ . '/error.log');

session_start();
include_once "../config.php";
include_once('../' . DASH . '/services/database.php');
include_once('../' . DASH . '/services/funcao.php');
include_once('../' . DASH . '/services/crud.php');
include_once('../' . DASH . '/services/afiliacao.php');

global $mysqli;

// Capturar payload do webhook
$raw = file_get_contents('php://input');

// Decodificar JSON
$data = json_decode($raw, true);

if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
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

// ==================== FUNÇÕES DE BÔNUS ====================

/**
 * Verifica se existe bônus ativo para o valor e se o usuário ainda não usou
 * Retorna o valor do bônus ou 0
 */
function verificarBonus($userId, $valorPago) {
    global $mysqli;
    
    // 1. Verificar se usuário já usou este bônus
    $sqlCheck = "SELECT id FROM cupom_usados WHERE id_user = ? AND valor = ?";
    $stmtCheck = $mysqli->prepare($sqlCheck);
    $stmtCheck->bind_param("id", $userId, $valorPago);
    $stmtCheck->execute();
    $resultCheck = $stmtCheck->get_result();
    
    if ($resultCheck->num_rows > 0) {
        $stmtCheck->close();
        return 0; // Usuário já usou este bônus
    }
    $stmtCheck->close();
    
    // 2. Buscar cupom ativo (status = 1) para este valor
    $sql = "SELECT qtd_insert FROM cupom WHERE status = 1 AND valor = ?";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("d", $valorPago);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($row = $result->fetch_assoc()) {
        $stmt->close();
        return $row['qtd_insert']; // Retorna o valor do bônus
    }
    
    $stmt->close();
    return 0; // Sem bônus disponível
}

/**
 * Registra o uso do bônus na tabela cupom_usados
 */
function registrarBonusUsado($userId, $valorPago, $bonusRecebido) {
    global $mysqli;
    
    if ($bonusRecebido <= 0) {
        return false;
    }
    
    $sql = "INSERT INTO cupom_usados (id_user, valor, bonus, data_registro) 
            VALUES (?, ?, ?, NOW())";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("idi", $userId, $valorPago, $bonusRecebido);
    $resultado = $stmt->execute();
    $stmt->close();
    
    return $resultado;
}

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
    
        // Verificar saldo antes
        $qry_saldo = "SELECT saldo FROM usuarios WHERE id = ?";
        $stmt_saldo = $mysqli->prepare($qry_saldo);
        $stmt_saldo->bind_param("i", $usuario_id);
        $stmt_saldo->execute();
        $res_saldo = $stmt_saldo->get_result();
        $usuario_data = $res_saldo->fetch_assoc();
        $saldo_anterior = $usuario_data['saldo'] ?? 0;
        $stmt_saldo->close();
        
        // ========== VERIFICAR E APLICAR BÔNUS ==========
        $bonusRecebido = verificarBonus($usuario_id, $valorPago);
        $valorTotal = $valorPago + $bonusRecebido;
        
        if ($bonusRecebido > 0) {
        } else {
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
            
            // Registrar o uso do bônus (se houver)
            if ($bonusRecebido > 0) {
                registrarBonusUsado($usuario_id, $valorPago, $bonusRecebido);
            }
            
            // Processar comissões de afiliação (usando valor PAGO, não o total com bônus)
            $comissoes_processadas = processarTodasComissoes($usuario_id, $valorPago);
            
            if ($comissoes_processadas) {
            } else {
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
            return false;
        }
    }
    
    $stmt->close();
    return false;
}

/**
 * Atualizar status da transação de depósito
 */
function attPaymentPix($transacao_id)
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
            
            if ($trans['status'] == 'pago') {
                $stmt_check->close();
                return 2; // Código especial: já processado
            }
        } else {
            $stmt_check->close();
            return 0;
        }
        $stmt_check->close();
    }
    
    $sql = $mysqli->prepare("UPDATE transacoes SET status = 'pago' WHERE transacao_id = ? AND tipo = 'deposito'");
    
    if (!$sql) {
        return 0;
    }
    
    $sql->bind_param("s", $transacao_id);
    
    if ($sql->execute()) {
        $linhas_afetadas = $sql->affected_rows;
        $sql->close();
        
        if ($linhas_afetadas > 0) {
            $buscar = buscarValorIpnCashin($transacao_id);
            
            if ($buscar) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    } else {
        $sql->close();
        return 0;
    }
}

/**
 * Processar webhook de Cash-In
 */
function processarWebhookCashin($webhook_data)
{
    $type = PHP_SEGURO($webhook_data['type'] ?? '');
    $status = strtolower(PHP_SEGURO($webhook_data['status'] ?? ''));
    $amount = PHP_SEGURO($webhook_data['amount'] ?? 0);
    $fee = PHP_SEGURO($webhook_data['fee'] ?? 0);
    $request_number = PHP_SEGURO($webhook_data['request_number'] ?? '');
    $transaction_id = PHP_SEGURO($webhook_data['transaction_id'] ?? '');
    $e2e = PHP_SEGURO($webhook_data['e2e'] ?? '');
    $provider = PHP_SEGURO($webhook_data['provider'] ?? '');
    $updated_at = PHP_SEGURO($webhook_data['updated_at'] ?? '');

    // Processar apenas se for tipo cashin e o status for "confirmed"
    if ($type === 'cashin' && !empty($request_number) && $status === 'confirmed') {
        $att_transacao = attPaymentPix($request_number);

        if ($att_transacao == 1) {
            return ['success' => true, 'message' => 'Pagamento processado'];
        } elseif ($att_transacao == 2) {
            return ['success' => true, 'message' => 'Pagamento já processado'];
        } else {
            return ['success' => false, 'message' => 'Erro ao processar'];
        }
    } else {
        return ['success' => true, 'message' => 'Status registrado'];
    }
}

// ==================== FUNÇÕES CASH-OUT (SAQUES) ====================

/**
 * Atualizar status da solicitação de saque
 * 
 * @param string $transaction_id - ID da transação (pode conter o e2e)
 * @param string $status - Status do saque: 'completed', 'pending', 'failed', etc.
 * @param string $e2e - End-to-End ID do saque
 * @return int - 0: erro, 1: sucesso, 2: já processado, 3: saque não encontrado
 */
function attSaqueStatus($transaction_id, $status, $e2e = '')
{
    global $mysqli;
    
    // Tentar localizar o saque pelo transaction_id ou e2e
    $qry_find = "SELECT transacao_id, status, id_user, valor FROM solicitacao_saques 
                 WHERE transacao_id = ? OR transacao_id = ? 
                 ORDER BY data_registro DESC LIMIT 1";
    $stmt_find = $mysqli->prepare($qry_find);
    
    if (!$stmt_find) {
        error_log("[NEXTPAY CASHOUT] Erro ao preparar query de busca");
        return 0;
    }
    
    $stmt_find->bind_param("ss", $transaction_id, $e2e);
    $stmt_find->execute();
    $res_find = $stmt_find->get_result();
    
    if ($res_find->num_rows === 0) {
        $stmt_find->close();
        error_log("[NEXTPAY CASHOUT] Saque não encontrado: $transaction_id / $e2e");
        return 3; // Saque não encontrado
    }
    
    $saque = $res_find->fetch_assoc();
    $transacao_id_real = $saque['transacao_id'];
    $status_atual = $saque['status'];
    $usuario_id = $saque['id_user'];
    $valor_saque = $saque['valor'];
    $stmt_find->close();
    
    // Se status for "completed" e já estiver como status = 1, não processar novamente
    if ($status === 'completed' && $status_atual == 1) {
        error_log("[NEXTPAY CASHOUT] Saque já processado: $transacao_id_real");
        return 2; // Já processado
    }
    
    // Mapear status da NextPay para status no banco
    $status_db = 0; // padrão: pendente
    
    switch (strtolower($status)) {
        case 'completed':
        case 'success':
        case 'approved':
            $status_db = 1; // Aprovado
            break;
            
        case 'failed':
        case 'rejected':
        case 'cancelled':
        case 'error':
            $status_db = 2; // Rejeitado/Cancelado
            break;
            
        case 'pending':
        case 'processing':
        default:
            $status_db = 0; // Pendente
            break;
    }
    
    // Atualizar status do saque
    $sql_update = "UPDATE solicitacao_saques 
                   SET status = ?, data_att = NOW() 
                   WHERE transacao_id = ?";
    $stmt_update = $mysqli->prepare($sql_update);
    
    if (!$stmt_update) {
        error_log("[NEXTPAY CASHOUT] Erro ao preparar query de atualização");
        return 0;
    }
    
    $stmt_update->bind_param("is", $status_db, $transacao_id_real);
    
    if ($stmt_update->execute()) {
        $linhas_afetadas = $stmt_update->affected_rows;
        $stmt_update->close();
        
        if ($linhas_afetadas > 0) {
            error_log("[NEXTPAY CASHOUT] Saque atualizado com sucesso: $transacao_id_real - Status: $status_db");
            
            // 🔔 WEBHOOK: Notificar saque pago se status for 1 (aprovado)
            if ($status_db == 1) {
                $qry_user = "SELECT nome FROM usuarios WHERE id = ?";
                $stmt_user = $mysqli->prepare($qry_user);
                $stmt_user->bind_param("i", $usuario_id);
                $stmt_user->execute();
                $res_user = $stmt_user->get_result();
                $user_data = $res_user->fetch_assoc();
                $stmt_user->close();
                
                WebhookSaquesPagos($user_data['nome'] ?? 'Usuário', $_SERVER['HTTP_HOST'], $valor_saque);
            }
            
            return 1;
        } else {
            error_log("[NEXTPAY CASHOUT] Nenhuma linha afetada: $transacao_id_real");
            return 0;
        }
    } else {
        error_log("[NEXTPAY CASHOUT] Erro ao executar update");
        $stmt_update->close();
        return 0;
    }
}

/**
 * Processar webhook de Cash-Out (Saques)
 * 
 * Payload esperado:
 * {
 *   "type": "cashout",
 *   "status": "completed",
 *   "amount": 250.00,
 *   "fee": 2.50,
 *   "transaction_id": "...",
 *   "e2e": "WD_...",
 *   "updated_at": "2025-11-24 12:00:00"
 * }
 */
function processarWebhookCashout($webhook_data)
{
    $type = PHP_SEGURO($webhook_data['type'] ?? '');
    $status = strtolower(PHP_SEGURO($webhook_data['status'] ?? ''));
    $amount = PHP_SEGURO($webhook_data['amount'] ?? 0);
    $fee = PHP_SEGURO($webhook_data['fee'] ?? 0);
    $transaction_id = PHP_SEGURO($webhook_data['transaction_id'] ?? '');
    $e2e = PHP_SEGURO($webhook_data['e2e'] ?? '');
    $updated_at = PHP_SEGURO($webhook_data['updated_at'] ?? '');
    
    error_log("[NEXTPAY CASHOUT] Webhook recebido - Type: $type, Status: $status, TxID: $transaction_id, E2E: $e2e");
    
    // Validar que é um cashout
    if ($type !== 'cashout') {
        error_log("[NEXTPAY CASHOUT] Tipo inválido: $type");
        return ['success' => false, 'message' => 'Tipo de webhook inválido'];
    }
    
    // Validar que há um identificador
    if (empty($transaction_id) && empty($e2e)) {
        error_log("[NEXTPAY CASHOUT] Sem identificador válido");
        return ['success' => false, 'message' => 'Transaction ID ou E2E não informado'];
    }
    
    // Usar e2e como fallback se transaction_id estiver vazio
    $id_busca = !empty($transaction_id) ? $transaction_id : $e2e;
    
    // Atualizar status do saque
    $resultado = attSaqueStatus($id_busca, $status, $e2e);
    
    switch ($resultado) {
        case 1:
            return ['success' => true, 'message' => 'Saque atualizado com sucesso'];
        case 2:
            return ['success' => true, 'message' => 'Saque já processado anteriormente'];
        case 3:
            return ['success' => false, 'message' => 'Saque não encontrado'];
        default:
            return ['success' => false, 'message' => 'Erro ao atualizar saque'];
    }
}

// ==================== PROCESSAMENTO DO WEBHOOK ====================

// Determinar tipo de webhook
$type = PHP_SEGURO($data['type'] ?? '');

if ($type === 'cashin') {
    // Processar Cash-In (Depósito)
    $resultado = processarWebhookCashin($data);
} elseif ($type === 'cashout') {
    // Processar Cash-Out (Saque)
    $resultado = processarWebhookCashout($data);
} else {
    // Tipo desconhecido
    error_log("[NEXTPAY] Tipo de webhook desconhecido: $type");
    $resultado = ['success' => false, 'message' => 'Tipo de webhook não reconhecido'];
}

// Retornar resposta
if ($resultado && $resultado['success']) {
    http_response_code(200);
    echo json_encode($resultado);
} else {
    http_response_code(500);
    echo json_encode($resultado ?: ['success' => false, 'message' => 'Erro interno']);
}

?>