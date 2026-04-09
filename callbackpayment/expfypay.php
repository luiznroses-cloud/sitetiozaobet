<?php
session_start();
include_once "../config.php";
include_once('../' . DASH . '/services/database.php');
include_once('../' . DASH . '/services/funcao.php');
include_once('../' . DASH . '/services/crud.php');
include_once('../' . DASH . '/services/afiliacao.php');
global $mysqli;

header('Content-Type: application/json; charset=utf-8');

function expfyWebhookLog($etapa, $dados = [])
{
    $logFile = __DIR__ . '/expfypay_webhook_log.txt';
    $linha = '[' . date('Y-m-d H:i:s') . '] [' . $etapa . ']';
    if (!empty($dados)) {
        $json = json_encode($dados, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        if ($json !== false) {
            $linha .= ' ' . $json;
        }
    }
    file_put_contents($logFile, $linha . PHP_EOL, FILE_APPEND | LOCK_EX);
}

function responderWebhook($httpCode, $body)
{
    http_response_code($httpCode);
    echo json_encode($body, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function statusAprovadoExpfy($status)
{
    $status = strtolower(trim((string)$status));
    $status = str_replace([' ', '-'], '_', $status);
    return in_array($status, ['completed', 'completo', 'paid', 'paid_out', 'approved', 'success', 'confirmado'], true);
}

function resolverTransacaoPorExternalId($externalId)
{
    global $mysqli;

    $externalId = trim((string)$externalId);
    if ($externalId === '') {
        return '';
    }

    $sql = "SELECT transacao_id FROM gateway_expfypay_refs WHERE external_id = ? LIMIT 1";
    $stmt = $mysqli->prepare($sql);
    if (!$stmt) {
        expfyWebhookLog('ERRO_SQL_REF_PREPARE', ['erro' => $mysqli->error]);
        return '';
    }

    $stmt->bind_param("s", $externalId);
    $stmt->execute();
    $res = $stmt->get_result();
    $row = $res ? $res->fetch_assoc() : null;
    $stmt->close();

    return (string)($row['transacao_id'] ?? '');
}

function recortarTextoSeguro($texto, $limite)
{
    $texto = (string)$texto;
    $limite = (int)$limite;
    if ($limite <= 0) {
        return '';
    }
    if (function_exists('mb_substr')) {
        return mb_substr($texto, 0, $limite);
    }
    return substr($texto, 0, $limite);
}

// Bônus: usa getBonusForDeposit() e registrarBonusUsado() do services/bonus.php (fixo ou percentual)

function creditarDepositoExpfy($transacaoId)
{
    global $mysqli;

    $qry = "SELECT usuario, valor FROM transacoes WHERE transacao_id = ? AND tipo = 'deposito' LIMIT 1";
    $stmt = $mysqli->prepare($qry);
    if (!$stmt) {
        expfyWebhookLog('ERRO_SQL_SELECT_TRANSACAO_PREPARE', ['erro' => $mysqli->error, 'transacao_id' => $transacaoId]);
        return false;
    }

    $stmt->bind_param("s", $transacaoId);
    $stmt->execute();
    $res = $stmt->get_result();

    if (!$res || $res->num_rows === 0) {
        $stmt->close();
        expfyWebhookLog('TRANSACAO_NAO_ENCONTRADA', ['transacao_id' => $transacaoId]);
        return false;
    }

    $dataTransacao = $res->fetch_assoc();
    $stmt->close();

    $userId = (int)$dataTransacao['usuario'];
    $valorPago = (float)$dataTransacao['valor'];
    $bonusRecebido = (float)getBonusForDeposit($userId, $valorPago);
    $valorTotal = $valorPago + $bonusRecebido;

    expfyWebhookLog('CREDITO_INICIADO', [
        'transacao_id' => $transacaoId,
        'user_id' => $userId,
        'valor_pago' => $valorPago,
        'bonus' => $bonusRecebido,
        'valor_total' => $valorTotal
    ]);

    $saldoOk = adicionarSaldoUsuario($userId, $valorTotal);
    if (!$saldoOk) {
        expfyWebhookLog('ERRO_CREDITAR_SALDO', ['transacao_id' => $transacaoId, 'user_id' => $userId]);
        return false;
    }

    if ($bonusRecebido > 0) {
        registrarBonusUsado($userId, $valorPago, $bonusRecebido);
    }

    processarTodasComissoes($userId, $valorPago);

    $qryUser = "SELECT mobile AS nome FROM usuarios WHERE id = ? LIMIT 1";
    $stmtUser = $mysqli->prepare($qryUser);
    if ($stmtUser) {
        $stmtUser->bind_param("i", $userId);
        $stmtUser->execute();
        $resUser = $stmtUser->get_result();
        $userData = $resUser ? $resUser->fetch_assoc() : null;
        $stmtUser->close();
        WebhookPixPagos($userData['nome'] ?? 'Usuario', $_SERVER['HTTP_HOST'], $valorPago);
    }

    expfyWebhookLog('CREDITO_FINALIZADO', [
        'transacao_id' => $transacaoId,
        'user_id' => $userId,
        'valor_pago' => $valorPago
    ]);

    return true;
}

function atualizarPagamentoPixExpfy($transacaoId)
{
    global $mysqli;

    $qryCheck = "SELECT status FROM transacoes WHERE transacao_id = ? AND tipo = 'deposito' LIMIT 1";
    $stmtCheck = $mysqli->prepare($qryCheck);
    if (!$stmtCheck) {
        expfyWebhookLog('ERRO_SQL_CHECK_PREPARE', ['erro' => $mysqli->error, 'transacao_id' => $transacaoId]);
        return 0;
    }

    $stmtCheck->bind_param("s", $transacaoId);
    $stmtCheck->execute();
    $resCheck = $stmtCheck->get_result();

    if (!$resCheck || $resCheck->num_rows === 0) {
        $stmtCheck->close();
        return 0;
    }

    $trans = $resCheck->fetch_assoc();
    $stmtCheck->close();
    $statusAtual = strtolower(trim((string)($trans['status'] ?? '')));
    if ($statusAtual === 'pago' || $statusAtual === '1') {
        return 2;
    }

    $sql = $mysqli->prepare("UPDATE transacoes SET status = 'pago' WHERE transacao_id = ? AND tipo = 'deposito'");
    if (!$sql) {
        expfyWebhookLog('ERRO_SQL_UPDATE_PREPARE', ['erro' => $mysqli->error, 'transacao_id' => $transacaoId]);
        return 0;
    }

    $sql->bind_param("s", $transacaoId);
    $ok = $sql->execute();
    $linhas = $sql->affected_rows;
    if (!$ok) {
        expfyWebhookLog('ERRO_SQL_UPDATE_EXECUTE', ['erro' => $sql->error, 'transacao_id' => $transacaoId]);
    }
    $sql->close();

    if ($ok && $linhas > 0) {
        return creditarDepositoExpfy($transacaoId) ? 1 : 0;
    }

    return 0;
}

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        expfyWebhookLog('METODO_INVALIDO', ['metodo' => $_SERVER['REQUEST_METHOD'] ?? '']);
        responderWebhook(200, ['success' => false, 'message' => 'Metodo invalido']);
    }

    $raw = file_get_contents('php://input');
    $data = json_decode($raw, true);

    if (!is_array($data)) {
        if (!empty($_POST)) {
            $data = $_POST;
        } else {
            parse_str((string)$raw, $formData);
            $data = is_array($formData) ? $formData : [];
        }
    }

    expfyWebhookLog('PAYLOAD_RECEBIDO', [
        'ip' => $_SERVER['REMOTE_ADDR'] ?? '',
        'raw' => recortarTextoSeguro($raw, 4000),
        'json_ok' => is_array($data)
    ]);

    if (empty($data) || !is_array($data)) {
        expfyWebhookLog('PAYLOAD_INVALIDO', ['raw' => recortarTextoSeguro($raw, 1000)]);
        responderWebhook(200, ['success' => false, 'message' => 'Payload invalido']);
    }

    $payload = is_array($data['data'] ?? null) ? $data['data'] : [];
    $payment = is_array($data['payment'] ?? null) ? $data['payment'] : [];
    $pixData = is_array($data['pix_data'] ?? null) ? $data['pix_data'] : [];

    // Prioriza transaction_id (que e o ID salvo no banco na criacao do QR)
    // e usa external_id como fallback para compatibilidade.
    $externalIdRaw = (string)($data['external_id'] ?? $payload['external_id'] ?? $payment['external_id'] ?? '');
    $transacaoLocalRaw = '';
    $transactionGatewayRaw = (string)($data['transaction_id'] ?? $payload['transaction_id'] ?? $payment['transaction_id'] ?? '');
    $statusRaw = (string)($data['status'] ?? $data['payment_status'] ?? $payload['status'] ?? $payment['status'] ?? '');
    $valorRaw = $data['amount'] ?? $payload['amount'] ?? $payment['amount'] ?? 0;

    $externalId = PHP_SEGURO($externalIdRaw);
    $transacaoLocal = PHP_SEGURO($transacaoLocalRaw);
    $transactionGateway = PHP_SEGURO($transactionGatewayRaw);
    $status = strtolower(trim(PHP_SEGURO($statusRaw)));
    $valor = (float)$valorRaw;

    expfyWebhookLog('DADOS_NORMALIZADOS', [
        'external_id' => $externalId,
        'transacao_local' => $transacaoLocal,
        'transaction_gateway' => $transactionGateway,
        'status' => $status,
        'amount' => $valor,
        'end2end_id' => $pixData['end2end_id'] ?? '',
        'receipt_url' => $pixData['receipt_url'] ?? ''
    ]);

    if (empty($externalId)) {
        expfyWebhookLog('SEM_EXTERNAL_ID', [
            'transaction_gateway' => $transactionGateway,
            'status' => $status
        ]);
        responderWebhook(200, ['success' => false, 'message' => 'External ID nao informado']);
    }

    $transacaoLocal = resolverTransacaoPorExternalId($externalId);
    if (empty($transacaoLocal)) {
        expfyWebhookLog('EXTERNAL_ID_NAO_MAPEADO', [
            'external_id' => $externalId,
            'transaction_gateway' => $transactionGateway,
            'status' => $status
        ]);
        responderWebhook(200, ['success' => false, 'message' => 'Referencia do pagamento nao encontrada']);
    }

    if (!statusAprovadoExpfy($status)) {
        expfyWebhookLog('STATUS_IGNORADO', [
            'transacao_local' => $transacaoLocal,
            'transaction_gateway' => $transactionGateway,
            'status' => $status
        ]);
        responderWebhook(200, ['success' => true, 'message' => 'Status recebido sem acao']);
    }

    $resultado = atualizarPagamentoPixExpfy($transacaoLocal);
    if ($resultado === 1) {
        expfyWebhookLog('WEBHOOK_PROCESSADO', ['transacao_local' => $transacaoLocal, 'status' => $status]);
        responderWebhook(200, ['success' => true, 'message' => 'Pagamento processado com sucesso']);
    }

    if ($resultado === 2) {
        expfyWebhookLog('WEBHOOK_IDEMPOTENTE', ['transacao_local' => $transacaoLocal, 'status' => $status]);
        responderWebhook(200, ['success' => true, 'message' => 'Pagamento ja processado']);
    }

    expfyWebhookLog('ERRO_PROCESSAMENTO', [
        'transacao_local' => $transacaoLocal,
        'transaction_gateway' => $transactionGateway,
        'status' => $status
    ]);
    responderWebhook(200, ['success' => false, 'message' => 'Falha ao processar pagamento']);
} catch (Throwable $e) {
    expfyWebhookLog('EXCEPTION', [
        'message' => $e->getMessage(),
        'file' => $e->getFile(),
        'line' => $e->getLine()
    ]);
    responderWebhook(200, ['success' => false, 'message' => 'Erro interno no webhook']);
}
?>
