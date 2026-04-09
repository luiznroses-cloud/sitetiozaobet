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
#expulsa user
checa_login_adm();
#======================================#

# Função para buscar todos os webhooks com paginação e pesquisa
function get_webhooks($limit, $offset, $search = '')
{
    global $mysqli;
    $search = $mysqli->real_escape_string($search);
    $qry = "SELECT * FROM webhook 
            WHERE nome LIKE '%$search%' 
            LIMIT $limit OFFSET $offset";
    $result = mysqli_query($mysqli, $qry);
    $webhooks = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $webhooks[] = $row;
    }
    return $webhooks;
}

# Função para contar o total de webhooks com pesquisa
function count_webhooks($search = '')
{
    global $mysqli;
    $search = $mysqli->real_escape_string($search);
    $qry = "SELECT COUNT(*) as total 
            FROM webhook 
            WHERE nome LIKE '%$search%'";
    $result = mysqli_query($mysqli, $qry);
    return mysqli_fetch_assoc($result)['total'];
}

# Função para atualizar os dados do webhook
function update_webhook($data)
{
    global $mysqli;
    $qry = $mysqli->prepare("UPDATE webhook SET 
        nome = ?, 
        bot_id = ?, 
        chat_id = ?, 
        status = ? 
        WHERE id = ?");

    $qry->bind_param(
        "sssii",
        $data['nome'],
        $data['bot_id'],
        $data['chat_id'],
        $data['status'],
        $data['id']
    );
    return $qry->execute();
}

# Se o formulário for enviado, atualizar os dados do webhook
$toastType = null; 
$toastMessage = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = [
        'id' => intval($_POST['id']),
        'nome' => $_POST['nome'],
        'bot_id' => $_POST['bot_id'],
        'chat_id' => $_POST['chat_id'],
        'status' => intval($_POST['status'])
    ];

    if (update_webhook($data)) {
        $toastType = 'success';
        $toastMessage = 'Webhook atualizado com sucesso!';
    } else {
        $toastType = 'error';
        $toastMessage = 'Erro ao atualizar o webhook. Tente novamente.';
    }
}

# Configurações de paginação e pesquisa
$search = isset($_GET['search']) ? $_GET['search'] : '';
$limit = 10;  // Número de webhooks por página
$page = isset($_GET['page']) ? intval($_GET['page']) : 1;
$offset = ($page - 1) * $limit;
$total_webhooks = count_webhooks($search);
$total_pages = ceil($total_webhooks / $limit);

# Buscar webhooks com a pesquisa
$webhooks = get_webhooks($limit, $offset, $search);
?>

<head>
    <?php $title = "Gerenciamento de Webhooks";
    include 'partials/title-meta.php' ?>

    <link rel="stylesheet" href="assets/libs/jsvectormap/jsvectormap.min.css">
    <?php include 'partials/head-css.php' ?>
</head>

<body>

    <!-- Top Bar Start -->
    <?php include 'partials/topbar.php' ?>
    <!-- Top Bar End -->
    <!-- leftbar-tab-menu -->
    <?php include 'partials/startbar.php' ?>
    <!-- end leftbar-tab-menu-->

    <div class="page-wrapper">
        <div class="page-content">
            <div class="container-xxl">
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Gerenciamento de Webhooks</h4>
                            </div>

                            <div class="card-body">
                                <!-- Formulário de Pesquisa -->
                                <form method="GET" action="" class="mb-3">
                                    <div class="input-group">
                                        <input type="text" name="search" class="form-control" placeholder="Pesquisar pelo nome do webhook" value="<?= isset($_GET['search']) ? htmlspecialchars($_GET['search']) : '' ?>">
                                        <button class="btn btn-primary" type="submit">Buscar</button>
                                    </div>
                                </form>

                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Nome</th>
                                                <th>Bot ID</th>
                                                <th>Chat ID</th>
                                                <th>Status</th>
                                                <th>Ação</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($webhooks as $webhook): ?>
                                                <tr>
                                                    <td><?= $webhook['id'] ?></td>
                                                    <td><?= htmlspecialchars($webhook['nome']) ?></td>
                                                    <td>
                                                        <span class="badge bg-secondary" style="font-size: 0.75rem;">
                                                            <?= substr($webhook['bot_id'], 0, 15) ?>...
                                                        </span>
                                                    </td>
                                                    <td><?= htmlspecialchars($webhook['chat_id']) ?></td>
                                                    <td>
                                                        <?php if ($webhook['status'] == 1): ?>
                                                            <span class="badge bg-success">Ativo</span>
                                                        <?php else: ?>
                                                            <span class="badge bg-danger">Inativo</span>
                                                        <?php endif; ?>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editWebhookModal<?= $webhook['id'] ?>">Editar</button>
                                                    </td>
                                                </tr>

                                                <!-- Modal de Edição -->
                                                <div class="modal fade" id="editWebhookModal<?= $webhook['id'] ?>" tabindex="-1" aria-labelledby="editWebhookModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="editWebhookModalLabel">Editar Webhook</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <form method="POST" action="">
                                                                <div class="modal-body">
                                                                    <div class="mb-3">
                                                                        <label for="nome" class="form-label">Nome do Webhook</label>
                                                                        <input type="text" name="nome" class="form-control" value="<?= htmlspecialchars($webhook['nome']) ?>" required>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="bot_id" class="form-label">Bot ID (Token do Telegram)</label>
                                                                        <input type="text" name="bot_id" class="form-control" value="<?= htmlspecialchars($webhook['bot_id']) ?>" required>
                                                                        <small class="text-muted">Token do bot do Telegram (ex: 123456:ABC-DEF...)</small>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="chat_id" class="form-label">Chat ID</label>
                                                                        <input type="text" name="chat_id" class="form-control" value="<?= htmlspecialchars($webhook['chat_id']) ?>" required>
                                                                        <small class="text-muted">ID do chat/grupo do Telegram (ex: -1001234567890)</small>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="status" class="form-label">Status</label>
                                                                        <select name="status" class="form-select" required>
                                                                            <option value="1" <?= $webhook['status'] == 1 ? 'selected' : '' ?>>Ativo</option>
                                                                            <option value="0" <?= $webhook['status'] == 0 ? 'selected' : '' ?>>Inativo</option>
                                                                        </select>
                                                                    </div>
                                                                    <input type="hidden" name="id" value="<?= $webhook['id'] ?>">
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                                                                    <button type="submit" class="btn btn-primary">Salvar alterações</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Paginação -->
                                <?php if ($total_pages > 1): ?>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center">
                                            <?php for ($i = 1; $i <= $total_pages; $i++): ?>
                                                <li class="page-item <?= $i == $page ? 'active' : '' ?>">
                                                    <a class="page-link" href="?page=<?= $i ?>&search=<?= urlencode($search) ?>"><?= $i ?></a>
                                                </li>
                                            <?php endfor; ?>
                                        </ul>
                                    </nav>
                                <?php endif; ?>

                            </div>
                        </div>
                    </div>
                </div><!-- end row -->
            </div><!-- container -->
            
            <?php include 'partials/endbar.php' ?>
            <?php include 'partials/footer.php' ?>
        </div><!-- page content -->
    </div><!-- page-wrapper -->

    <!-- Toast container -->
    <div id="toastPlacement" class="toast-container position-fixed bottom-0 end-0 p-3"></div>

    <!-- Javascript -->
    <?php include 'partials/vendorjs.php' ?>
    <script src="assets/js/app.js"></script>

    <!-- Função de Toast -->
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
                    <h5 class="me-auto my-0">Webhooks</h5>
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
    </script>

    <!-- Exibir o Toast baseado nas ações do formulário -->
    <?php if ($toastType && $toastMessage): ?>
        <script>
            showToast('<?= $toastType ?>', '<?= $toastMessage ?>');
        </script>
    <?php endif; ?>

</body>
</html>