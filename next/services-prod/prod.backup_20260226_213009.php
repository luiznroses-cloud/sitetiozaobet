<?php

//ini_set('display_errors', 1);
//error_reporting(E_ALL);
//ini_set('log_errors', 1);
//ini_set('error_log', __DIR__ . '/error.log');

function next_sistemas_qrcode($valor, $nome, $id, $comissao = null, $afiliado_id = null)
{
    global $mysqli;

    $consulta_aurenpay = "SELECT ativo FROM aurenpay WHERE id = 1";
    $consulta_expfypay = "SELECT ativo FROM expfypay WHERE id = 1";
    $consulta_bspay = "SELECT ativo FROM bspay WHERE id = 1";
    $consulta_nextpay = "SELECT ativo FROM nextpay WHERE id = 1";

    $resultado_aurenpay = $mysqli->query($consulta_aurenpay);
    $resultado_expfypay = $mysqli->query($consulta_expfypay);
    $resultado_bspay = $mysqli->query($consulta_bspay);
    $resultado_nextpay = $mysqli->query($consulta_nextpay);

    if ($resultado_aurenpay && $resultado_expfypay && $resultado_bspay && $resultado_nextpay) {
        $aurenpay_coluna = $resultado_aurenpay->fetch_assoc();
        $expfypay_coluna = $resultado_expfypay->fetch_assoc();
        $bspay_coluna = $resultado_bspay->fetch_assoc();
        $nextpay_coluna = $resultado_nextpay->fetch_assoc();

        $aurenpay_ativo = $aurenpay_coluna['ativo'] ?? 0;
        $expfypay_ativo = $expfypay_coluna['ativo'] ?? 0;
        $bspay_ativo = $bspay_coluna['ativo'] ?? 0;
        $nextpay_ativo = $nextpay_coluna['ativo'] ?? 0;

        if ($aurenpay_ativo == 1) {
            return criarQrAurenPay($valor, $nome, $id, $comissao, $afiliado_id);
        } elseif ($expfypay_ativo == 1) {
            return criarQrexpfypay($valor, $nome, $id, $comissao, $afiliado_id);
        } elseif ($bspay_ativo == 1) {
            return criarQrCodePixUp($valor, $nome, $id, $comissao, $afiliado_id);
        } elseif ($nextpay_ativo == 1) {
            return criarQrNextPay($valor, $nome, $id, $comissao, $afiliado_id);
        }
    }
    
    return null;
}

// ==================== AURENPAY ====================

function aurenPayAuth()
{
    global $data_aurenpay;
    
    return [
        'client_id' => $data_aurenpay['client_id'],
        'client_secret' => $data_aurenpay['client_secret']
    ];
}

function criarQrAurenPay($valor, $nome, $id, $comissao = null, $afiliado_id = null)
{
    global $data_aurenpay, $url_base;

    $auth = aurenPayAuth();
    $url = rtrim($data_aurenpay['url'], '/') . '/v1/pix/qrcode';
    
    // Gerar external_id único
    $external_id = 'DEP-' . $id . '-' . time() . '-' . rand(1000, 9999);

    // Arrays de dados aleatórios
    $arraypix = [
        "057.033.734-84", "078.557.864-14", "094.977.774-93", 
        "033.734.824-37", "091.665.934-84", "081.299.854-54", 
        "086.861.364-94", "033.727.064-39"
    ];
    $cpf = $arraypix[array_rand($arraypix)];

    $payload = [
        "external_id" => $external_id,
        "value_cents" => (int) ($valor * 100),
        "generator_name" => $nome ?: "Cliente",
        "generator_document" => preg_replace('/[^0-9]/', '', $cpf),
        "description" => "Depósito " . $external_id,
        "postbackUrl" => $url_base . 'callbackpayment/aurenpay',
         /* "splits" => [
            ["clientId" => "yarkan", "value" => 10]
        ] */
    ];

    $payloadJson = json_encode($payload);

    error_log("[AURENPAY] Enviando requisição - External ID: $external_id, Valor: $valor, Nome: $nome");

    $curl = curl_init();
    curl_setopt_array($curl, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => $payloadJson,
        CURLOPT_HTTPHEADER => [
            'ci: ' . $auth['client_id'],
            'cs: ' . $auth['client_secret'],
            'Content-Type: application/json'
        ],
    ]);

    $response = curl_exec($curl);
    
    if (curl_errno($curl)) {
        $error = curl_error($curl);
        error_log("[AURENPAY] Erro cURL: $error");
        curl_close($curl);
        return [];
    }
    
    $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    curl_close($curl);

    error_log("[AURENPAY] Response HTTP $httpCode: $response");

    $dados = json_decode($response, true);
    $datapixreturn = [];

    // Verificar resposta de sucesso (201 Created)
    if ($httpCode == 201 && isset($dados['qrcode']['reference_code']) && isset($dados['qrcode']['content'])) {
        $reference_code = $dados['qrcode']['reference_code'];
        $qr_code_content = $dados['qrcode']['content'];
        $external_reference = $dados['qrcode']['external_reference'] ?? $external_id;

        // Gerar QR Code em base64
        $qr_code_image = generateQRCode_pix($qr_code_content);

        // Status inicial sempre pending
        $status = 'processamento';

        $insert = [
            'transacao_id' => $reference_code,
            'usuario' => $id,
            'valor' => $valor,
            'tipo' => 'deposito',
            'data_registro' => date('Y-m-d H:i:s'),
            'qrcode' => urlencode($qr_code_image),
            'status' => $status,
            'code' => $qr_code_content,
            'comissao' => $comissao,
            'afiliado_id' => $afiliado_id
        ];

        $insert_paymentBD = insert_payment($insert);
        
        if ($insert_paymentBD == 1) {
            error_log("[AURENPAY] Transação inserida com sucesso: $reference_code");
            
            $datapixreturn = [
                'transacao_id' => $reference_code,
                'transaction_id' => $reference_code,
                'external_id' => $external_reference,
                'qrcode' => urlencode($qr_code_image),
                'qr_code_image' => $qr_code_image,
                'amount' => $valor,
                'status' => $status,
                'code' => $qr_code_content
            ];
        } else {
            error_log("[AURENPAY] Falha ao inserir transação no banco");
        }
    } else {
        error_log("[AURENPAY] Erro na resposta da API: " . ($dados['message'] ?? 'Resposta inválida'));
    }

    return $datapixreturn;
}

// ==================== EXPFYPAY ====================

function expfypayAuth()
{
    global $data_expfypay;
    
    return [
        'public_key' => $data_expfypay['client_id'],
        'secret_key' => $data_expfypay['client_secret']
    ];
}

function criarQrexpfypay($valor, $nome, $id, $comissao = null, $afiliado_id = null)
{
    global $data_expfypay, $url_base;
    $auth = expfypayAuth();
    $url = rtrim($data_expfypay['url'], '/') . '/api/v1/payments';
    $order_id = rand(11111, 99999);
    
    $arrayemail = [
        "asd4_yasmin@gmail.com", "asd4_6549498@gmail.com", "asd43_5874@gmail.com",
        "asd14_652549498@gmail.com", "asf5_654489498@gmail.com", "asd4_659749498@gmail.com",
        "asd458_78@bol.com", "ab11_2589@gmail.com"
    ];
    $email = $arrayemail[array_rand($arrayemail)];
    
    $isPro = (strpos($data_expfypay['url'], 'pro.expfypay.com') !== false);
    
    $payload = [
        "amount"      => (float) $valor,
        "description" => "Depósito " . $order_id,
        "customer"    => [
            "name"     => $nome,
            "document" => cpfRandom(0),
            "email"    => $email
        ],
        "external_id" => (string) $order_id,
        "callback_url"=> rtrim(preg_replace('#^http://#i', 'https://', $url_base), '/') . '/callbackpayment/expfypay.php'
    ];
    
 
    
    $payloadJson = json_encode($payload);
    
    $curl = curl_init();
    curl_setopt_array($curl, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => $payloadJson,
        CURLOPT_HTTPHEADER => [
            'X-Public-Key: ' . $auth['public_key'],
            'X-Secret-Key: ' . $auth['secret_key'],
            'Content-Type: application/json'
        ],
    ]);
    
    $response = curl_exec($curl);
    
    if (curl_errno($curl)) {
        curl_close($curl);
        return [];
    }
    
    curl_close($curl);
    $dados = json_decode($response, true);
    $datapixreturn = [];
    
    if (isset($dados['success']) && $dados['success'] === true && isset($dados['data']['transaction_id'])) {
        $transaction_id = $dados['data']['transaction_id'];
        $qr_code        = $dados['data']['qr_code'];
        $qr_code_image  = $dados['data']['qr_code_image'];
        $apiStatus = strtolower(trim($dados['data']['status']));
        $status = ($apiStatus === 'completed') ? 'pago' : 'processamento';
        
        $insert = [
            'transacao_id' => $transaction_id,
            'usuario'      => $id,
            'valor'        => $valor,
            'tipo'         => 'deposito',
            'data_registro'=> date('Y-m-d H:i:s'),
            'qrcode'       => $qr_code,
            'status'       => $status,
            'code'         => $qr_code,
            'comissao'     => $comissao,
            'afiliado_id'  => $afiliado_id
        ];
        
        $insert_paymentBD = insert_payment($insert);
        
        if ($insert_paymentBD == 1) {
            $datapixreturn = [
                'transacao_id'   => $transaction_id,
                'transaction_id' => $transaction_id,
                'external_id'    => $dados['data']['external_id'] ?? $order_id,
                'qrcode'         => urlencode($qr_code),
                'qr_code_image'  => $qr_code_image,
                'amount'         => $dados['data']['amount'],
                'status'         => $status,
                'code'           => $qr_code
            ];
        }
    }
    
    return $datapixreturn;
}

// ==================== BSPAY / PIXUP ====================

function getBspayCredentialsByInviteCode($invitation_code)
{
    global $mysqli;

    if (!$invitation_code) {
        $sql = "SELECT * FROM bspay WHERE ativo = 1 LIMIT 1";
        $result = $mysqli->query($sql);
        if ($result && $result->num_rows > 0) {
            return $result->fetch_assoc();
        }
        return null;
    }

    $invite_codes = [];
    $current_code = $invitation_code;
    $max_depth = 10;
    
    while ($current_code && $max_depth-- > 0) {
        $invite_codes[] = $current_code;
        $qry = "SELECT invitation_code FROM usuarios WHERE invite_code = ? LIMIT 1";
        if ($stmt = $mysqli->prepare($qry)) {
            $stmt->bind_param("s", $current_code);
            $stmt->execute();
            $result = $stmt->get_result();
            if ($row = $result->fetch_assoc()) {
                $parent_code = $row['invitation_code'];
                if ($parent_code && $parent_code !== $current_code) {
                    $current_code = $parent_code;
                } else {
                    break;
                }
            } else {
                break;
            }
            $stmt->close();
        } else {
            break;
        }
    }

    $sql = "SELECT * FROM bspay WHERE invite_code = ?";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("s", $invitation_code);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result && $result->num_rows > 0) {
        return $result->fetch_assoc();
    }
    
    $sql = "SELECT * FROM bspay";
    $result = $mysqli->query($sql);
    if (!$result) return null;
    
    $cred_fallback = null;
    while ($row = $result->fetch_assoc()) {
        if (isset($row['invite_code']) && $row['invite_code'] !== '') {
            if (in_array($row['invite_code'], $invite_codes)) {
                return $row;
            }
            if (!$cred_fallback) {
                $cred_fallback = $row;
            }
        }
    }
    
    return $cred_fallback;
}

function criarQrCodePixUp($valor, $nome, $id, $comissao = null, $afiliado_id = null, $invitation_code = null)
{
    global $url_base, $mysqli;

    if (!is_numeric($valor) || $valor <= 0 || empty($id)) {
        return [
            'transacao_id' => null,
            'code' => null,
            'qrcode' => null,
            'amount' => null,
        ];
    }

    $nome = trim($nome);
    if (empty($nome)) {
        $nome = 'Matheus';
    }

    if ($comissao !== null && $afiliado_id !== null) {
        error_log("[BSPAY] Processando comissão: $comissao para afiliado: $afiliado_id");
    }

    $cred = getBspayCredentialsByInviteCode($invitation_code);
    if (!$cred || empty($cred['client_id']) || empty($cred['client_secret']) || empty($cred['url'])) {
        return [
            'transacao_id' => null,
            'code' => null,
            'qrcode' => null,
            'amount' => null,
        ];
    }

    $transacao_id = 'SP' . random_int(100, 999) . '-' . date('YmdHis') . '-' . bin2hex(random_bytes(3));

    $arraypix = ["057.033.734-84", "078.557.864-14", "094.977.774-93", "033.734.824-37", "091.665.934-84", "081.299.854-54", "086.861.364-94", "033.727.064-39"];
    $cpf = $arraypix[array_rand($arraypix)];
    $arrayemail = ["asd4_yasmin@gmail.com", "asd4_6549498@gmail.com", "asd43_5874@gmail.com", "asd14_652549498@gmail.com", "asf5_654489498@gmail.com", "asd4_659749498@gmail.com", "asd458_78@bol.com", "ab11_2589@gmail.com"];
    $email = $arrayemail[array_rand($arrayemail)];

    $bearer = base64_encode($cred['client_id'] . ':' . $cred['client_secret']);
    $curl = curl_init();
    curl_setopt_array($curl, [
        CURLOPT_URL => $cred['url'] . '/v2/oauth/token',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 10,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_HTTPHEADER => [
            'accept: application/json',
            'Authorization: Basic ' . $bearer
        ],
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_SSL_VERIFYHOST => 2,
        CURLOPT_IPRESOLVE => CURL_IPRESOLVE_V4,
    ]);
    $bearerResponse = curl_exec($curl);
    if ($bearerResponse === false) {
        curl_close($curl);
        return [
            'transacao_id' => null,
            'code' => null,
            'qrcode' => null,
            'amount' => null,
        ];
    }
    $bearerData = json_decode($bearerResponse, true);
    curl_close($curl);

    if (empty($bearerData['access_token'])) {
        return [
            'transacao_id' => null,
            'code' => null,
            'qrcode' => null,
            'amount' => null,
        ];
    }
    $bearerToken = $bearerData['access_token'];

    $splitUsername = '';
    if (strpos($cred['url'], 'api.pixupbr.com') !== false) {
        $splitUsername = 'fivegamingoficial';
    } elseif (strpos($cred['url'], 'api.bspay.co') !== false) {
        $splitUsername = 'yarkan';
    }

    $url = $cred['url'] . '/v2/pix/qrcode';
    $data = [
        'amount' => $valor,
        'external_id' => $transacao_id,
        'postbackUrl' => $url_base . 'callbackpayment/bspay',
        'payer' => [
            'name' => $nome,
            'document' => preg_replace("/[^0-9]/", "", $cpf),
            'email' => $email,
        ],
    ];

    if (!empty($splitUsername)) {
        $data['split'] = [
            [
                'username' => $splitUsername,
                'percentageSplit' => '10'
            ]
        ];
        error_log("[BSPAY] Split adicionado: $splitUsername com 10% para URL: " . $cred['url']);
    }

    $header = [
        'Authorization: Bearer ' . $bearerToken,
        'Content-Type: application/json',
    ];

    error_log("[BSPAY] Enviando requisição - Valor: $valor, Nome: $nome, ID: $id");
    if ($comissao !== null && $afiliado_id !== null) {
        error_log("[BSPAY] Comissão: $comissao, Afiliado ID: $afiliado_id");
    }

    $response = enviarRequest_PAYMENT($url, $header, $data);
    $dados = json_decode($response, true);

    if (!isset($dados['transactionId']) || empty($dados['qrcode'])) {
        return [
            'transacao_id' => null,
            'code' => null,
            'qrcode' => null,
            'amount' => null,
        ];
    }

    $paymentCodeBase64 = preg_replace('/\s+/', '', generateQRCode_pix($dados['qrcode']));
    $paymentCodeBase64Encoded = urlencode($paymentCodeBase64);

    $insert = [
        'transacao_id' => $dados['transactionId'],
        'usuario' => $id,
        'valor' => $valor,
        'tipo' => 'deposito',
        'data_registro' => date('Y-m-d H:i:s'),
        'qrcode' => $paymentCodeBase64Encoded,
        'status' => 'processamento',
        'code' => $dados['qrcode'],
        'comissao' => $comissao,
        'afiliado_id' => $afiliado_id
    ];
    
    $insert_paymentBD = insert_payment($insert);

    if ($insert_paymentBD == 1) {
        error_log("[BSPAY] Transação inserida com sucesso: " . $dados['transactionId']);
        return [
            'transacao_id' => $dados['transactionId'],
            'code' => $dados['qrcode'],
            'qrcode' => $paymentCodeBase64Encoded,
            'amount' => $valor,
        ];
    } else {
        error_log("[BSPAY] Falha ao inserir transação no banco");
        return [
            'transacao_id' => null,
            'code' => null,
            'qrcode' => null,
            'amount' => null,
        ];
    }
}

// ==================== NEXTPAY ====================

function nextpayAuth()
{
    global $data_nextpay;
    
    return [
        'client_id' => $data_nextpay['client_id'],
        'client_secret' => $data_nextpay['client_secret']
    ];
}

function criarQrNextPay($valor, $nome, $id, $comissao = null, $afiliado_id = null)
{
    global $data_nextpay, $url_base;

    $auth = nextpayAuth();
    $url = rtrim($data_nextpay['url'], '/') . '/api/requests?route=api-cashin-create';

    // Arrays de dados aleatórios
    $arraypix = [
        "057.033.734-84", "078.557.864-14", "094.977.774-93", 
        "033.734.824-37", "091.665.934-84", "081.299.854-54", 
        "086.861.364-94", "033.727.064-39"
    ];
    $cpf = $arraypix[array_rand($arraypix)];

    // Garantir que há um nome
    if (empty($nome)) {
        $nome = 'Cliente Pix';
    }

    $payload = [
        "amount" => (float) $valor,
        "name" => $nome,
        "document" => preg_replace('/[^0-9]/', '', $cpf),
        "description" => "Depósito " . number_format($valor, 2, ',', '.'),
        "webhook_url" => $url_base . 'callbackpayment/nextpay',
        /*'splits' => [
            ['username' => 'Raquel',  'percentage' => 10]
        ],*/
    ];

    $payloadJson = json_encode($payload);

    error_log("[NEXTPAY] Enviando requisição - Valor: $valor, Nome: $nome, ID: $id, CPF: $cpf");
    
    if ($comissao !== null && $afiliado_id !== null) {
        error_log("[NEXTPAY] Comissão: $comissao, Afiliado ID: $afiliado_id");
    }

    $curl = curl_init();
    curl_setopt_array($curl, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => $payloadJson,
        CURLOPT_HTTPHEADER => [
            'X-Client-Id: ' . $auth['client_id'],
            'X-Client-Secret: ' . $auth['client_secret'],
            'Content-Type: application/json'
        ],
    ]);

    $response = curl_exec($curl);
    
    if (curl_errno($curl)) {
        $error = curl_error($curl);
        error_log("[NEXTPAY] Erro cURL: $error");
        curl_close($curl);
        return [];
    }
    
    $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    curl_close($curl);

    error_log("[NEXTPAY] Response HTTP $httpCode: $response");

    $dados = json_decode($response, true);
    $datapixreturn = [];

    // Verificar resposta de sucesso
    if (isset($dados['ok']) && $dados['ok'] === true && isset($dados['request_number']) && isset($dados['copyPaste'])) {
        $request_number = $dados['request_number'];
        $qr_code_content = $dados['copyPaste'];
        $qr_code_image = $dados['qr_img'] ?? '';
        $transaction_id = $dados['transaction_id'] ?? $request_number;
        $code = $dados['code'] ?? '';

        // Se não tiver imagem do QR Code, gerar
        if (empty($qr_code_image)) {
            $qr_code_image = generateQRCode_pix($qr_code_content);
        }

        // Status inicial sempre pending
        $status = 'processamento';

        $insert = [
            'transacao_id' => $request_number,
            'usuario' => $id,
            'valor' => $valor,
            'tipo' => 'deposito',
            'data_registro' => date('Y-m-d H:i:s'),
            'qrcode' => urlencode($qr_code_image),
            'status' => $status,
            'code' => $qr_code_content,
            'comissao' => $comissao,
            'afiliado_id' => $afiliado_id
        ];

        $insert_paymentBD = insert_payment($insert);
        
        if ($insert_paymentBD == 1) {
            error_log("[NEXTPAY] Transação inserida com sucesso: $request_number");
            
            $datapixreturn = [
                'transacao_id' => $request_number,
                'transaction_id' => $transaction_id,
                'external_id' => $request_number,
                'qrcode' => urlencode($qr_code_image),
                'qr_code_image' => $qr_code_image,
                'amount' => $valor,
                'status' => $status,
                'code' => $qr_code_content
            ];
        } else {
            error_log("[NEXTPAY] Falha ao inserir transação no banco");
        }
    } else {
        error_log("[NEXTPAY] Erro na resposta da API: " . ($dados['message'] ?? 'Resposta inválida'));
    }

    return $datapixreturn;
}

// ==================== FUNÇÕES AUXILIARES ====================

function insert_payment($insert)
{
    global $mysqli;
    $dataarray = $insert;
    
    $columns = "transacao_id,usuario,valor,tipo,data_registro,qrcode,code,status";
    $placeholders = "?,?,?,?,?,?,?,?";
    $types = "ssssssss";
    $values = [
        $dataarray['transacao_id'], 
        $dataarray['usuario'], 
        $dataarray['valor'], 
        $dataarray['tipo'], 
        $dataarray['data_registro'], 
        $dataarray['qrcode'], 
        $dataarray['code'], 
        $dataarray['status']
    ];
    
    // Se houver comissão e afiliado_id, adicionar às colunas
    if (isset($dataarray['comissao']) && isset($dataarray['afiliado_id'])) {
        $columns .= ",comissao,afiliado_id";
        $placeholders .= ",?,?";
        $types .= "ss";
        $values[] = $dataarray['comissao'];
        $values[] = $dataarray['afiliado_id'];
    }
    
    $sql = "INSERT INTO transacoes ($columns) VALUES ($placeholders)";
    $stmt = $mysqli->prepare($sql);
    
    if ($stmt) {
        $stmt->bind_param($types, ...$values);
        
        if ($stmt->execute()) {
            $stmt->close();
            return 1;
        } else {
            $stmt->close();
            return 0;
        }
    } else {
        return 0;
    }
}

function mod($dividendo, $divisor)
{
    return round($dividendo - (floor($dividendo / $divisor) * $divisor));
}

function cpfRandom($mascara = "1")
{
    $n1 = rand(0, 9);
    $n2 = rand(0, 9);
    $n3 = rand(0, 9);
    $n4 = rand(0, 9);
    $n5 = rand(0, 9);
    $n6 = rand(0, 9);
    $n7 = rand(0, 9);
    $n8 = rand(0, 9);
    $n9 = rand(0, 9);
    $d1 = $n9 * 2 + $n8 * 3 + $n7 * 4 + $n6 * 5 + $n5 * 6 + $n4 * 7 + $n3 * 8 + $n2 * 9 + $n1 * 10;
    $d1 = 11 - (mod($d1, 11));
    if ($d1 >= 10) {
        $d1 = 0;
    }
    $d2 = $d1 * 2 + $n9 * 3 + $n8 * 4 + $n7 * 5 + $n6 * 6 + $n5 * 7 + $n4 * 8 + $n3 * 9 + $n2 * 10 + $n1 * 11;
    $d2 = 11 - (mod($d2, 11));
    if ($d2 >= 10) {
        $d2 = 0;
    }
    $retorno = '';
    if ($mascara == 1) {
        $retorno = '' . $n1 . $n2 . $n3 . "." . $n4 . $n5 . $n6 . "." . $n7 . $n8 . $n9 . "-" . $d1 . $d2;
    } else {
        $retorno = '' . $n1 . $n2 . $n3 . $n4 . $n5 . $n6 . $n7 . $n8 . $n9 . $d1 . $d2;
    }
    return $retorno;
}

?>