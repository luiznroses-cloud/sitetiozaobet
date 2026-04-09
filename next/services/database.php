<?php
date_default_timezone_set("America/Sao_Paulo");

if (!defined('SITE_URL')) {
    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') || $_SERVER['SERVER_PORT'] == 443 ? 'https://' : 'http://';
    define('SITE_URL', $protocol . $_SERVER['HTTP_HOST']);
}

if (!defined('DATABASE_LOADED')) {
    $bd = array(
        'local' => 'localhost',
        'usuario' => 'w1dev',
        'senha' => 'w1dev',
        'banco' => 'w1dev'
    );

    $mysqli = new mysqli($bd['local'], $bd['usuario'], $bd['senha'], $bd['banco']);
    if ($mysqli->connect_errno) {
        echo json_encode([
            'status' => 'error', 
            'message' => 'Erro: Arquivo de configuração do banco não encontrado.'
        ]);
        exit;
    }

    $mysqli->set_charset("utf8");
    define('DATABASE_LOADED', true);
}
?>