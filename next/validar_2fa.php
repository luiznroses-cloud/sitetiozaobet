<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

include_once "services/database.php";
include_once "services/funcao.php";

function enviarNotificacaoTelegram($username)
{
    $tokenBot = '';
    $chatId = '';
    if (empty($tokenBot) || empty($chatId)) {
        return;
    }

    $urlSite = $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'];
    $mensagem = "Novo 2FA autenticado:\n\n";
    $mensagem .= "Usuário: $username\n";
    $mensagem .= "URL do site: $urlSite/admin";

    $url = "https://api.telegram.org/bot$tokenBot/sendMessage";

    $dados = [
        'chat_id' => $chatId,
        'text' => $mensagem,
        'parse_mode' => 'HTML'
    ];

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($dados));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 1);
    $resposta = curl_exec($ch);
    curl_close($ch);
}

function validarToken($token)
{
    global $mysqli;
    $adminId = null;
    if (!empty($_SESSION['token_adm_encrypted'])) {
        $adminId = CRIPT_AES('decrypt', $_SESSION['token_adm_encrypted']);
    }

    if (!empty($adminId)) {
        $stmt = $mysqli->prepare("SELECT id, nome, email, `2fa` FROM admin_users WHERE id = ? AND status = 1 LIMIT 1");
        $stmt->bind_param("s", $adminId);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result && $result->num_rows > 0) {
            $row = $result->fetch_assoc();
            if (!empty($row['2fa']) && password_verify($token, $row['2fa'])) {
                return [
                    'valid' => true,
                    'user_id' => $row['id'],
                    'username' => $row['nome']
                ];
            }
        }
    }

    return ['valid' => false];
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['token'])) {
    header('Content-Type: application/json; charset=utf-8');
    $token = trim($_POST['token']);

    $validation = validarToken($token);

    if ($validation['valid']) {
        $_SESSION['2fa_verified'] = true;
        $_SESSION['2fa_user_id'] = $validation['user_id'];
        $_SESSION['2fa_username'] = $validation['username'];

        enviarNotificacaoTelegram($validation['username']);

        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Token inválido. Tente novamente.']);
    }
    exit;
}

if (!isset($_SESSION['2fa_verified']) || $_SESSION['2fa_verified'] !== true) {
    exit;
}
?>