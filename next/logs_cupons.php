<?php
include 'partials/html.php';

ini_set('display_errors', 1);
error_reporting(E_ALL);
session_start();
include_once "services/database.php";
include_once "services/funcao.php";
include_once 'logs/registrar_logs.php';
include_once "services/crud.php";
include_once "services/crud-adm.php";
include_once "validar_2fa.php";
include_once "services/CSRF_Protect.php";
include_once 'services/checa_login_adm.php';
$csrf = new CSRF_Protect();

checa_login_adm();

// Lógica para pegar a busca do usuário
$search_query = '';
if (isset($_GET['search']) && !empty($_GET['search'])) {
    $search_query = mysqli_real_escape_string($mysqli, $_GET['search']);
}

function get_cupons_usados($limit, $offset, $search_query = '')
{
    global $mysqli;
    $qry = "
        SELECT 
            cupom_usados.id,
            cupom_usados.id_user,
            cupom_usados.id_cupom,
            cupom_usados.valor,
            cupom_usados.data_registro,
            cupom.nome AS nome_cupom
        FROM 
            cupom_usados
        LEFT JOIN 
            cupom ON cupom_usados.id_cupom = cupom.id
    ";

    // Se houver um filtro de busca, modificamos a query
    if (!empty($search_query)) {
        $qry .= " WHERE cupom_usados.id_user LIKE '%$search_query%'";
    }

    $qry .= " ORDER BY cupom_usados.data_registro DESC LIMIT $limit OFFSET $offset";

    $result = mysqli_query($mysqli, $qry);
    $cupons = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $cupons[] = $row;
    }
    return $cupons;
}

function count_cupons_usados($search_query = '')
{
    global $mysqli;
    $qry = "SELECT COUNT(*) as total FROM cupom_usados";

    // Se houver um filtro de busca, modificamos a query
    if (!empty($search_query)) {
        $qry .= " WHERE id_user LIKE '%$search_query%'";
    }

    $result = mysqli_query($mysqli, $qry);
    return mysqli_fetch_assoc($result)['total'];
}

$limit = 10;
$page = isset($_GET['page']) ? intval($_GET['page']) : 1;
$offset = ($page - 1) * $limit;
$total_cupons = count_cupons_usados($search_query);
$total_pages = ceil($total_cupons / $limit);

$cupons_usados = get_cupons_usados($limit, $offset, $search_query);
?>

<head>
    <?php $title = "Histórico de Bônus Usados";
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
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Histórico de Bônus Usados</h4>
                            </div>
                            
                            <div class="card-body">
                                <form method="GET" action="" class="mb-3">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <input type="text" name="search" class="form-control"
                                                placeholder="Buscar por ID do usuário"
                                                value="<?= htmlspecialchars($search_query) ?>">
                                        </div>
                                        <div class="col-md-4">
                                            <button type="submit" class="btn btn-success w-100">
                                                <i class="fas fa-search"></i> Filtrar
                                            </button>
                                        </div>
                                    </div>
                                </form>

                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>ID Usuário</th>
                                                <th>Nome do Bônus</th>
                                                <th>Valor</th>
                                                <th>Data</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if (empty($cupons_usados)): ?>
                                                <tr>
                                                    <td colspan="5" class="text-center">Nenhum bônus usado encontrado</td>
                                                </tr>
                                            <?php else: ?>
                                                <?php foreach ($cupons_usados as $cupom): ?>
                                                    <tr>
                                                        <td><?= $cupom['id'] ?></td>
                                                        <td><?= $cupom['id_user'] ?></td>
                                                        <td><?= htmlspecialchars($cupom['nome_cupom'] ?? 'N/A') ?></td>
                                                        <td>R$ <?= number_format($cupom['valor'], 2, ',', '.') ?></td>
                                                        <td>
                                                            <?php 
                                                            if ($cupom['data_registro']) {
                                                                echo date('d/m/Y H:i:s', strtotime($cupom['data_registro']));
                                                            } else {
                                                                echo 'N/A';
                                                            }
                                                            ?>
                                                        </td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>
                                
                                <?php if ($total_pages > 1): ?>
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center flex-wrap">
                                        <!-- Primeira e Anterior -->
                                        <li class="page-item <?= $page == 1 ? 'disabled' : '' ?>">
                                            <a class="page-link" href="?page=1&search=<?= urlencode($search_query) ?>" aria-label="Primeira página">
                                                <span aria-hidden="true">&laquo;&laquo;</span>
                                            </a>
                                        </li>
                                        <li class="page-item <?= $page == 1 ? 'disabled' : '' ?>">
                                            <a class="page-link" href="?page=<?= $page - 1 ?>&search=<?= urlencode($search_query) ?>" aria-label="Página anterior">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                
                                        <?php
                                        $range = 2;
                                        $start = max(1, $page - $range);
                                        $end = min($total_pages, $page + $range);

                                        // Primeira página se não estiver no range
                                        if ($start > 1): ?>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=1&search=<?= urlencode($search_query) ?>">1</a>
                                            </li>
                                            <?php if ($start > 2): ?>
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                            <?php endif; ?>
                                        <?php endif; ?>

                                        <!-- Páginas do range -->
                                        <?php for ($i = $start; $i <= $end; $i++): ?>
                                            <li class="page-item <?= $i == $page ? 'active' : '' ?>">
                                                <a class="page-link" href="?page=<?= $i ?>&search=<?= urlencode($search_query) ?>"><?= $i ?></a>
                                            </li>
                                        <?php endfor; ?>

                                        <!-- Última página se não estiver no range -->
                                        <?php if ($end < $total_pages): ?>
                                            <?php if ($end < $total_pages - 1): ?>
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                            <?php endif; ?>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=<?= $total_pages ?>&search=<?= urlencode($search_query) ?>"><?= $total_pages ?></a>
                                            </li>
                                        <?php endif; ?>
                                
                                        <!-- Próxima e Última -->
                                        <li class="page-item <?= $page == $total_pages ? 'disabled' : '' ?>">
                                            <a class="page-link" href="?page=<?= $page + 1 ?>&search=<?= urlencode($search_query) ?>" aria-label="Próxima página">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                        <li class="page-item <?= $page == $total_pages ? 'disabled' : '' ?>">
                                            <a class="page-link" href="?page=<?= $total_pages ?>&search=<?= urlencode($search_query) ?>" aria-label="Última página">
                                                <span aria-hidden="true">&raquo;&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
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

    <?php include 'partials/vendorjs.php' ?>
    <script src="assets/js/app.js"></script>

</body>
</html>