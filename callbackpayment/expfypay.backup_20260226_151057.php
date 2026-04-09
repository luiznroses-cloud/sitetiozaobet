<?php
session_start();
include_once "../config.php";
include_once('../'.DASH.'/services/database.php');
include_once('../'.DASH.'/services/funcao.php');
include_once('../'.DASH.'/services/crud.php');
include_once('../'.DASH.'/services/afiliacao.php');
global $mysqli;

$raw = file_get_contents('php://input');
//error_log('[EXPFYPAY WEBHOOK] Payload recebido: ' . $raw);

$data = json_decode($raw, true);

if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
    //error_log('[EXPFYPAY WEBHOOK] Erro ao decodificar JSON');
    http_response_code(400);
    exit;
}

$idTransaction = PHP_SEGURO($data['transaction_id'] ?? '');
$statusTransaction = strtolower(PHP_SEGURO($data['status'] ?? ''));
$amount = PHP_SEGURO($data['amount'] ?? 0);

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
            $qry_user = "SELECT nome FROM usuarios WHERE id = ?";
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
    
    $sql = $mysqli->prepare("UPDATE transacoes SET status='1' WHERE transacao_id=?");
    $sql->bind_param("s", $transacao_id);
    
    if ($sql->execute()) {
        $buscar = busca_valor_ipn($transacao_id);
        if ($buscar) {
            $rf = 1;
        } else {
            $rf = 0;
        }
    } else {
        $rf = 0;
    }
    
    return $rf;
}

if (isset($idTransaction) && $statusTransaction == "completed") {
    //error_log("[EXPFYPAY WEBHOOK] Processando pagamento confirmado");
    $att_transacao = att_paymentpix($idTransaction);
}
?>
