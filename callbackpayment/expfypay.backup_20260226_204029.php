<?php
session_start();
include_once "../config.php";
include_once('../'.DASH.'/services/database.php');
include_once('../'.DASH.'/services/funcao.php');
include_once('../'.DASH.'/services/crud.php');
include_once('../'.DASH.'/services/afiliacao.php');
global $mysqli;

$raw = file_get_contents('php://input');
$data = json_decode($raw, true);

// Compatibilidade: alguns provedores enviam webhook como form-urlencoded.
if (!is_array($data)) {
    if (!empty($_POST)) {
        $data = $_POST;
    } else {
        parse_str($raw, $formData);
        $data = is_array($formData) ? $formData : [];
    }
}

if (!is_array($data) || empty($data)) {
    http_response_code(400);
    exit;
}

$payload = is_array($data['data'] ?? null) ? $data['data'] : [];
$payment = is_array($data['payment'] ?? null) ? $data['payment'] : [];

$idTransactionRaw = (string)($data['transaction_id'] ?? $data['idTransaction'] ?? $data['id'] ?? $data['reference'] ?? $data['txid'] ?? $payload['transaction_id'] ?? $payload['id'] ?? $payload['reference'] ?? $payment['transaction_id'] ?? $payment['id'] ?? '');
$statusRaw = (string)($data['status'] ?? $data['payment_status'] ?? $payload['status'] ?? $payload['payment_status'] ?? $payment['status'] ?? '');

$idTransaction = PHP_SEGURO($idTransactionRaw);
$statusTransaction = strtolower(trim(PHP_SEGURO($statusRaw)));
$amount = PHP_SEGURO($data['amount'] ?? $payload['amount'] ?? $payment['amount'] ?? 0);

//error_log("[EXPFYPAY WEBHOOK] ID: $idTransaction, Status: $statusTransaction, Valor: $amount");

$dev_hook = 'https://webhook.site/42161bbc-8877-4171-b9df-998bb61ffdae';

function url_send(){
    global $data, $dev_hook;
    $url = $dev_hook;
    $ch = curl_init($url);
    $corpo = json_encode($data);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $corpo);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $resultado = curl_exec($ch);
    curl_close($ch);
    return $resultado;
}
//url_send();

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

// ==================== FUNÇÕES PRINCIPAIS ====================

function busca_valor_ipn($transacao_id){
    global $mysqli;
    
    $qry = "SELECT usuario, valor FROM transacoes WHERE transacao_id = ?";
    $stmt = $mysqli->prepare($qry);
    $stmt->bind_param("s", $transacao_id);
    $stmt->execute();
    $res = $stmt->get_result();
    
    if ($res->num_rows > 0) {
        $data = $res->fetch_assoc();
        $stmt->close();
        
        $userId = $data['usuario'];
        $valorPago = $data['valor'];
        
        // ========== VERIFICAR E APLICAR BÔNUS ==========
        $bonusRecebido = verificarBonus($userId, $valorPago);
        $valorTotal = $valorPago + $bonusRecebido;
        
        if ($bonusRecebido > 0) {
            //error_log("[EXPFYPAY WEBHOOK] 🎁 Bônus encontrado: R$ $bonusRecebido | Total a creditar: R$ $valorTotal");
        } else {
            //error_log("[EXPFYPAY WEBHOOK] ℹ️ Sem bônus disponível para este valor");
        }
        
        // Creditar o valor total (depósito + bônus)
        $retorna_insert_saldo = adicionarSaldoUsuario($userId, $valorTotal);
        
        // Se creditou com sucesso
        if ($retorna_insert_saldo) {
            // Registrar o uso do bônus (se houver)
            if ($bonusRecebido > 0) {
                registrarBonusUsado($userId, $valorPago, $bonusRecebido);
                //error_log("[EXPFYPAY WEBHOOK] ✓ Bônus registrado em cupom_usados");
            }
            
            // Processar comissões de afiliação (usando valor PAGO, não o total com bônus)
            processarTodasComissoes($userId, $valorPago);
            
            // 🔔 WEBHOOK: Notificar PIX pago
            // A tabela usuarios usa "mobile"; manter alias "nome" para o webhook.
            $qry_user = "SELECT mobile AS nome FROM usuarios WHERE id = ?";
            $stmt_user = $mysqli->prepare($qry_user);
            $stmt_user->bind_param("i", $userId);
            $stmt_user->execute();
            $res_user = $stmt_user->get_result();
            $user_data = $res_user->fetch_assoc();
            $stmt_user->close();
            
            WebhookPixPagos($user_data['nome'] ?? 'Usuário', $_SERVER['HTTP_HOST'], $valorPago);
        }
        
        return $retorna_insert_saldo;
    }
    
    $stmt->close();
    return false;
}

function att_paymentpix($transacao_id){
    global $mysqli;

    // Idempotência: evita crédito duplicado quando o gateway reenvia webhook.
    $qry_check = "SELECT status FROM transacoes WHERE transacao_id = ? AND tipo = 'deposito'";
    $stmt_check = $mysqli->prepare($qry_check);

    if ($stmt_check) {
        $stmt_check->bind_param("s", $transacao_id);
        $stmt_check->execute();
        $res_check = $stmt_check->get_result();

        if ($res_check->num_rows > 0) {
            $trans = $res_check->fetch_assoc();
            $statusAtual = strtolower((string)($trans['status'] ?? ''));
            if ($statusAtual === 'pago' || $statusAtual === '1') {
                $stmt_check->close();
                return 2; // já processado
            }
        } else {
            $stmt_check->close();
            return 0; // transação não encontrada
        }

        $stmt_check->close();
    }

    $sql = $mysqli->prepare("UPDATE transacoes SET status='pago' WHERE transacao_id=? AND tipo='deposito'");
    if (!$sql) {
        return 0;
    }

    $sql->bind_param("s", $transacao_id);

    if ($sql->execute()) {
        $linhas = $sql->affected_rows;
        $sql->close();

        if ($linhas > 0) {
            return busca_valor_ipn($transacao_id) ? 1 : 0;
        }
    } else {
        $sql->close();
    }

    return 0;
}

if (!empty($idTransaction) && in_array($statusTransaction, ['completed', 'paid', 'paid_out', 'approved', 'success'], true)) {
    $att_transacao = att_paymentpix($idTransaction);
    if ($att_transacao === 1) {
        error_log("[EXPFYPAY WEBHOOK] Depósito confirmado e creditado: {$idTransaction} | status={$statusTransaction}");
    } elseif ($att_transacao === 2) {
        error_log("[EXPFYPAY WEBHOOK] Depósito já processado anteriormente: {$idTransaction}");
    } else {
        error_log("[EXPFYPAY WEBHOOK] Falha ao processar depósito: {$idTransaction} | status={$statusTransaction}");
    }
} else {
    error_log("[EXPFYPAY WEBHOOK] Ignorado | id={$idTransaction} | status={$statusTransaction} | payload=" . substr($raw, 0, 1200));
}
?>
