<?php include 'partials/html.php' ?>

<?php
#======================================#
ini_set('display_errors', 0);
error_reporting(E_ALL);
#======================================#
session_start();
include_once "services/database.php";
include_once 'logs/registrar_logs.php';
include_once "services/funcao.php";
include_once "services/crud.php";
include_once "services/crud-adm.php";
include_once 'services/checa_login_adm.php';
include_once "services/CSRF_Protect.php";
include_once "validar_2fa.php";
$csrf = new CSRF_Protect();
#======================================#
checa_login_adm();
#======================================#

if ($_SESSION['data_adm']['status'] != '1') {
    echo "<script>setTimeout(function() { window.location.href = 'bloqueado.php'; }, 0);</script>";
    exit();
}

// Função para validar 2FA do administrador logado
function validar_2fa_admin($codigo_2fa)
{
    global $mysqli;
    $admin_id = $_SESSION['data_adm']['id'];
    
    $qry = $mysqli->prepare("SELECT 2fa FROM admin_users WHERE id = ?");
    $qry->bind_param("i", $admin_id);
    $qry->execute();
    $result = $qry->get_result();
    $admin = $result->fetch_assoc();
    
    if ($admin && password_verify($codigo_2fa, $admin['2fa'])) {
        return true;
    }
    return false;
}

function get_gateways_config()
{
    global $mysqli;
    
    $NextPayQuery = "SELECT * FROM nextpay WHERE id = 1";
    $NextPayResult = mysqli_query($mysqli, $NextPayQuery);
    $NextPayConfig = mysqli_fetch_assoc($NextPayResult);
    
    $expfypayQuery = "SELECT * FROM expfypay WHERE id = 1";
    $expfypayResult = mysqli_query($mysqli, $expfypayQuery);
    $expfypayConfig = mysqli_fetch_assoc($expfypayResult);

    $bspayQuery = "SELECT * FROM bspay WHERE id = 1";
    $bspayResult = mysqli_query($mysqli, $bspayQuery);
    $bspayConfig = mysqli_fetch_assoc($bspayResult);
    
    $AurenPayQuery = "SELECT * FROM aurenpay WHERE id = 1";
    $AurenPayResult = mysqli_query($mysqli, $AurenPayQuery);
    $AurenPayConfig = mysqli_fetch_assoc($AurenPayResult);

    return [
        'nextpay' => $NextPayConfig,
        'expfypay' => $expfypayConfig,
        'bspay' => $bspayConfig,
        'aurenpay' => $AurenPayConfig
    ];
}

function update_gateway_status($selectedGateway)
{
    global $mysqli;

    // Desativar todos os gateways
    $mysqli->query("UPDATE nextpay SET ativo = 0 WHERE id = 1");
    $mysqli->query("UPDATE expfypay SET ativo = 0 WHERE id = 1");
    $mysqli->query("UPDATE bspay SET ativo = 0 WHERE id = 1");
    $mysqli->query("UPDATE aurenpay SET ativo = 0 WHERE id = 1");

    // Ativar o gateway selecionado
    if ($selectedGateway === 'NextPay') {
        $mysqli->query("UPDATE nextpay SET ativo = 1 WHERE id = 1");
    } elseif ($selectedGateway === 'ExpfyPay') {
        $mysqli->query("UPDATE expfypay SET ativo = 1 WHERE id = 1");
    } elseif ($selectedGateway === 'BSPay') {
        $mysqli->query("UPDATE bspay SET ativo = 1 WHERE id = 1");
    } elseif ($selectedGateway === 'AurenPay') {
        $mysqli->query("UPDATE aurenpay SET ativo = 1 WHERE id = 1");
    }
}

function update_config($data)
{
    global $mysqli;

    if ($data['gateway'] === 'NextPay') {
        // NextPay não permite alterar URL
        $qry = $mysqli->prepare("UPDATE nextpay SET client_id = ?, client_secret = ? WHERE id = 1");
        $qry->bind_param("ss", $data['client_id'], $data['client_secret']);
    } elseif ($data['gateway'] === 'ExpfyPay') {
        $qry = $mysqli->prepare("UPDATE expfypay SET url = ?, client_id = ?, client_secret = ? WHERE id = 1");
        $qry->bind_param("sss", $data['url'], $data['client_id'], $data['client_secret']);
    } elseif ($data['gateway'] === 'BSPay') {
        $qry = $mysqli->prepare("UPDATE bspay SET url = ?, client_id = ?, client_secret = ? WHERE id = 1");
        $qry->bind_param("sss", $data['url'], $data['client_id'], $data['client_secret']);
    } elseif ($data['gateway'] === 'AurenPay') {
        $qry = $mysqli->prepare("UPDATE aurenpay SET url = ?, client_id = ?, client_secret = ? WHERE id = 1");
        $qry->bind_param("sss", $data['url'], $data['client_id'], $data['client_secret']);
    }

    $success = $qry->execute();

    if ($success) {
        update_gateway_status($data['gateway']);
    }

    return $success;
}

function get_active_gateway($mysqli)
{
    $resultNextPay = $mysqli->query("SELECT ativo FROM nextpay WHERE id = 1");
    $resultExpfyPay = $mysqli->query("SELECT ativo FROM expfypay WHERE id = 1");
    $resultBSPay = $mysqli->query("SELECT ativo FROM bspay WHERE id = 1");
    $resultAurenPay = $mysqli->query("SELECT ativo FROM aurenpay WHERE id = 1");

    if ($resultNextPay && $resultExpfyPay && $resultBSPay && $resultAurenPay) {
        $nextpay = $resultNextPay->fetch_assoc();
        $expfypay = $resultExpfyPay->fetch_assoc();
        $bspay = $resultBSPay->fetch_assoc();
        $AurenPay = $resultAurenPay->fetch_assoc();

        if ($nextpay['ativo'] == 1) {
            return 'NextPay';
        } elseif ($expfypay['ativo'] == 1) {
            return 'ExpfyPay';
        } elseif ($bspay['ativo'] == 1) {
            return 'BSPay/PixUP';
        } elseif ($AurenPay['ativo'] == 1) {
            return 'AurenPay';
        }
    }

    return 'Nenhum';
}

$toastType = null;
$toastMessage = '';

// Validação de 2FA para desbloquear credenciais
$credenciais_desbloqueadas = false;
if (isset($_POST['validar_2fa_visualizar'])) {
    if (validar_2fa_admin($_POST['codigo_2fa_visualizar'])) {
        $credenciais_desbloqueadas = true;
        $_SESSION['credenciais_desbloqueadas'] = true;
        $_SESSION['credenciais_timeout'] = time() + 300; // 5 minutos
        $toastType = 'success';
        $toastMessage = 'Credenciais desbloqueadas por 5 minutos!';
    } else {
        $toastType = 'error';
        $toastMessage = 'Código 2FA inválido!';
    }
}

// Verificar se credenciais ainda estão desbloqueadas
if (isset($_SESSION['credenciais_desbloqueadas']) && isset($_SESSION['credenciais_timeout'])) {
    if (time() < $_SESSION['credenciais_timeout']) {
        $credenciais_desbloqueadas = true;
    } else {
        unset($_SESSION['credenciais_desbloqueadas']);
        unset($_SESSION['credenciais_timeout']);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['gateway'])) {
    // Validar 2FA antes de atualizar credenciais
    if (!isset($_POST['codigo_2fa_salvar']) || empty($_POST['codigo_2fa_salvar'])) {
        $toastType = 'error';
        $toastMessage = 'Código 2FA é obrigatório para alterar as credenciais de pagamento.';
    } elseif (!validar_2fa_admin($_POST['codigo_2fa_salvar'])) {
        $toastType = 'error';
        $toastMessage = 'Código 2FA inválido. Acesso negado.';
    } else {
        $data = [
            'gateway' => $_POST['gateway'],
            'client_id' => $_POST['client_id'],
            'client_secret' => $_POST['client_secret'],
            'url' => isset($_POST['url']) ? $_POST['url'] : ''
        ];

        $update_success = update_config($data);

        if ($update_success) {
            $toastType = 'success';
            $toastMessage = 'Credenciais atualizadas com sucesso!';
        } else {
            $toastType = 'error';
            $toastMessage = 'Erro ao atualizar as Credenciais. Tente novamente.';
        }
    }
}

$config = get_gateways_config();
$activeGateway = get_active_gateway($mysqli);
?>

<head>
    <?php $title = "Configurações de Gateway";
    include 'partials/title-meta.php' ?>
    <link rel="stylesheet" href="assets/libs/jsvectormap/jsvectormap.min.css">
    <?php include 'partials/head-css.php' ?>
    <style>
        .credencial-bloqueada {
            filter: blur(8px);
            user-select: none;
            pointer-events: none;
        }
    </style>
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
                                <h4 class="card-title mb-0">Configurações de Gateway de Pagamentos</h4>
                                <?php if (!$credenciais_desbloqueadas): ?>
                                    <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modal2FAVisualizar">
                                        <i class="fas fa-lock me-2"></i>Desbloquear Credenciais
                                    </button>
                                <?php else: ?>
                                    <span class="badge bg-success" style="font-size: 14px;">
                                        <i class="fas fa-unlock me-1"></i>Credenciais Desbloqueadas
                                    </span>
                                <?php endif; ?>
                            </div>

                            <div class="card-body">
                                <!-- Gateway Ativo -->
                                <div class="mb-4">
                                    <label class="form-label">Gateway Ativo:</label>
                                    <div class="form-control bg-light">
                                        <strong><?php echo htmlspecialchars($activeGateway); ?></strong>
                                    </div>
                                </div>

                                <?php if (!$credenciais_desbloqueadas): ?>
                                    <div class="alert alert-warning" role="alert">
                                        <i class="fas fa-lock me-2"></i>
                                        <strong>Credenciais Bloqueadas:</strong> Clique em "Desbloquear Credenciais" e forneça seu código 2FA para visualizar e editar.
                                    </div>
                                <?php endif; ?>
                                
                                <hr>

                                <!-- Formulário NextPay -->
                                <form method="POST" action="" id="formNextPay">
                                    <input type="hidden" name="gateway" value="NextPay">
                                    
                                    <div class="row">
                                        <div class="col-12">
                                            <h5 class="card-title mb-3">
                                                <i class="fas fa-bolt me-2"></i>NextPay
                                            </h5>
                                        </div>
                                        
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Endpoint</label>
                                                <input type="text" 
                                                    name="url" 
                                                    class="form-control bg-light"
                                                    value="<?= $config['nextpay']['url'] ?>" 
                                                    readonly
                                                    disabled>
                                                <small class="text-muted">URL fixa, não pode ser alterada</small>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Client ID</label>
                                                <div class="input-group">
                                                    <input type="password" 
                                                        id="nextpay_client_id"
                                                        name="client_id" 
                                                        class="form-control <?= !$credenciais_desbloqueadas ? 'credencial-bloqueada' : '' ?>"
                                                        value="<?= $config['nextpay']['client_id'] ?>" 
                                                        required
                                                        <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <?php if ($credenciais_desbloqueadas): ?>
                                                        <span class="input-group-text" style="cursor: pointer;"
                                                            onclick="togglePassword('nextpay_client_id', this)">
                                                            <i class="fas fa-eye"></i>
                                                        </span>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label class="form-label">Client Secret</label>
                                                <div class="input-group">
                                                    <input type="password" 
                                                        id="nextpay_client_secret"
                                                        name="client_secret" 
                                                        class="form-control <?= !$credenciais_desbloqueadas ? 'credencial-bloqueada' : '' ?>"
                                                        value="<?= $config['nextpay']['client_secret'] ?>" 
                                                        required
                                                        <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <?php if ($credenciais_desbloqueadas): ?>
                                                        <span class="input-group-text" style="cursor: pointer;"
                                                            onclick="togglePassword('nextpay_client_secret', this)">
                                                            <i class="fas fa-eye"></i>
                                                        </span>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <label class="form-label d-block">&nbsp;</label>
                                            <button type="button" 
                                                class="btn btn-primary w-100" 
                                                onclick="abrirModal2FASalvar('NextPay')"
                                                <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                <i class="fas fa-save me-1"></i>Salvar
                                            </button>
                                        </div>
                                    </div>
                                </form>

                                <hr>

                                <!-- Formulário Aurenpay -->
                                <form method="POST" action="" id="formAurenPay">
                                    <input type="hidden" name="gateway" value="AurenPay">
                                    
                                    <div class="row">
                                        <div class="col-12">
                                            <h5 class="card-title mb-3">
                                                <i class="fas fa-wallet me-2"></i>AurenPay
                                            </h5>
                                        </div>
                                        
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Endpoint</label>
                                                <input type="text" 
                                                    name="url" 
                                                    class="form-control"
                                                    value="<?= $config['aurenpay']['url'] ?>" 
                                                    required
                                                    <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Client ID</label>
                                                <div class="input-group">
                                                    <input type="password" 
                                                        id="aurenpay_client_id"
                                                        name="client_id" 
                                                        class="form-control <?= !$credenciais_desbloqueadas ? 'credencial-bloqueada' : '' ?>"
                                                        value="<?= $config['aurenpay']['client_id'] ?>" 
                                                        required
                                                        <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <?php if ($credenciais_desbloqueadas): ?>
                                                        <span class="input-group-text" style="cursor: pointer;"
                                                            onclick="togglePassword('aurenpay_client_id', this)">
                                                            <i class="fas fa-eye"></i>
                                                        </span>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label class="form-label">Client Secret</label>
                                                <div class="input-group">
                                                    <input type="password" 
                                                        id="aurenpay_client_secret"
                                                        name="client_secret" 
                                                        class="form-control <?= !$credenciais_desbloqueadas ? 'credencial-bloqueada' : '' ?>"
                                                        value="<?= $config['aurenpay']['client_secret'] ?>" 
                                                        required
                                                        <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <?php if ($credenciais_desbloqueadas): ?>
                                                        <span class="input-group-text" style="cursor: pointer;"
                                                            onclick="togglePassword('aurenpay_client_secret', this)">
                                                            <i class="fas fa-eye"></i>
                                                        </span>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <label class="form-label d-block">&nbsp;</label>
                                            <button type="button" 
                                                class="btn btn-primary w-100" 
                                                onclick="abrirModal2FASalvar('AurenPay')"
                                                <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                <i class="fas fa-save me-1"></i>Salvar
                                            </button>
                                        </div>
                                    </div>
                                </form>

                                <hr>

                                <!-- Formulário ExpfyPay -->
                                <form method="POST" action="" id="formExpfyPay">
                                    <input type="hidden" name="gateway" value="ExpfyPay">
                                    
                                    <div class="row mb-4">
                                        <div class="col-12">
                                            <h5 class="card-title mb-3">
                                                <i class="fas fa-credit-card me-2"></i>ExpfyPay
                                            </h5>
                                        </div>
                                        
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Endpoint</label>
                                                <select name="url" class="form-select" required <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <option value="https://expfypay.com" <?= $config['expfypay']['url'] === 'https://expfypay.com' ? 'selected' : '' ?>>
                                                        Normal (expfypay.com)
                                                    </option>
                                                    <option value="https://pro.expfypay.com" <?= $config['expfypay']['url'] === 'https://pro.expfypay.com' ? 'selected' : '' ?>>
                                                        Pro (pro.expfypay.com)
                                                    </option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Public Key (Client ID)</label>
                                                <div class="input-group">
                                                    <input type="password" 
                                                        id="expfypay_client_id"
                                                        name="client_id" 
                                                        class="form-control <?= !$credenciais_desbloqueadas ? 'credencial-bloqueada' : '' ?>"
                                                        value="<?= $config['expfypay']['client_id'] ?>" 
                                                        required
                                                        <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <?php if ($credenciais_desbloqueadas): ?>
                                                        <span class="input-group-text" style="cursor: pointer;"
                                                            onclick="togglePassword('expfypay_client_id', this)">
                                                            <i class="fas fa-eye"></i>
                                                        </span>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label class="form-label">Secret Key (Client Secret)</label>
                                                <div class="input-group">
                                                    <input type="password" 
                                                        id="expfypay_client_secret"
                                                        name="client_secret" 
                                                        class="form-control <?= !$credenciais_desbloqueadas ? 'credencial-bloqueada' : '' ?>"
                                                        value="<?= $config['expfypay']['client_secret'] ?>" 
                                                        required
                                                        <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <?php if ($credenciais_desbloqueadas): ?>
                                                        <span class="input-group-text" style="cursor: pointer;"
                                                            onclick="togglePassword('expfypay_client_secret', this)">
                                                            <i class="fas fa-eye"></i>
                                                        </span>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <label class="form-label d-block">&nbsp;</label>
                                            <button type="button" 
                                                class="btn btn-primary w-100" 
                                                onclick="abrirModal2FASalvar('ExpfyPay')"
                                                <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                <i class="fas fa-save me-1"></i>Salvar
                                            </button>
                                        </div>
                                    </div>
                                </form>

                                <hr>

                                <!-- Formulário BSPay/PixUP -->
                                <form method="POST" action="" id="formBSPay">
                                    <input type="hidden" name="gateway" value="BSPay">
                                    
                                    <div class="row">
                                        <div class="col-12">
                                            <h5 class="card-title mb-3">
                                                <i class="fas fa-qrcode me-2"></i>BSPay / PixUP
                                            </h5>
                                        </div>
                                        
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Endpoint</label>
                                                <select name="url" class="form-select" required <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <option value="https://api.bspay.co" <?= $config['bspay']['url'] === 'https://api.bspay.co' ? 'selected' : '' ?>>
                                                        BSPay (api.bspay.co)
                                                    </option>
                                                    <option value="https://api.pixupbr.com" <?= $config['bspay']['url'] === 'https://api.pixupbr.com' ? 'selected' : '' ?>>
                                                        PixUP (api.pixupbr.com)
                                                    </option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Client ID</label>
                                                <div class="input-group">
                                                    <input type="password" 
                                                        id="bspay_client_id"
                                                        name="client_id" 
                                                        class="form-control <?= !$credenciais_desbloqueadas ? 'credencial-bloqueada' : '' ?>"
                                                        value="<?= $config['bspay']['client_id'] ?>" 
                                                        required
                                                        <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <?php if ($credenciais_desbloqueadas): ?>
                                                        <span class="input-group-text" style="cursor: pointer;"
                                                            onclick="togglePassword('bspay_client_id', this)">
                                                            <i class="fas fa-eye"></i>
                                                        </span>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label class="form-label">Client Secret</label>
                                                <div class="input-group">
                                                    <input type="password" 
                                                        id="bspay_client_secret"
                                                        name="client_secret" 
                                                        class="form-control <?= !$credenciais_desbloqueadas ? 'credencial-bloqueada' : '' ?>"
                                                        value="<?= $config['bspay']['client_secret'] ?>" 
                                                        required
                                                        <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                    <?php if ($credenciais_desbloqueadas): ?>
                                                        <span class="input-group-text" style="cursor: pointer;"
                                                            onclick="togglePassword('bspay_client_secret', this)">
                                                            <i class="fas fa-eye"></i>
                                                        </span>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <label class="form-label d-block">&nbsp;</label>
                                            <button type="button" 
                                                class="btn btn-primary w-100" 
                                                onclick="abrirModal2FASalvar('BSPay')"
                                                <?= !$credenciais_desbloqueadas ? 'disabled' : '' ?>>
                                                <i class="fas fa-save me-1"></i>Salvar
                                            </button>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <?php include 'partials/endbar.php' ?>
            <?php include 'partials/footer.php' ?>
            
        </div>
    </div>

    <!-- Modal 2FA para Visualizar Credenciais -->
    <div class="modal fade" id="modal2FAVisualizar" tabindex="-1" aria-labelledby="modal2FAVisualizarLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-warning">
                    <h5 class="modal-title" id="modal2FAVisualizarLabel">
                        <i class="fas fa-unlock-alt me-2"></i>Desbloquear Credenciais
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="POST">
                    <div class="modal-body">
                        <div class="alert alert-info" role="alert">
                            <i class="fas fa-info-circle me-2"></i>
                            Digite seu código 2FA para desbloquear a visualização e edição das credenciais por 5 minutos.
                        </div>
                        <div class="mb-3">
                            <label for="codigo_2fa_visualizar" class="form-label">Código 2FA *</label>
                            <input type="text" name="codigo_2fa_visualizar" class="form-control" placeholder="Digite seu código 2FA" required autofocus>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" name="validar_2fa_visualizar" class="btn btn-warning">
                            <i class="fas fa-unlock me-1"></i>Desbloquear
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal 2FA para Salvar Alterações -->
    <div class="modal fade" id="modal2FASalvar" tabindex="-1" aria-labelledby="modal2FASalvarLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modal2FASalvarLabel">
                        <i class="fas fa-shield-alt me-2"></i>Confirmar Alterações
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-warning" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <strong>Atenção:</strong> Você está prestes a alterar as credenciais do gateway <strong id="gatewayNome"></strong>.
                    </div>
                    <div class="mb-3">
                        <label for="codigo_2fa_salvar" class="form-label">Código 2FA *</label>
                        <input type="text" id="codigo_2fa_salvar" class="form-control" placeholder="Digite seu código 2FA para confirmar" required autofocus>
                        <small class="text-muted">Esta ação requer confirmação de segurança</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="confirmarSalvar()">
                        <i class="fas fa-check me-1"></i>Confirmar e Salvar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="toastPlacement" class="toast-container position-fixed bottom-0 end-0 p-3"></div>

    <?php include 'partials/vendorjs.php' ?>
    <script src="assets/js/app.js"></script>

    <script>
        let gatewayAtual = '';

        function abrirModal2FASalvar(gateway) {
            gatewayAtual = gateway;
            document.getElementById('gatewayNome').textContent = gateway;
            const modal = new bootstrap.Modal(document.getElementById('modal2FASalvar'));
            modal.show();
        }

        function confirmarSalvar() {
            const codigo2fa = document.getElementById('codigo_2fa_salvar').value;
            
            if (!codigo2fa) {
                showToast('error', 'Digite o código 2FA!');
                return;
            }

            let form;
            if (gatewayAtual === 'NextPay') {
                form = document.getElementById('formNextPay');
            } else if (gatewayAtual === 'ExpfyPay') {
                form = document.getElementById('formExpfyPay');
            } else if (gatewayAtual === 'BSPay') {
                form = document.getElementById('formBSPay');
            } else if (gatewayAtual === 'AurenPay') {
                form = document.getElementById('formAurenPay');
            }
            
            const input2fa = document.createElement('input');
            input2fa.type = 'hidden';
            input2fa.name = 'codigo_2fa_salvar';
            input2fa.value = codigo2fa;
            form.appendChild(input2fa);
            
            form.submit();
        }

        function showToast(type, message) {
            var toastPlacement = document.getElementById('toastPlacement');
            var toast = document.createElement('div');
            toast.className = `toast align-items-center bg-light border-0 fade show`;
            toast.setAttribute('role', 'alert');
            toast.setAttribute('aria-live', 'assertive');
            toast.setAttribute('aria-atomic', 'true');
            toast.innerHTML = `
                <div class="toast-header">
                    
                    <h5 class="me-auto my-0">Atualização</h5>
                    <small>Agora</small>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">${message}</div>
            `;
            toastPlacement.appendChild(toast);

            var bootstrapToast = new bootstrap.Toast(toast);
            bootstrapToast.show();

            setTimeout(function () {
                bootstrapToast.hide();
                setTimeout(() => toast.remove(), 500);
            }, 3000);
        }

        function togglePassword(inputId, icon) {
            const input = document.getElementById(inputId);
            const iconElement = icon.querySelector('i');

            if (input.type === "password") {
                input.type = "text";
                iconElement.classList.remove('fa-eye');
                iconElement.classList.add('fa-eye-slash');
            } else {
                input.type = "password";
                iconElement.classList.remove('fa-eye-slash');
                iconElement.classList.add('fa-eye');
            }
        }
    </script>

    <?php if ($toastType && $toastMessage): ?>
        <script>
            showToast('<?= $toastType ?>', '<?= $toastMessage ?>');
        </script>
    <?php endif; ?>

</body>

</html>