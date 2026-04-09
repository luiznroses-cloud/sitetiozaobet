<?php
session_start();
include_once "../config.php";
include_once('../'.DASH.'/services/database.php');
include_once('../'.DASH.'/services/funcao.php');
include_once('../'.DASH.'/services/crud.php');
include_once('../'.DASH.'/services/afiliacao.php');
include_once('../'.DASH.'/services/webhook.php');
global $mysqli;

$data = json_decode(file_get_contents("php://input"), true);
if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
    http_response_code(400);
    exit;
}

$idTransaction = PHP_SEGURO($data['requestBody']['transactionId']);
$typeTransaction = PHP_SEGURO($data['requestBody']['paymentType']);
$statusTransaction = PHP_SEGURO($data['requestBody']['status']);

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

/**
 * Verifica se existe bônus ativo para o valor e se o usuário ainda não usou
 * Usa getBonusForDeposit() do services/bonus.php (fixo ou percentual)
 */

function busca_valor_ipn($transacao_id){
    global $mysqli;
    
    $qry = "SELECT usuario, valor FROM transacoes WHERE transacao_id='" . $transacao_id . "'";
    $res = mysqli_query($mysqli, $qry);
    
    if (mysqli_num_rows($res) > 0) {
        $data = mysqli_fetch_assoc($res);
        $userId = $data['usuario'];
        $valorPago = $data['valor'];
        
        // VERIFICAR E APLICAR BÔNUS
        $bonusRecebido = getBonusForDeposit($userId, $valorPago);
        $valorTotal = $valorPago + $bonusRecebido;
        
        // Creditar o valor total (depósito + bônus)
        $retorna_insert_saldo = adicionarSaldoUsuario($userId, $valorTotal);
        
        // Se creditou com sucesso
        if ($retorna_insert_saldo) {
            // Registrar o uso do bônus (se houver)
            if ($bonusRecebido > 0) {
                registrarBonusUsado($userId, $valorPago, $bonusRecebido);
                
                // Log para debug
                error_log("BÔNUS APLICADO - User: {$userId} | Depósito: R$ {$valorPago} | Bônus: R$ {$bonusRecebido} | Total: R$ {$valorTotal}");
            }
            
            // Processar comissões de afiliação (usando o valor PAGO, não o total com bônus)
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

// Processar pagamentos PIX confirmados
if (isset($idTransaction) && $typeTransaction == "PIX" && ($statusTransaction == "PAID" || $statusTransaction == "UNPAID")) {
    $att_transacao = att_paymentpix($idTransaction);
}
?>