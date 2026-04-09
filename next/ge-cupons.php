<?php include 'partials/html.php' ?>

<?php

ini_set('display_errors', 0);
error_reporting(E_ALL);
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

checa_login_adm();

// Garantir que a tabela config_bonus existe
function ensure_config_bonus_table() {
    global $mysqli;
    $q = @$mysqli->query("SELECT 1 FROM config_bonus LIMIT 1");
    if (!$q) {
        $mysqli->query("CREATE TABLE IF NOT EXISTS config_bonus (
            id INT PRIMARY KEY DEFAULT 1,
            bonus_tipo ENUM('fixo', 'percentual') NOT NULL DEFAULT 'fixo',
            bonus_percentual INT NOT NULL DEFAULT 0,
            bonus_percentual_status TINYINT NOT NULL DEFAULT 0,
            bonus_percentual_nome VARCHAR(100) DEFAULT 'Bônus em %'
        )");
        $mysqli->query("INSERT IGNORE INTO config_bonus (id, bonus_tipo) VALUES (1, 'fixo')");
    }
}
ensure_config_bonus_table();

function update_config_bonus_ge($data) {
    global $mysqli;
    $stmt = $mysqli->prepare("UPDATE config_bonus SET bonus_tipo = ?, bonus_percentual = ?, bonus_percentual_status = ?, bonus_percentual_nome = ? WHERE id = 1");
    if (!$stmt) return false;
    $stmt->bind_param("siis", $data['bonus_tipo'], $data['bonus_percentual'], $data['bonus_percentual_status'], $data['bonus_percentual_nome']);
    return $stmt->execute();
}

function get_coupons($limit, $offset)
{
    global $mysqli;
    $qry = "SELECT * FROM cupom ORDER BY id DESC LIMIT $limit OFFSET $offset";
    $result = mysqli_query($mysqli, $qry);
    $coupons = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $coupons[] = $row;
    }
    return $coupons;
}

function count_coupons()
{
    global $mysqli;
    $qry = "SELECT COUNT(*) as total FROM cupom";
    $result = mysqli_query($mysqli, $qry);
    return mysqli_fetch_assoc($result)['total'];
}

function add_coupon($data)
{
    global $mysqli;
    $qry = $mysqli->prepare("INSERT INTO cupom (nome, valor, qtd_insert, status) VALUES (?, ?, ?, ?)");
    $qry->bind_param("siii", $data['nome'], $data['valor'], $data['qtd_insert'], $data['status']);
    return $qry->execute();
}

function update_coupon($data)
{
    global $mysqli;
    $qry = $mysqli->prepare("UPDATE cupom SET 
        nome = ?, 
        valor = ?, 
        qtd_insert = ?, 
        status = ? 
        WHERE id = ?");

    $qry->bind_param(
        "siiii",
        $data['nome'],
        $data['valor'],
        $data['qtd_insert'],
        $data['status'],
        $data['id']
    );
    return $qry->execute();
}

function delete_coupon($id)
{
    global $mysqli;
    $qry = $mysqli->prepare("DELETE FROM cupom WHERE id = ?");
    $qry->bind_param("i", $id);
    return $qry->execute();
}

$toastType = null; 
$toastMessage = '';

// Adicionar novo cupom
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'add') {
    $data = [
        'nome' => $_POST['nome'],
        'valor' => intval($_POST['valor']),
        'qtd_insert' => intval($_POST['qtd_insert']),
        'status' => 0, // Sempre inativo ao criar
    ];

    if (add_coupon($data)) {
        $toastType = 'success';
        $toastMessage = 'Bônus adicionado com sucesso! Ative-o na tabela quando estiver pronto.';
    } else {
        $toastType = 'error';
        $toastMessage = 'Erro ao adicionar o bônus. Tente novamente.';
    }
}

// Atualizar cupom
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'edit') {
    $data = [
        'id' => intval($_POST['id']),
        'nome' => $_POST['nome'],
        'valor' => intval($_POST['valor']),
        'qtd_insert' => intval($_POST['qtd_insert']),
        'status' => isset($_POST['status']) ? 1 : 0,
    ];

    if (update_coupon($data)) {
        $toastType = 'success';
        $toastMessage = 'Bônus atualizado com sucesso!';
    } else {
        $toastType = 'error';
        $toastMessage = 'Erro ao atualizar o bônus. Tente novamente.';
    }
}

// Deletar cupom
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'delete') {
    $id = intval($_POST['id']);
    
    if (delete_coupon($id)) {
        $toastType = 'success';
        $toastMessage = 'Bônus excluído com sucesso!';
    } else {
        $toastType = 'error';
        $toastMessage = 'Erro ao excluir o bônus. Tente novamente.';
    }
}

// Selecionar modelo de bônus (fixo ou percentual)
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'set_model') {
    $modelo = in_array($_POST['modelo'] ?? '', ['fixo', 'percentual']) ? $_POST['modelo'] : 'fixo';
    global $mysqli;
    $stmt = $mysqli->prepare("UPDATE config_bonus SET bonus_tipo = ? WHERE id = 1");
    if ($stmt) {
        $stmt->bind_param("s", $modelo);
        if ($stmt->execute()) {
            $toastType = 'success';
            $toastMessage = 'Modelo de bônus alterado para: ' . ($modelo === 'percentual' ? 'Percentual' : 'Valor fixo');
        }
    }
}

// Salvar configuração do bônus percentual
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'save_percentual') {
    $data = [
        'bonus_tipo' => 'percentual',
        'bonus_percentual' => (int)($_POST['bonus_percentual'] ?? 0),
        'bonus_percentual_status' => isset($_POST['bonus_percentual_status']) ? 1 : 0,
        'bonus_percentual_nome' => trim($_POST['bonus_percentual_nome'] ?? 'Bônus em %') ?: 'Bônus em %',
    ];
    if (update_config_bonus_ge($data)) {
        $toastType = 'success';
        $toastMessage = 'Configuração do bônus percentual salva com sucesso!';
    } else {
        $toastType = 'error';
        $toastMessage = 'Erro ao salvar. Tente novamente.';
    }
}

// Toggle status do cupom
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'toggle_status') {
    $id = intval($_POST['id']);
    $status = intval($_POST['status']);
    
    global $mysqli;
    $qry = $mysqli->prepare("UPDATE cupom SET status = ? WHERE id = ?");
    $qry->bind_param("ii", $status, $id);
    
    if ($qry->execute()) {
        $toastType = 'success';
        $toastMessage = $status == 1 ? 'Bônus ativado com sucesso!' : 'Bônus desativado com sucesso!';
    } else {
        $toastType = 'error';
        $toastMessage = 'Erro ao alterar status. Tente novamente.';
    }
}

$limit = 10;
$page = isset($_GET['page']) ? intval($_GET['page']) : 1;
$offset = ($page - 1) * $limit;
$total_coupons = count_coupons();
$total_pages = ceil($total_coupons / $limit);

$coupons = get_coupons($limit, $offset);
$config_bonus = get_config_bonus();
$modelo_atual = $config_bonus['bonus_tipo'] ?? 'fixo';
?>

<head>
    <?php $title = "Gerenciamento de Bônus de Depósito";
    include 'partials/title-meta.php' ?>

    <link rel="stylesheet" href="assets/libs/jsvectormap/jsvectormap.min.css">
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
                        <!-- Seletor de modelo de bônus -->
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title mb-3">Selecione o modelo de bônus</h5>
                                <div class="d-flex gap-2 flex-wrap">
                                    <form method="POST" class="d-inline">
                                        <input type="hidden" name="action" value="set_model">
                                        <input type="hidden" name="modelo" value="fixo">
                                        <button type="submit" class="btn <?= $modelo_atual === 'fixo' ? 'btn-primary' : 'btn-outline-secondary' ?>">
                                            <i class="fas fa-coins"></i> Valor fixo por depósito
                                        </button>
                                    </form>
                                    <form method="POST" class="d-inline">
                                        <input type="hidden" name="action" value="set_model">
                                        <input type="hidden" name="modelo" value="percentual">
                                        <button type="submit" class="btn <?= $modelo_atual === 'percentual' ? 'btn-primary' : 'btn-outline-secondary' ?>">
                                            <i class="fas fa-percent"></i> Bônus em percentual (%)
                                        </button>
                                    </form>
                                </div>
                                <p class="text-muted small mt-2 mb-0">
                                    <?php if ($modelo_atual === 'fixo'): ?>
                                        Valor fixo: bônus definido por valor mínimo de depósito (ex: depósito R$ 20 = +R$ 10).
                                    <?php else: ?>
                                        Percentual: todos os depósitos recebem o mesmo % de bônus (ex: 100% = depósito dobra).
                                    <?php endif; ?>
                                </p>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h4 class="card-title mb-0">
                                    <?= $modelo_atual === 'fixo' ? 'Bônus por valor fixo' : 'Bônus em percentual' ?>
                                </h4>
                                <?php if ($modelo_atual === 'fixo'): ?>
                                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addCouponModal">
                                    <i class="fas fa-plus"></i> Adicionar Novo Bônus
                                </button>
                                <?php endif; ?>
                            </div>

                            <div class="card-body">
                                <?php if ($modelo_atual === 'percentual'): ?>
                                <!-- Configuração do bônus percentual -->
                                <form method="POST" action="">
                                    <input type="hidden" name="action" value="save_percentual">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="bonus_percentual_nome" class="form-label">Nome do Bônus</label>
                                                <input type="text" name="bonus_percentual_nome" id="bonus_percentual_nome" class="form-control" 
                                                    value="<?= htmlspecialchars($config_bonus['bonus_percentual_nome'] ?? 'Bônus em %') ?>" placeholder="Ex: Bônus 100%">
                                                <small class="text-muted">Exemplo: Bônus 100%, Promoção Especial, etc.</small>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="bonus_percentual" class="form-label">Percentual de bônus (%)</label>
                                                <input type="number" name="bonus_percentual" id="bonus_percentual" class="form-control" 
                                                    value="<?= (int)($config_bonus['bonus_percentual'] ?? 0) ?>" min="0" max="1000" placeholder="100">
                                                <small class="text-muted">Ex: 100 = dobra o valor. Depósito R$ 50 vira R$ 100.</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="alert alert-info">
                                            <strong>Total que o usuário receberá:</strong><br>
                                            Depósito: <span id="pct-valor-display">R$ 50,00</span><br>
                                            Bônus (<span id="pct-percentual-display">100</span>%): <span id="pct-bonus-display">R$ 50,00</span><br>
                                            <hr>
                                            <strong>Total: <span id="pct-total-display">R$ 100,00</span></strong>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" name="bonus_percentual_status" id="bonus_percentual_status" <?= !empty($config_bonus['bonus_percentual_status']) ? 'checked' : '' ?>>
                                            <label class="form-check-label" for="bonus_percentual_status">Bônus percentual ativo</label>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i> Salvar configuração
                                    </button>
                                </form>
                                <?php else: ?>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Nome do Bônus</th>
                                                <th>Valor Mínimo de Depósito</th>
                                                <th>Bônus Adicional</th>
                                                <th>Total que Receberá</th>
                                                <th>Status</th>
                                                <th>Ações</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if (empty($coupons)): ?>
                                                <tr>
                                                    <td colspan="6" class="text-center">Nenhum bônus cadastrado</td>
                                                </tr>
                                            <?php else: ?>
                                                <?php foreach ($coupons as $coupon): ?>
                                                    <tr>
                                                        <td><strong><?= htmlspecialchars($coupon['nome']) ?></strong></td>
                                                        <td>R$ <?= number_format($coupon['valor'], 2, ',', '.') ?></td>
                                                        <td><span class="badge bg-success">+ R$ <?= number_format($coupon['qtd_insert'], 2, ',', '.') ?></span></td>
                                                        <td><strong>R$ <?= number_format($coupon['valor'] + $coupon['qtd_insert'], 2, ',', '.') ?></strong></td>
                                                        <td>
                                                            <form method="POST" action="" class="d-inline" id="form-status-<?= $coupon['id'] ?>">
                                                                <div class="form-check form-switch">
                                                                    <input class="form-check-input" type="checkbox" 
                                                                           id="status-toggle-<?= $coupon['id'] ?>" 
                                                                           <?= $coupon['status'] == 1 ? 'checked' : '' ?>
                                                                           onchange="toggleStatus(<?= $coupon['id'] ?>, this.checked)">
                                                                </div>
                                                                <input type="hidden" name="action" value="toggle_status">
                                                                <input type="hidden" name="id" value="<?= $coupon['id'] ?>">
                                                                <input type="hidden" name="status" id="status-value-<?= $coupon['id'] ?>" value="<?= $coupon['status'] == 1 ? 0 : 1 ?>">
                                                            </form>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group gap-1" role="group">
                                                                <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editCouponModal<?= $coupon['id'] ?>">
                                                                    <i class="fas fa-edit"></i> Editar
                                                                </button>
                                                                <button class="btn btn-sm btn-danger ms-2" data-bs-toggle="modal" data-bs-target="#deleteCouponModal<?= $coupon['id'] ?>">
                                                                    <i class="fas fa-trash"></i> Excluir
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <!-- Modal de Edição -->
                                                    <div class="modal fade" id="editCouponModal<?= $coupon['id'] ?>" tabindex="-1" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title">Editar Bônus</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <form method="POST" action="">
                                                                    <div class="modal-body">
                                                                        <div class="mb-3">
                                                                            <label for="nome" class="form-label">Nome do Bônus</label>
                                                                            <input type="text" name="nome" class="form-control" value="<?= htmlspecialchars($coupon['nome']) ?>" placeholder="Ex: DEPÓSITO DE 20" required>
                                                                            <small class="text-muted">Exemplo: DEPÓSITO DE 20, BÔNUS VIP, etc.</small>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label for="valor" class="form-label">Valor Mínimo de Depósito (R$)</label>
                                                                            <input type="number" name="valor" class="form-control" value="<?= $coupon['valor'] ?>" min="1" required>
                                                                            <small class="text-muted">O valor mínimo que o usuário deve depositar</small>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label for="qtd_insert" class="form-label">Bônus Adicional (R$)</label>
                                                                            <input type="number" name="qtd_insert" class="form-control" value="<?= $coupon['qtd_insert'] ?>" min="0" required>
                                                                            <small class="text-muted">Valor extra que o usuário receberá junto com o depósito</small>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <div class="alert alert-info">
                                                                                <strong>Total que o usuário receberá:</strong><br>
                                                                                Depósito: <span id="edit-valor-display-<?= $coupon['id'] ?>">R$ <?= number_format($coupon['valor'], 2, ',', '.') ?></span><br>
                                                                                Bônus: <span id="edit-bonus-display-<?= $coupon['id'] ?>">R$ <?= number_format($coupon['qtd_insert'], 2, ',', '.') ?></span><br>
                                                                                <hr>
                                                                                <strong>Total: <span id="edit-total-display-<?= $coupon['id'] ?>">R$ <?= number_format($coupon['valor'] + $coupon['qtd_insert'], 2, ',', '.') ?></span></strong>
                                                                            </div>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <div class="form-check form-switch">
                                                                                <input class="form-check-input" type="checkbox" name="status" id="status-edit-<?= $coupon['id'] ?>" <?= $coupon['status'] == 1 ? 'checked' : '' ?>>
                                                                                <label class="form-check-label" for="status-edit-<?= $coupon['id'] ?>">
                                                                                    Bônus Ativo
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <input type="hidden" name="action" value="edit">
                                                                        <input type="hidden" name="id" value="<?= $coupon['id'] ?>">
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                                        <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Modal de Exclusão -->
                                                    <div class="modal fade" id="deleteCouponModal<?= $coupon['id'] ?>" tabindex="-1" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header bg-danger text-white">
                                                                    <h5 class="modal-title">Confirmar Exclusão</h5>
                                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <form method="POST" action="">
                                                                    <div class="modal-body">
                                                                        <p>Tem certeza que deseja excluir o bônus <strong><?= htmlspecialchars($coupon['nome']) ?></strong>?</p>
                                                                        <p class="text-danger"><strong>Esta ação não pode ser desfeita!</strong></p>
                                                                        <input type="hidden" name="action" value="delete">
                                                                        <input type="hidden" name="id" value="<?= $coupon['id'] ?>">
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                                        <button type="submit" class="btn btn-danger">Sim, Excluir</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>

                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>

                                <?php if ($total_pages > 1): ?>
                                    <nav aria-label="Page navigation" class="mt-4">
                                        <ul class="pagination justify-content-center">
                                            <?php for ($i = 1; $i <= $total_pages; $i++): ?>
                                                <li class="page-item <?= $i == $page ? 'active' : '' ?>">
                                                    <a class="page-link" href="?page=<?= $i ?>"><?= $i ?></a>
                                                </li>
                                            <?php endfor; ?>
                                        </ul>
                                    </nav>
                                <?php endif; ?>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
    <?php include 'partials/endbar.php' ?>
    <?php include 'partials/footer.php' ?>
        </div>
    </div>

    <!-- Modal de Adicionar -->
    <div class="modal fade" id="addCouponModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Adicionar Novo Bônus</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="POST" action="">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="nome" class="form-label">Nome do Bônus</label>
                            <input type="text" name="nome" class="form-control" placeholder="Ex: DEPÓSITO DE 20" required>
                            <small class="text-muted">Exemplo: DEPÓSITO DE 20, BÔNUS VIP, etc.</small>
                        </div>
                        <div class="mb-3">
                            <label for="valor" class="form-label">Valor Mínimo de Depósito (R$)</label>
                            <input type="number" name="valor" id="add-valor" class="form-control" placeholder="20" min="1" required>
                            <small class="text-muted">O valor mínimo que o usuário deve depositar</small>
                        </div>
                        <div class="mb-3">
                            <label for="qtd_insert" class="form-label">Bônus Adicional (R$)</label>
                            <input type="number" name="qtd_insert" id="add-bonus" class="form-control" placeholder="10" min="0" required>
                            <small class="text-muted">Valor extra que o usuário receberá junto com o depósito</small>
                        </div>
                        <div class="mb-3">
                            <div class="alert alert-info">
                                <strong>Total que o usuário receberá:</strong><br>
                                Depósito: <span id="add-valor-display">R$ 0,00</span><br>
                                Bônus: <span id="add-bonus-display">R$ 0,00</span><br>
                                <hr>
                                <strong>Total: <span id="add-total-display">R$ 0,00</span></strong>
                            </div>
                        </div>
                        <div class="alert alert-warning">
                            <i class="fas fa-info-circle"></i> O bônus será criado como <strong>inativo</strong>. Você poderá ativá-lo depois na tabela.
                        </div>
                        <input type="hidden" name="action" value="add">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-success">Adicionar Bônus</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="toastPlacement" class="toast-container position-fixed bottom-0 end-0 p-3"></div>
    <?php include 'partials/vendorjs.php' ?>
    <script src="assets/js/app.js"></script>
    <script>
        function showToast(type, message) {
            var toastPlacement = document.getElementById('toastPlacement');
            var toast = document.createElement('div');
            toast.className = `toast align-items-center bg-light border-0 fade show`;
            toast.setAttribute('role', 'alert');
            toast.setAttribute('aria-live', 'assertive');
            toast.setAttribute('aria-atomic', 'true');
            toast.innerHTML = `
                <div class="toast-header">
                    <h5 class="me-auto my-0">${type === 'success' ? 'Sucesso' : 'Erro'}</h5>
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

        function toggleStatus(id, checked) {
            const form = document.getElementById('form-status-' + id);
            const statusValue = document.getElementById('status-value-' + id);
            
            // Atualiza o valor do input hidden
            statusValue.value = checked ? 1 : 0;
            
            // Submete o formulário
            form.submit();
        }

        // Calcular total no modal de adicionar
        function updateAddTotal() {
            const valor = parseFloat(document.getElementById('add-valor').value) || 0;
            const bonus = parseFloat(document.getElementById('add-bonus').value) || 0;
            const total = valor + bonus;

            document.getElementById('add-valor-display').textContent = 'R$ ' + valor.toFixed(2).replace('.', ',');
            document.getElementById('add-bonus-display').textContent = 'R$ ' + bonus.toFixed(2).replace('.', ',');
            document.getElementById('add-total-display').textContent = 'R$ ' + total.toFixed(2).replace('.', ',');
        }

        document.getElementById('add-valor').addEventListener('input', updateAddTotal);
        document.getElementById('add-bonus').addEventListener('input', updateAddTotal);

        // Preview do bônus percentual
        var pctInput = document.getElementById('bonus_percentual');
        if (pctInput) {
            function updatePctPreview() {
                var pct = parseFloat(pctInput.value) || 0;
                var valorExemplo = 50;
                var bonus = valorExemplo * (pct / 100);
                var total = valorExemplo + bonus;
                var vd = document.getElementById('pct-valor-display');
                var pd = document.getElementById('pct-percentual-display');
                var bd = document.getElementById('pct-bonus-display');
                var td = document.getElementById('pct-total-display');
                if (vd) vd.textContent = 'R$ ' + valorExemplo.toFixed(2).replace('.', ',');
                if (pd) pd.textContent = pct;
                if (bd) bd.textContent = 'R$ ' + bonus.toFixed(2).replace('.', ',');
                if (td) td.textContent = 'R$ ' + total.toFixed(2).replace('.', ',');
            }
            pctInput.addEventListener('input', updatePctPreview);
            updatePctPreview();
        }

        // Calcular total nos modais de editar
        <?php foreach ($coupons as $coupon): ?>
        (function() {
            const id = <?= $coupon['id'] ?>;
            const valorInput = document.querySelector(`#editCouponModal${id} input[name="valor"]`);
            const bonusInput = document.querySelector(`#editCouponModal${id} input[name="qtd_insert"]`);

            function updateEditTotal() {
                const valor = parseFloat(valorInput.value) || 0;
                const bonus = parseFloat(bonusInput.value) || 0;
                const total = valor + bonus;

                document.getElementById(`edit-valor-display-${id}`).textContent = 'R$ ' + valor.toFixed(2).replace('.', ',');
                document.getElementById(`edit-bonus-display-${id}`).textContent = 'R$ ' + bonus.toFixed(2).replace('.', ',');
                document.getElementById(`edit-total-display-${id}`).textContent = 'R$ ' + total.toFixed(2).replace('.', ',');
            }

            valorInput.addEventListener('input', updateEditTotal);
            bonusInput.addEventListener('input', updateEditTotal);
        })();
        <?php endforeach; ?>
    </script>

    <?php if ($toastType && $toastMessage): ?>
        <script>
            showToast('<?= $toastType ?>', '<?= $toastMessage ?>');
        </script>
    <?php endif; ?>

</body>
</html>