<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
session_start();
include_once(__DIR__ . '/services/database.php');
include_once(__DIR__ . '/services/funcao.php');
include_once(__DIR__ . '/services/crud.php');
include_once(__DIR__ . '/services/crud-adm.php');
include_once(__DIR__ . '/services/checa_login_adm.php');
checa_login_adm();
$action = isset($_GET['action']) ? $_GET['action'] : '';
function igw_providers()
{
    global $data_igamewin;
    header('Content-Type: application/json');
    if (!$data_igamewin || empty($data_igamewin['agent_code']) || empty($data_igamewin['agent_token']) || empty($data_igamewin['url'])) {
        echo json_encode(['status' => 0, 'msg' => 'Configuração iGameWin ausente']);
        return;
    }
    $payload = [
        'method' => 'provider_list',
        'agent_code' => trim($data_igamewin['agent_code']),
        'agent_token' => trim($data_igamewin['agent_token'])
    ];
    $resp = enviarRequest_PAYMENT(trim($data_igamewin['url']), ['Content-Type: application/json'], $payload);
    if (!$resp) {
        echo json_encode(['status' => 0, 'msg' => 'Sem resposta']);
        return;
    }
    echo $resp;
}
function pf_providers()
{
    global $data_playfiver;
    header('Content-Type: application/json');
    if (!$data_playfiver || empty($data_playfiver['agent_token']) || empty($data_playfiver['agent_secret']) || empty($data_playfiver['url'])) {
        echo json_encode(['status' => 0, 'msg' => 'Configuração PlayFiver ausente']);
        return;
    }
    $base = rtrim($data_playfiver['url'], '/');
    $qs = http_build_query([
        'agentToken' => $data_playfiver['agent_token'],
        'secretKey' => $data_playfiver['agent_secret']
    ]);
    $url = $base . '/api/v2/providers?' . $qs;
    $resp = enviarRequest_PAYMENT($url, ['Content-Type: application/json'], null);
    if (!$resp) {
        echo json_encode(['status' => 0, 'msg' => 'Sem resposta']);
        return;
    }
    echo $resp;
}
function igw_games($provider_code = null)
{
    global $data_igamewin;
    header('Content-Type: application/json');
    if (!$data_igamewin || empty($data_igamewin['agent_code']) || empty($data_igamewin['agent_token']) || empty($data_igamewin['url'])) {
        echo json_encode(['status' => 0, 'msg' => 'Configuração iGameWin ausente']);
        return;
    }
    $payload = [
        'method' => 'game_list',
        'agent_code' => trim($data_igamewin['agent_code']),
        'agent_token' => trim($data_igamewin['agent_token'])
    ];
    if (!empty($provider_code)) {
        $payload['provider_code'] = $provider_code;
    }
    $resp = enviarRequest_PAYMENT(trim($data_igamewin['url']), ['Content-Type: application/json'], $payload);
    if (!$resp) {
        echo json_encode(['status' => 0, 'msg' => 'Sem resposta']);
        return;
    }
    echo $resp;
}
function pf_games($pf_provider = null)
{
    global $data_playfiver;
    header('Content-Type: application/json');
    if (!$data_playfiver || empty($data_playfiver['agent_token']) || empty($data_playfiver['agent_secret']) || empty($data_playfiver['url'])) {
        echo json_encode(['status' => 0, 'msg' => 'Configuração PlayFiver ausente']);
        return;
    }
    $params = [
        'agentToken' => $data_playfiver['agent_token'],
        'secretKey' => $data_playfiver['agent_secret']
    ];
    if (!empty($pf_provider)) {
        $params['provider'] = $pf_provider;
    }
    $base = rtrim($data_playfiver['url'], '/');
    $url = $base . '/api/v2/games?' . http_build_query($params);
    $resp = enviarRequest_PAYMENT($url, ['Content-Type: application/json'], null);
    if (!$resp) {
        echo json_encode(['status' => 0, 'msg' => 'Sem resposta']);
        return;
    }
    echo $resp;
}
function games_available($pf_provider = null)
{
    global $mysqli, $data_playfiver;
    header('Content-Type: application/json');
    if (!$data_playfiver || empty($data_playfiver['agent_token']) || empty($data_playfiver['agent_secret']) || empty($data_playfiver['url'])) {
        echo json_encode(['status' => 0, 'msg' => 'Configuração PlayFiver ausente']);
        return;
    }
    $params = [
        'agentToken' => $data_playfiver['agent_token'],
        'secretKey' => $data_playfiver['agent_secret']
    ];
    if (!empty($pf_provider)) {
        $params['provider'] = $pf_provider;
    }
    $base = rtrim($data_playfiver['url'], '/');
    $url = $base . '/api/v2/games?' . http_build_query($params);
    $resp = enviarRequest_PAYMENT($url, ['Content-Type: application/json'], null);
    if (!$resp) {
        echo json_encode(['status' => 0, 'msg' => 'Sem resposta']);
        return;
    }
    $data = json_decode($resp, true);
    if (!is_array($data)) {
        echo json_encode(['status' => 0, 'msg' => 'Resposta inválida']);
        return;
    }
    $list = [];
    if (isset($data['data']) && is_array($data['data'])) {
        $list = $data['data'];
    } elseif (isset($data['games']) && is_array($data['games'])) {
        $list = $data['games'];
    }
    $existingNames = [];
    $existingCodes = [];
    $resE = $mysqli->query("SELECT game_name, game_code FROM games");
    if ($resE) {
        while ($row = $resE->fetch_assoc()) {
            if (isset($row['game_name'])) {
                $existingNames[strtolower(trim($row['game_name']))] = true;
            }
            if (isset($row['game_code'])) {
                $existingCodes[strtolower(trim($row['game_code']))] = true;
            }
        }
    }
    $filtered = [];
    foreach ($list as $g) {
        $code = '';
        $name = '';
        if (is_array($g)) {
            $code = isset($g['game_code']) ? $g['game_code'] : (isset($g['code']) ? $g['code'] : (isset($g['id']) ? $g['id'] : ''));
            $name = isset($g['game_name']) ? $g['game_name'] : (isset($g['name']) ? $g['name'] : '');
        }
        $codeKey = strtolower(trim($code));
        $nameKey = strtolower(trim($name));
        if (($nameKey !== '' && isset($existingNames[$nameKey])) || ($codeKey !== '' && isset($existingCodes[$codeKey]))) {
            continue;
        }
        $filtered[] = $g;
    }
    echo json_encode(['status' => 1, 'data' => $filtered]);
}
function games_available_igw($provider_code = null)
{
    global $mysqli, $data_igamewin;
    header('Content-Type: application/json');
    if (!$data_igamewin || empty($data_igamewin['agent_code']) || empty($data_igamewin['agent_token']) || empty($data_igamewin['url'])) {
        echo json_encode(['status' => 0, 'msg' => 'Configuração iGameWin ausente']);
        return;
    }
    $payload = [
        'method' => 'game_list',
        'agent_code' => trim($data_igamewin['agent_code']),
        'agent_token' => trim($data_igamewin['agent_token'])
    ];
    if (!empty($provider_code)) {
        $payload['provider_code'] = $provider_code;
    }
    $resp = enviarRequest_PAYMENT(trim($data_igamewin['url']), ['Content-Type: application/json'], $payload);
    if (!$resp) {
        echo json_encode(['status' => 0, 'msg' => 'Sem resposta']);
        return;
    }
    $data = json_decode($resp, true);
    if (!is_array($data)) {
        echo json_encode(['status' => 0, 'msg' => 'Resposta inválida']);
        return;
    }
    $list = [];
    if (isset($data['games']) && is_array($data['games'])) {
        $list = $data['games'];
    } elseif (isset($data['data']) && is_array($data['data'])) {
        $list = $data['data'];
    }
    $existingNames = [];
    $existingCodes = [];
    $resE = $mysqli->query("SELECT game_name, game_code FROM games");
    if ($resE) {
        while ($row = $resE->fetch_assoc()) {
            if (isset($row['game_name'])) {
                $existingNames[strtolower(trim($row['game_name']))] = true;
            }
            if (isset($row['game_code'])) {
                $existingCodes[strtolower(trim($row['game_code']))] = true;
            }
        }
    }
    $filtered = [];
    foreach ($list as $g) {
        $code = '';
        $name = '';
        if (is_array($g)) {
            $code = isset($g['game_code']) ? $g['game_code'] : (isset($g['code']) ? $g['code'] : (isset($g['id']) ? $g['id'] : ''));
            $name = isset($g['game_name']) ? $g['game_name'] : (isset($g['name']) ? $g['name'] : '');
        }
        $codeKey = strtolower(trim($code));
        $nameKey = strtolower(trim($name));
        if (($nameKey !== '' && isset($existingNames[$nameKey])) || ($codeKey !== '' && isset($existingCodes[$codeKey]))) {
            continue;
        }
        $filtered[] = $g;
    }
    echo json_encode(['status' => 1, 'data' => $filtered]);
}
function insert_playfiver_games($localProvider, $pf_provider = null)
{
    global $data_playfiver, $mysqli;
    header('Content-Type: application/json');
    $sanitizeBanner = function($url){
        if ($url === null) return null;
        $u = trim($url);
        $u = trim($u, " \t\n\r\0\x0B\"'`");
        return $u;
    };

    $nextAvailableId = function() use ($mysqli){
        $sqlGap = "SELECT t1.id+1 AS next_id 
                   FROM games t1 
                   LEFT JOIN games t2 ON t2.id = t1.id+1 
                   WHERE t2.id IS NULL 
                   ORDER BY t1.id ASC 
                   LIMIT 1";
        $resGap = $mysqli->query($sqlGap);
        if ($resGap && ($rowGap = $resGap->fetch_assoc()) && !empty($rowGap['next_id'])) {
            $candidate = intval($rowGap['next_id']);
            $chk = $mysqli->prepare("SELECT 1 FROM games WHERE id = ? LIMIT 1");
            $chk->bind_param("i", $candidate);
            $chk->execute();
            $exists = $chk->get_result()->num_rows > 0;
            $chk->close();
            if (!$exists) return $candidate;
        }
        $resMax = $mysqli->query("SELECT COALESCE(MAX(id),0) AS mx FROM games");
        $mx = 0;
        if ($resMax && ($rowMax = $resMax->fetch_assoc())) {
            $mx = intval($rowMax['mx']);
        }
        return $mx + 1;
    };
    if (!$data_playfiver || empty($data_playfiver['agent_token']) || empty($data_playfiver['agent_secret']) || empty($data_playfiver['url'])) {
        echo json_encode(['status' => 0, 'msg' => 'Configuração PlayFiver ausente']);
        return;
    }
    if (empty($localProvider)) {
        echo json_encode(['status' => 0, 'msg' => 'Parâmetro provider requerido']);
        return;
    }
    $params = [
        'agentToken' => $data_playfiver['agent_token'],
        'secretKey' => $data_playfiver['agent_secret']
    ];
    if (!empty($pf_provider)) {
        $params['provider'] = $pf_provider;
    }
    $base = rtrim($data_playfiver['url'], '/');
    $url = $base . '/api/v2/games?' . http_build_query($params);
    $resp = enviarRequest_PAYMENT($url, ['Content-Type: application/json'], null);
    if (!$resp) {
        echo json_encode(['status' => 0, 'msg' => 'Sem resposta']);
        return;
    }
    $data = json_decode($resp, true);
    if (!is_array($data)) {
        echo json_encode(['status' => 0, 'msg' => 'Resposta inválida']);
        return;
    }
    $list = [];
    if (isset($data['data']) && is_array($data['data'])) {
        $list = $data['data'];
    } elseif (isset($data['games']) && is_array($data['games'])) {
        $list = $data['games'];
    }
    if (!is_array($list) || count($list) === 0) {
        echo json_encode(['status' => 1, 'inserted' => 0, 'updated' => 0, 'skipped' => 0, 'count' => 0]);
        return;
    }
    $inserted = 0;
    $updated = 0;
    $skipped = 0;
    foreach ($list as $g) {
        $code = '';
        $name = '';
        $banner = null;
        if (is_array($g)) {
            $code = isset($g['game_code']) ? $g['game_code'] : (isset($g['code']) ? $g['code'] : (isset($g['id']) ? $g['id'] : ''));
            $name = isset($g['game_name']) ? $g['game_name'] : (isset($g['name']) ? $g['name'] : '');
            $banner = isset($g['banner']) ? $g['banner'] : (
                isset($g['image']) ? $g['image'] : (
                    isset($g['image_url']) ? $g['image_url'] : (
                        isset($g['thumb']) ? $g['thumb'] : (
                            isset($g['thumbnail']) ? $g['thumbnail'] : null
                        )
                    )
                )
            );
            $banner = $sanitizeBanner($banner);
        }
        if ($code === '' || $name === '') {
            $skipped++;
            continue;
        }
        $stmt = $mysqli->prepare("SELECT 1 FROM games WHERE LOWER(game_name) = LOWER(?) OR LOWER(game_code) = LOWER(?) LIMIT 1");
        $stmt->bind_param("ss", $name, $code);
        $stmt->execute();
        $res = $stmt->get_result();
        if ($res && $res->num_rows > 0) {
            $skipped++;
            $stmt->close();
            continue;
        } else {
            $stmt->close();
            $status = 1;
            $popular = 0;
            $type = 'slot';
            $game_type = '3';
            $api = 'PlayFiver';
            // Sempre inserir com ID explícito, ocupando a próxima lacuna
            $nextId = $nextAvailableId();
            $stmt3 = $mysqli->prepare("INSERT INTO games (id, game_code, game_name, banner, status, provider, popular, type, game_type, api) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt3->bind_param("isssisssss", $nextId, $code, $name, $banner, $status, $localProvider, $popular, $type, $game_type, $api);
            if ($stmt3->execute()) {
                $inserted++;
            } else {
                $skipped++;
            }
            $stmt3->close();
        }
    }
    echo json_encode(['status' => 1, 'inserted' => $inserted, 'updated' => $updated, 'skipped' => $skipped, 'count' => count($list)]);
}
function insert_igw_games($localProvider, $provider_code = null)
{
    global $data_igamewin, $mysqli;
    header('Content-Type: application/json');
    $sanitizeBanner = function($url){
        if ($url === null) return null;
        $u = trim($url);
        $u = trim($u, " \t\n\r\0\x0B\"'`");
        return $u;
    };
    $nextAvailableId = function() use ($mysqli){
        $sqlGap = "SELECT t1.id+1 AS next_id 
                   FROM games t1 
                   LEFT JOIN games t2 ON t2.id = t1.id+1 
                   WHERE t2.id IS NULL 
                   ORDER BY t1.id ASC 
                   LIMIT 1";
        $resGap = $mysqli->query($sqlGap);
        if ($resGap && ($rowGap = $resGap->fetch_assoc()) && !empty($rowGap['next_id'])) {
            $candidate = intval($rowGap['next_id']);
            $chk = $mysqli->prepare("SELECT 1 FROM games WHERE id = ? LIMIT 1");
            $chk->bind_param("i", $candidate);
            $chk->execute();
            $exists = $chk->get_result()->num_rows > 0;
            $chk->close();
            if (!$exists) return $candidate;
        }
        $resMax = $mysqli->query("SELECT COALESCE(MAX(id),0) AS mx FROM games");
        $mx = 0;
        if ($resMax && ($rowMax = $resMax->fetch_assoc())) {
            $mx = intval($rowMax['mx']);
        }
        return $mx + 1;
    };
    if (!$data_igamewin || empty($data_igamewin['agent_code']) || empty($data_igamewin['agent_token']) || empty($data_igamewin['url'])) {
        echo json_encode(['status' => 0, 'msg' => 'Configuração iGameWin ausente']);
        return;
    }
    if (empty($localProvider)) {
        echo json_encode(['status' => 0, 'msg' => 'Parâmetro provider requerido']);
        return;
    }
    $payload = [
        'method' => 'game_list',
        'agent_code' => trim($data_igamewin['agent_code']),
        'agent_token' => trim($data_igamewin['agent_token'])
    ];
    if (!empty($provider_code)) {
        $payload['provider_code'] = $provider_code;
    }
    $resp = enviarRequest_PAYMENT(trim($data_igamewin['url']), ['Content-Type: application/json'], $payload);
    if (!$resp) {
        echo json_encode(['status' => 0, 'msg' => 'Sem resposta']);
        return;
    }
    $data = json_decode($resp, true);
    if (!is_array($data)) {
        echo json_encode(['status' => 0, 'msg' => 'Resposta inválida']);
        return;
    }
    $list = [];
    if (isset($data['games']) && is_array($data['games'])) {
        $list = $data['games'];
    } elseif (isset($data['data']) && is_array($data['data'])) {
        $list = $data['data'];
    }
    if (!is_array($list) || count($list) === 0) {
        echo json_encode(['status' => 1, 'inserted' => 0, 'updated' => 0, 'skipped' => 0, 'count' => 0]);
        return;
    }
    $inserted = 0;
    $updated = 0;
    $skipped = 0;
    foreach ($list as $g) {
        $code = '';
        $name = '';
        $banner = null;
        if (is_array($g)) {
            $code = isset($g['game_code']) ? $g['game_code'] : (isset($g['code']) ? $g['code'] : (isset($g['id']) ? $g['id'] : ''));
            $name = isset($g['game_name']) ? $g['game_name'] : (isset($g['name']) ? $g['name'] : '');
            $banner = isset($g['banner']) ? $g['banner'] : (
                isset($g['image']) ? $g['image'] : (
                    isset($g['image_url']) ? $g['image_url'] : (
                        isset($g['thumb']) ? $g['thumb'] : (
                            isset($g['thumbnail']) ? $g['thumbnail'] : null
                        )
                    )
                )
            );
            $banner = $sanitizeBanner($banner);
        }
        if ($code === '' || $name === '') {
            $skipped++;
            continue;
        }
        $stmt = $mysqli->prepare("SELECT 1 FROM games WHERE LOWER(game_name) = LOWER(?) OR LOWER(game_code) = LOWER(?) LIMIT 1");
        $stmt->bind_param("ss", $name, $code);
        $stmt->execute();
        $res = $stmt->get_result();
        if ($res && $res->num_rows > 0) {
            $skipped++;
            $stmt->close();
            continue;
        } else {
            $stmt->close();
            $status = 1;
            $popular = 0;
            $type = 'slot';
            $game_type = '3';
            $api = 'iGameWin';
            $nextId = $nextAvailableId();
            $stmt3 = $mysqli->prepare("INSERT INTO games (id, game_code, game_name, banner, status, provider, popular, type, game_type, api) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt3->bind_param("isssisssss", $nextId, $code, $name, $banner, $status, $localProvider, $popular, $type, $game_type, $api);
            if ($stmt3->execute()) {
                $inserted++;
            } else {
                $skipped++;
            }
            $stmt3->close();
        }
    }
    echo json_encode(['status' => 1, 'inserted' => $inserted, 'updated' => $updated, 'skipped' => $skipped, 'count' => count($list)]);
}
if ($action === 'providers') {
    $api = isset($_GET['api']) ? $_GET['api'] : 'PlayFiver';
    if (strtolower($api) === 'igamewin') {
        igw_providers();
    } else {
        pf_providers();
    }
    exit;
}
if ($action === 'games') {
    $api = isset($_GET['api']) ? $_GET['api'] : 'PlayFiver';
    $pf_provider = isset($_GET['provider']) ? $_GET['provider'] : (isset($_GET['pf_provider']) ? $_GET['pf_provider'] : null);
    if (strtolower($api) === 'igamewin') {
        igw_games($pf_provider);
    } else {
        pf_games($pf_provider);
    }
    exit;
}
if ($action === 'games_available') {
    $api = isset($_GET['api']) ? $_GET['api'] : 'PlayFiver';
    $pf_provider = isset($_GET['pf_provider']) ? $_GET['pf_provider'] : null;
    if (strtolower($api) === 'igamewin') {
        games_available_igw($pf_provider);
    } else {
        games_available($pf_provider);
    }
    exit;
}
if ($action === 'insert') {
    $api = isset($_GET['api']) ? $_GET['api'] : 'PlayFiver';
    $localProvider = isset($_GET['provider']) ? $_GET['provider'] : '';
    $pf_provider = isset($_GET['pf_provider']) ? $_GET['pf_provider'] : null;
    if (strtolower($api) === 'igamewin') {
        insert_igw_games($localProvider, $pf_provider);
    } else {
        insert_playfiver_games($localProvider, $pf_provider);
    }
    exit;
}
?>
<?php include 'partials/html.php' ?>
<head>
    <?php $title = "Capturar Jogos"; ?>
    <?php include 'partials/title-meta.php' ?>
    <?php include 'partials/head-css.php' ?>
</head>
<body>
    <?php include 'partials/topbar.php' ?>
    <?php include 'partials/startbar.php' ?>
    <div class="page-wrapper">
        <div class="page-content">
            <div class="container-xxl">
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h4 class="card-title mb-0">Capturar Jogos</h4>
                            </div>
                            <div class="card-body">
                                <div class="row g-3 mb-3">
                                    <div class="col-12 col-md-3">
                                        <label class="form-label">API</label>
                                        <select id="apiSelect" class="form-select">
                                            <option value="PlayFiver">PlayFiver</option>
                                            <option value="iGameWin">iGameWin</option>
                                        </select>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <label class="form-label">Provider</label>
                                        <select id="pfProviderSelect" class="form-select">
                                            <option value="">Todos</option>
                                        </select>
                                    </div>
                                    <div class="col-12 col-md-3">
                                        <label class="form-label">Provider Local</label>
                                        <input type="text" id="localProvider" class="form-control" placeholder="Ex.: MEU_PROVIDER">
                                    </div>
                                    <div class="col-12 col-md-3 d-grid d-md-flex align-items-end actions">
                                        <button id="loadProvidersBtn" class="btn btn-primary"><i class="fas fa-list"></i> Provedores</button>
                                        <button id="listGamesBtn" class="btn btn-primary"><i class="fas fa-gamepad"></i> Listar Jogos</button>
                                        <button id="insertGamesBtn" class="btn btn-success"><i class="fas fa-download"></i> Inserir Jogos</button>
                                    </div>
                                </div>
                                <div class="status-area">
                                    <div id="statusMessage" class="alert d-none"></div>
                                </div>
                                <div class="table-responsive mt-3">
                                    <table class="table mb-0 table-centered" id="providersTable">
                                        <thead>
                                            <tr>
                                                <th>Code</th>
                                                <th>Name</th>
                                                <th>Tipo</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                                <div class="table-responsive mt-3">
                                    <table class="table mb-0 table-centered" id="gamesTable">
                                        <thead>
                                            <tr>
                                                <th>Banner</th>
                                                <th>Nome</th>
                                                <th>Código</th>
                                                <th>Provider</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?php include 'partials/vendorjs.php' ?>
    <script src="assets/js/app.js"></script>
    <script>
        const statusEl = document.getElementById('statusMessage');
        const apiSelect = document.getElementById('apiSelect');
        const pfSelect = document.getElementById('pfProviderSelect');
        const providersTbody = document.querySelector('#providersTable tbody');
        const gamesTbody = document.querySelector('#gamesTable tbody');
        function showStatus(type, text){
            statusEl.className = 'alert';
            statusEl.classList.add(type === 'success' ? 'alert-success' : type === 'warning' ? 'alert-warning' : 'alert-danger');
            statusEl.textContent = text;
            statusEl.classList.remove('d-none');
        }
        function clearTables(){
            providersTbody.innerHTML = '';
            gamesTbody.innerHTML = '';
        }
        async function loadProviders(){
            clearTables();
            showStatus('warning','Carregando provedores...');
            try{
                const r = await fetch(`fetchjogos.php?action=providers&api=${encodeURIComponent(apiSelect.value)}`);
                const t = await r.text();
                let j = {};
                try{ j = JSON.parse(t); }catch(_){ showStatus('danger', t || 'Erro ao carregar provedores'); return; }
                const list = Array.isArray(j.providers) ? j.providers : (Array.isArray(j.data) ? j.data : []);
                providersTbody.innerHTML = '';
                pfSelect.innerHTML = '<option value=\"\">Todos</option>';
                list.forEach(p=>{
                    const id = p.id || p.code || p.provider_code || '';
                    const name = p.name || p.provider_name || '';
                    const type = (p.gameType===1||p.type==='slot')?'slot':'slot';
                    const tr = document.createElement('tr');
                    tr.innerHTML = `<td><code>${id}</code></td><td>${name}</td><td>${type}</td>`;
                    providersTbody.appendChild(tr);
                    if(id){
                        const opt = document.createElement('option');
                        opt.value = String(id);
                        opt.textContent = name || String(id);
                        pfSelect.appendChild(opt);
                    }
                });
                showStatus('success',`Provedores carregados: ${list.length}`);
            }catch(e){
                showStatus('danger','Erro ao carregar provedores');
            }
        }
        async function listGames(){
            gamesTbody.innerHTML = '';
            showStatus('warning','Carregando jogos...');
            const pf = pfSelect.value || '';
            const url = `fetchjogos.php?action=games_available&api=${encodeURIComponent(apiSelect.value)}${pf?`&pf_provider=${encodeURIComponent(pf)}`:''}`;
            try{
                const r = await fetch(url);
                const t = await r.text();
                let j = {};
                try{ j = JSON.parse(t); }catch(_){ showStatus('danger', t || 'Erro ao carregar jogos'); return; }
                const list = Array.isArray(j.games) ? j.games : (Array.isArray(j.data) ? j.data : []);
                list.forEach(g=>{
                    const code = g.game_code || g.code || g.id || '';
                    const name = g.game_name || g.name || '';
                    const banner = g.banner || g.image || g.image_url || g.thumb || g.thumbnail || '';
                    const provRaw = g.provider || g.provider_code || pf || '';
                    const prov = typeof provRaw === 'object' ? (provRaw.name || provRaw.code || '') : provRaw;
                    const tr = document.createElement('tr');
                    tr.innerHTML = `<td>${banner?`<img src=\"${banner}\" class=\"game-image\">`:''}</td><td>${name}</td><td><code>${code}</code></td><td>${prov}</td>`;
                    gamesTbody.appendChild(tr);
                });
                showStatus('success',`Jogos carregados: ${list.length}`);
            }catch(e){
                showStatus('danger','Erro ao carregar jogos');
            }
        }
        async function insertGames(){
            const localProv = document.getElementById('localProvider').value.trim();
            const pf = pfSelect.value || '';
            if(!localProv){
                showStatus('danger','Informe Provider Local');
                return;
            }
            showStatus('warning','Inserindo jogos...');
            const url = `fetchjogos.php?action=insert&api=${encodeURIComponent(apiSelect.value)}&provider=${encodeURIComponent(localProv)}${pf?`&pf_provider=${encodeURIComponent(pf)}`:''}`;
            try{
                const r = await fetch(url);
                const t = await r.text();
                let j = {};
                try{ j = JSON.parse(t); }catch(_){ showStatus('danger', t || 'Erro ao inserir'); return; }
                if(j.status===1){
                    showStatus('success',`Inseridos: ${j.inserted}, Atualizados: ${j.updated}, Ignorados: ${j.skipped}, Total: ${j.count}`);
                }else{
                    showStatus('danger', j.msg || 'Erro ao inserir');
                }
            }catch(e){
                showStatus('danger','Erro ao inserir jogos');
            }
        }
        document.getElementById('loadProvidersBtn').addEventListener('click', loadProviders);
        document.getElementById('listGamesBtn').addEventListener('click', listGames);
        document.getElementById('insertGamesBtn').addEventListener('click', insertGames);
    </script>
</body>
</html>