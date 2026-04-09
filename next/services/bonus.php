<?php
/**
 * Serviço centralizado de bônus de depósito
 * Suporta dois modelos: valor fixo (cupom) e percentual
 */

if (!defined('DATABASE_LOADED')) {
    return;
}

/**
 * Retorna a configuração atual do bônus
 */
function get_config_bonus() {
    global $mysqli;
    static $cache = null;
    if ($cache !== null) return $cache;

    $qry = "SELECT * FROM config_bonus WHERE id = 1 LIMIT 1";
    $res = @$mysqli->query($qry);
    if (!$res || $res->num_rows === 0) {
        $cache = ['bonus_tipo' => 'fixo', 'bonus_percentual' => 0, 'bonus_percentual_status' => 0, 'bonus_percentual_nome' => 'Bônus em %'];
        return $cache;
    }
    $cache = $res->fetch_assoc();
    return $cache;
}

/**
 * Calcula o valor do bônus para um depósito
 * Retorna o valor do bônus em reais (0 se nenhum)
 *
 * @param int $userId ID do usuário
 * @param float $valorPago Valor pago no depósito
 * @return float Valor do bônus (0 se não houver)
 */
function getBonusForDeposit($userId, $valorPago) {
    global $mysqli;

    $config = get_config_bonus();

    // Modelo percentual: todos os depósitos recebem X% de bônus
    if (isset($config['bonus_tipo']) && $config['bonus_tipo'] === 'percentual' && !empty($config['bonus_percentual_status'])) {
        $pct = (float)($config['bonus_percentual'] ?? 0);
        if ($pct <= 0) return 0;
        $bonus = round($valorPago * ($pct / 100), 2);
        return $bonus > 0 ? $bonus : 0;
    }

    // Modelo fixo: bônus por valor exato (comportamento original)
    $sqlCheck = "SELECT id FROM cupom_usados WHERE id_user = ? AND valor = ?";
    $stmtCheck = $mysqli->prepare($sqlCheck);
    if (!$stmtCheck) return 0;

    $stmtCheck->bind_param("id", $userId, $valorPago);
    $stmtCheck->execute();
    $resultCheck = $stmtCheck->get_result();
    if ($resultCheck->num_rows > 0) {
        $stmtCheck->close();
        return 0;
    }
    $stmtCheck->close();

    $sql = "SELECT qtd_insert FROM cupom WHERE status = 1 AND valor = ?";
    $stmt = $mysqli->prepare($sql);
    if (!$stmt) return 0;

    $stmt->bind_param("d", $valorPago);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($row = $result->fetch_assoc()) {
        $bonus = (float)$row['qtd_insert'];
        $stmt->close();
        return $bonus;
    }
    $stmt->close();
    return 0;
}

/**
 * Registra o uso do bônus na tabela cupom_usados
 */
function registrarBonusUsado($userId, $valorPago, $bonusRecebido) {
    global $mysqli;

    if ((float)$bonusRecebido <= 0) return false;

    $sql = "INSERT INTO cupom_usados (id_user, valor, bonus, data_registro) VALUES (?, ?, ?, NOW())";
    $stmt = $mysqli->prepare($sql);
    if (!$stmt) return false;

    $bonusInt = (int)round((float)$bonusRecebido);
    $stmt->bind_param("idi", $userId, $valorPago, $bonusInt);
    $resultado = $stmt->execute();
    $stmt->close();

    return $resultado;
}
