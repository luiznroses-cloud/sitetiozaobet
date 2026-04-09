<?php include 'partials/html.php' ?>
<?php
include_once "validar_2fa.php";
include_once "services/database.php";
?>
<head>
    <?php $title = "dash"; ?>
    <?php include 'partials/title-meta.php' ?>
    <?php include 'partials/head-css.php' ?>
    <style>
        .rtp-individual {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .rtp-individual label {
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 2px;
        }
        .rtp-individual input[type="range"] {
            width: 100px;
        }
        .modo-demo-switch {
            width: 40px;
            height: 20px;
        }
        .info-icon {
            margin-left: 5px;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <?php include 'partials/topbar.php' ?>
    <?php include 'partials/startbar.php' ?>

    <?php
    global $mysqli;

    // MODIFICAÇÃO: Filtro base para exibir apenas usuários (statusaff = 0)
    $statusaff_filter = " AND statusaff = 0";

    $search_query = '';
    if (isset($_GET['search']) && !empty($_GET['search'])) {
        $search_query = mysqli_real_escape_string($mysqli, $_GET['search']);
    }

    if (isset($_GET['status']) && $_GET['status'] !== '') {
        $status_filter = (int) $_GET['status'];
        if ($status_filter == 2) {
            // Banidos (mas ainda com statusaff = 0)
            $statusaff_filter = " AND banido = 1 AND statusaff = 0";
        } elseif ($status_filter == 0) {
            // Usuários ativos (não banidos)
            $statusaff_filter = " AND statusaff = 0 AND banido = 0";
        }
        // Se o filtro for 1 (afiliado), ainda mantém statusaff = 0 para não exibir afiliados
    }

    $limit = 50;
    $page = isset($_GET['page']) ? (int) $_GET['page'] : 1;
    $offset = ($page - 1) * $limit;

    $query_total_usuarios = "SELECT COUNT(*) AS total_usuarios FROM usuarios WHERE 1=1 $statusaff_filter";
    if (!empty($search_query)) {
        $query_total_usuarios .= " AND (id LIKE '%$search_query%' OR mobile LIKE '%$search_query%')";
    }
    
    $result_total_usuarios = mysqli_query($mysqli, $query_total_usuarios);
    $total_usuarios = mysqli_fetch_assoc($result_total_usuarios)['total_usuarios'];

    $total_pages = ceil($total_usuarios / $limit);

    $query_usuarios = "SELECT * FROM usuarios WHERE 1=1 $statusaff_filter";
    if (!empty($search_query)) {
        $query_usuarios .= " AND (id LIKE '%$search_query%' OR mobile LIKE '%$search_query%')";
    }
    
    $query_usuarios .= " ORDER BY id DESC LIMIT $limit OFFSET $offset";
    $result_usuarios = mysqli_query($mysqli, $query_usuarios);
    ?>

    <div class="page-wrapper">
        <div class="page-content">
            <div class="container-xxl">
                <div class="row justify-content-center">
                    <div class="col-md-12 col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <h4 class="card-title">Todos Usuários (<?= $total_usuarios; ?> no total)</h4>
                                    </div>
                                    <div class="col text-end">
                                        <a href="export/exportar_usuarios.php" class="btn btn-primary">Exportar Dados</a>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body pt-0">
                                <form method="GET" action="">
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <input type="text" name="search" class="form-control"
                                                placeholder="Buscar por ID ou Nome do Usuário"
                                                value="<?= htmlspecialchars($search_query) ?>">
                                        </div>
                                        <div class="col-md-4">
                                            <select name="status" class="form-select">
                                                <option value="">Todos os Status</option>
                                                <option value="2" <?= (isset($_GET['status']) && $_GET['status'] == '2') ? 'selected' : ''; ?>>Banido</option>
                                                <option value="0" <?= (isset($_GET['status']) && $_GET['status'] == '0') ? 'selected' : ''; ?>>Ativo</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4 text-end">
                                            <button type="submit" class="btn btn-success mt-2 mb-2">Filtrar</button>
                                            <a href="?" class="btn btn-secondary mt-2 mb-2">Limpar</a>
                                        </div>
                                    </div>
                                </form>

                                <div class="table-responsive">
                                    <table class="table mb-0 table-centered">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Id</th>
                                                <th>Usuário</th>
                                                <th>Saldo</th>
                                                <th>Depositado</th>
                                                <th>Sacado</th>
                                                <th>Cargo</th>
                                                <th>Indicados</th>
                                                <th>Status</th>
                                                <th>
                                                    Modo Demo
                                                    <i class="fa fa-info-circle text-info info-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Para ativar o modo demo, é necessário o afiliado ter feito no mínimo 1 aposta via Pragmatic e PGSoft"></i>
                                                </th>
                                                <th>RTP Individual</th>
                                                <th class="text-end">Detalhes</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                            if ($result_usuarios && mysqli_num_rows($result_usuarios) > 0) {
                                                while ($usuario = mysqli_fetch_assoc($result_usuarios)) {
                                                    // Definir o cargo com base nos dados da tabela
                                                    if ($usuario['banido'] == 1) {
                                                        $cargo_badge = "<span class='badge bg-dark'>Banido</span>";
                                                    } else {
                                                        $cargo_badge = "<span class='badge bg-secondary'>Usuário</span>";
                                                    }

                                                    $query_sacado = "SELECT SUM(valor) AS total_sacado FROM solicitacao_saques WHERE id_user = {$usuario['id']} AND status = 1";
                                                    $result_sacado = mysqli_query($mysqli, $query_sacado);
                                                    $sacado = ($result_sacado && mysqli_num_rows($result_sacado) > 0) ? mysqli_fetch_assoc($result_sacado)['total_sacado'] : 0;

                                                    $query_depositado = "SELECT SUM(valor) AS total_depositado FROM transacoes WHERE usuario = {$usuario['id']} AND status = 'pago'";
                                                    $result_depositado = mysqli_query($mysqli, $query_depositado);
                                                    $depositado = ($result_depositado && mysqli_num_rows($result_depositado) > 0) ? mysqli_fetch_assoc($result_depositado)['total_depositado'] : 0;

                                                    // Contar indicados (quem foi convidado por este usuário)
                                                    $query_indicados = "SELECT COUNT(*) AS total_indicados FROM usuarios WHERE invitation_code = '{$usuario['invite_code']}'";
                                                    $result_indicados = mysqli_query($mysqli, $query_indicados);
                                                    $total_indicados = ($result_indicados && mysqli_num_rows($result_indicados) > 0) ? mysqli_fetch_assoc($result_indicados)['total_indicados'] : 0;

                                                    // Status
                                                    if ($usuario['banido'] == 1) {
                                                        $status_badge = "<span class='badge bg-danger'>Banido</span>";
                                                    } else {
                                                        $status_badge = "<span class='badge bg-success'>Ativo</span>";
                                                    }

                                                    // Obter valores de modo_demo e rtp_individual
                                                    $modo_demo = $usuario['modo_demo'] ?? 0;
                                                    $rtp_individual = $usuario['rtp_individual'] ?? 95;
                                                    ?>
                                                    <tr>
                                                        <td><?= $usuario['id']; ?></td>
                                                        <td><?= htmlspecialchars($usuario['mobile']); ?></td>
                                                        <td>R$ <?= number_format($usuario['saldo'], 2, ',', '.'); ?></td>
                                                        <td>R$ <?= number_format($depositado, 2, ',', '.'); ?></td>
                                                        <td>R$ <?= number_format($sacado, 2, ',', '.'); ?></td>
                                                        <td><?= $cargo_badge; ?></td>
                                                        <td><?= $total_indicados; ?></td>
                                                        <td><?= $status_badge; ?></td>
                                                        <td>
                                                            <div class="form-check form-switch">
                                                                <input class="form-check-input modo-demo-switch" 
                                                                       type="checkbox" 
                                                                       id="modoDemo_<?= $usuario['id']; ?>" 
                                                                       data-mobile="<?= htmlspecialchars($usuario['mobile']); ?>"
                                                                       <?= $modo_demo == 1 ? 'checked' : ''; ?>>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="rtp-individual">
                                                                <label for="rtpSlider_<?= $usuario['id']; ?>">
                                                                    <span id="rtpValueDisplay_<?= $usuario['id']; ?>"><?= $rtp_individual; ?>%</span>
                                                                </label>
                                                                <input type="range" 
                                                                       class="form-range rtp-slider" 
                                                                       min="0" 
                                                                       max="100" 
                                                                       step="1" 
                                                                       value="<?= $rtp_individual; ?>" 
                                                                       id="rtpSlider_<?= $usuario['id']; ?>"
                                                                       data-mobile="<?= htmlspecialchars($usuario['mobile']); ?>">
                                                            </div>
                                                        </td>
                                                        <td class="text-end">
                                                            <div class="dropdown d-inline-block">
                                                                <a class="dropdown-toggle arrow-none" id="dLabel11"
                                                                    data-bs-toggle="dropdown" href="#" role="button"
                                                                    aria-haspopup="false" aria-expanded="false">
                                                                    <i class="las la-ellipsis-v fs-20 text-muted"></i>
                                                                </a>
                                                                <div class="dropdown-menu dropdown-menu-end">
                                                                    <a class="dropdown-item text-success"
                                                                        href="<?= $painel_adm_ver_usuarios . encodeAll($usuario['id']); ?>">
                                                                        <i class="las la-info-circle"></i> Detalhes
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                <?php
                                                }
                                            } else {
                                                echo "<tr><td colspan='11' class='text-center'>Sem dados disponíveis!</td></tr>";
                                            }
                                            ?>
                                        </tbody>
                                    </table><!--end /table-->
                                </div><!--end /tableresponsive-->

                                <!-- Paginação -->
                                <?php if ($total_pages > 1): ?>
                                    <nav>
                                        <ul class="pagination justify-content-center mt-3">
                                            <?php if ($page > 1): ?>
                                                <li class="page-item">
                                                    <a class="page-link" href="?page=<?= $page - 1 ?><?= !empty($search_query) ? '&search=' . urlencode($search_query) : '' ?><?= isset($_GET['status']) ? '&status=' . $_GET['status'] : '' ?>" aria-label="Anterior">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                            <?php endif; ?>

                                            <?php 
                                            $start_page = max(1, $page - 2);
                                            $end_page = min($total_pages, $page + 2);
                                            
                                            for ($i = $start_page; $i <= $end_page; $i++): 
                                            ?>
                                                <li class="page-item <?= ($i == $page) ? 'active' : '' ?>">
                                                    <a class="page-link" href="?page=<?= $i ?><?= !empty($search_query) ? '&search=' . urlencode($search_query) : '' ?><?= isset($_GET['status']) ? '&status=' . $_GET['status'] : '' ?>"><?= $i ?></a>
                                                </li>
                                            <?php endfor; ?>

                                            <?php if ($page < $total_pages): ?>
                                                <li class="page-item">
                                                    <a class="page-link" href="?page=<?= $page + 1 ?><?= !empty($search_query) ? '&search=' . urlencode($search_query) : '' ?><?= isset($_GET['status']) ? '&status=' . $_GET['status'] : '' ?>" aria-label="Próximo">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            <?php endif; ?>
                                        </ul>
                                    </nav>
                                <?php endif; ?>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Total Depositado</h5>
                                        <p class="text-muted mb-0">R$
                                            <?= number_format(total_dep_pagos_usuarios(), 2, ',', '.'); ?>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Total Sacado</h5>
                                        <p class="text-muted mb-0">R$
                                            <?= number_format(total_saques_usuarios(), 2, ',', '.'); ?>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Saldo Médio</h5>
                                        <p class="text-muted mb-0">R$
                                            <?= number_format(media_saldo_usuarios(), 2, ',', '.'); ?>
                                        </p>
                                    </div>
                                </div>
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
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });
        
        function updateRtpIndividual(mobile, rtpValue) {
            fetch('partials/updateRtpIndividual.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ mobile: mobile, rtp: rtpValue })
            })
            .then(response => response.json())
            .then(json => {
                if (json.success) {
                    console.log('RTP atualizado com sucesso');
                } else {
                    console.error('Erro ao atualizar RTP');
                }
            })
            .catch(error => {
                console.error('Erro na requisição:', error);
            });
        }

        function updateModoDemo(mobile, modoDemoValue) {
            // 1. Atualizar modo demo na iGameWin
            fetch('partials/updateModoDemo.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ mobile: mobile, modo_demo: modoDemoValue })
            })
            .then(response => response.json())
            .then(json => {
                if (json.success) {
                    console.log('Modo Demo atualizado com sucesso na iGameWin');
                    
                    // 2. Sempre chamar PGClone (tanto para ativar quanto desativar)
                    return fetch('partials/updateDemoPGClone.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ mobile: mobile, modo_demo: modoDemoValue })
                    });
                } else {
                    console.error('Erro ao atualizar Modo Demo na iGameWin:', json.message);
                    throw new Error(json.message);
                }
            })
            .then(response => {
                if (response) {
                    return response.json();
                }
            })
            .then(pgcloneJson => {
                if (pgcloneJson) {
                    if (pgcloneJson.success) {
                        const action = modoDemoValue === 1 ? 'ativado' : 'desativado';
                        console.log(`Influencer ${action} com sucesso na PGClone`);
                    } else {
                        console.warn('Aviso PGClone:', pgcloneJson.message);
                    }
                }
            })
            .catch(error => {
                console.error('Erro na requisição:', error);
            });
        }

        document.querySelectorAll('.rtp-slider').forEach(function(slider) {
            slider.addEventListener('input', function() {
                var userId = this.id.replace('rtpSlider_', '');
                var rtpValue = parseInt(this.value);
                document.getElementById('rtpValueDisplay_' + userId).textContent = rtpValue + '%';
            });
            slider.addEventListener('change', function() {
                var userId = this.id.replace('rtpSlider_', '');
                var rtpValue = parseInt(this.value);
                var mobile = this.getAttribute('data-mobile');
                updateRtpIndividual(mobile, rtpValue);
            });
        });

        document.querySelectorAll('.modo-demo-switch').forEach(function(switchElem) {
            switchElem.addEventListener('change', function() {
                var mobile = this.getAttribute('data-mobile');
                var modoDemoValue = this.checked ? 1 : 0;
                updateModoDemo(mobile, modoDemoValue);
            });
        });
    </script>
</body>

</html>

<?php
function total_dep_pagos_usuarios()
{
    global $mysqli;
    $qry = "SELECT SUM(valor) as total_soma FROM transacoes WHERE status = 'pago' AND tipo = 'deposito'";
    $result = mysqli_query($mysqli, $qry);
    return mysqli_fetch_assoc($result)['total_soma'] ?? 0;
}

function total_saques_usuarios()
{
    global $mysqli;
    $qry = "SELECT SUM(valor) as total_soma FROM solicitacao_saques WHERE status = 1";
    $result = mysqli_query($mysqli, $qry);
    return mysqli_fetch_assoc($result)['total_soma'] ?? 0;
}

function media_saldo_usuarios()
{
    global $mysqli;
    $qry = "SELECT AVG(saldo) as media_saldo FROM usuarios";
    $result = mysqli_query($mysqli, $qry);
    return mysqli_fetch_assoc($result)['media_saldo'] ?? 0;
}
?>