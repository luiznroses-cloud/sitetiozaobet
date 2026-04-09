<?php
/**
 * Script de Backup do Banco de Dados
 * 
 * Uso via linha de comando:
 * php backup_database.php
 * 
 * Uso via navegador (com autenticação recomendada):
 * Acesse: /backups/backup_database.php
 */

date_default_timezone_set("America/Sao_Paulo");

// Configurações do banco de dados
$bd = array(
    'local' => 'localhost',
    'usuario' => '77piaui7',
    'senha' => '77piaui777piaui7',
    'banco' => '77piaui7'
);

// Diretório de destino dos backups
$backup_dir = __DIR__ . '/database';

// Criar diretório se não existir
if (!is_dir($backup_dir)) {
    mkdir($backup_dir, 0755, true);
}

// Nome do arquivo de backup com timestamp
$timestamp = date('Ymd_His');
$backup_file = $backup_dir . '/backup_db_' . $timestamp . '.sql';
$backup_file_gz = $backup_file . '.gz';

// Comando mysqldump
$command = sprintf(
    'mysqldump -u %s -p%s %s > %s 2>&1',
    escapeshellarg($bd['usuario']),
    escapeshellarg($bd['senha']),
    escapeshellarg($bd['banco']),
    escapeshellarg($backup_file)
);

// Executar backup
exec($command, $output, $return_var);

if ($return_var !== 0) {
    $error = [
        'success' => false,
        'message' => 'Erro ao criar backup do banco de dados',
        'error' => implode("\n", $output),
        'timestamp' => $timestamp
    ];
    
    if (php_sapi_name() === 'cli') {
        echo json_encode($error, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n";
    } else {
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($error, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    }
    exit(1);
}

// Verificar se o arquivo foi criado
if (!file_exists($backup_file)) {
    $error = [
        'success' => false,
        'message' => 'Arquivo de backup não foi criado',
        'timestamp' => $timestamp
    ];
    
    if (php_sapi_name() === 'cli') {
        echo json_encode($error, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n";
    } else {
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($error, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    }
    exit(1);
}

// Compactar o backup
exec("gzip " . escapeshellarg($backup_file), $gzip_output, $gzip_return);

$file_size = filesize($backup_file_gz);
$file_size_mb = round($file_size / 1024 / 1024, 2);

// Resultado do backup
$result = [
    'success' => true,
    'message' => 'Backup criado com sucesso',
    'file' => basename($backup_file_gz),
    'path' => $backup_file_gz,
    'size' => $file_size_mb . ' MB',
    'timestamp' => $timestamp,
    'date' => date('d/m/Y H:i:s')
];

// Log do backup
$log_file = __DIR__ . '/backup_log.txt';
$log_entry = date('Y-m-d H:i:s') . " - Backup criado: " . basename($backup_file_gz) . " (" . $file_size_mb . " MB)\n";
file_put_contents($log_file, $log_entry, FILE_APPEND);

// Exibir resultado
if (php_sapi_name() === 'cli') {
    echo json_encode($result, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n";
} else {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($result, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
}
?>


