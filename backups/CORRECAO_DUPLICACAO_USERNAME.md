# 🔧 Guia de Correção: Duplicação de Username no Cadastro

## 📋 Descrição do Problema

O sistema estava permitindo a criação de múltiplas contas utilizando o mesmo nome de usuário (username), o que causava:
- ❌ Conflito de identidade entre usuários
- ❌ Confusão de dados e histórico
- ❌ Risco de segurança e integridade dos dados
- ❌ Possibilidade de acesso indevido a contas

## 🎯 Objetivo da Correção

Implementar validação de unicidade do username (`mobile`) antes de criar uma nova conta, garantindo que cada nome de usuário seja único no sistema.

---

## 📍 Localização do Problema

**Arquivo:** `api/v1/api.php`  
**Rota:** `/hall/api/member/register` (POST)  
**Linha aproximada:** Após a linha 361 (antes da validação de celular)

---

## 🔍 Como Identificar o Problema

### Sintomas:
1. É possível criar duas ou mais contas com o mesmo username
2. O sistema aceita o cadastro sem apresentar erro
3. Apenas o ID interno é diferente entre as contas duplicadas

### Verificação no Código:
Procure pela rota de registro e verifique se existe validação de unicidade do campo `mobile`:

```php
// ❌ PROBLEMA: Se você não encontrar esta validação, o problema existe
// Verifica se já existe usuário com o mesmo username (mobile)
if ($nome_user != null) {
    $stmt = $mysqli->prepare("SELECT id FROM usuarios WHERE mobile = ?");
    // ... validação
}
```

---

## ✅ Solução Passo a Passo

### Passo 1: Criar Backup do Arquivo

**⚠️ IMPORTANTE: Sempre faça backup antes de alterar código em produção!**

```bash
# No diretório do projeto
cd /caminho/do/seu/projeto

# Criar backup com timestamp
cp api/v1/api.php api/v1/api.php.backup_$(date +%Y%m%d_%H%M%S)
```

**Exemplo:**
```bash
cp api/v1/api.php api/v1/api.php.backup_20260107_153600
```

---

### Passo 2: Localizar a Rota de Registro

Abra o arquivo `api/v1/api.php` e procure pela linha:

```php
// Rota api/member/register (POST) --> Cadastro
if ($requestURI === '/hall/api/member/register') {
```

---

### Passo 3: Encontrar o Ponto de Inserção

Procure pela seção que verifica duplicidade de celular. Você encontrará algo assim:

```php
// Verifica se já existe usuário com o mesmo celular
if ($celular != null) {
    $stmt = $mysqli->prepare("SELECT id FROM usuarios WHERE celular = ?");
    $stmt->bind_param("s", $celular);
    $stmt->execute();
    $stmt->store_result();
    if ($stmt->num_rows > 0) {
        echo json_encode([
            "errorCode" => 41031031,
            "code" => 1031,
            "msg" => "O número do celular foi vinculado a outra conta. Verifique e insira novamente.",
            "time" => round(microtime(true) * 1000)
        ]);
        exit;
    }
    $stmt->close();
}
```

**📍 Você deve inserir a nova validação ANTES desta verificação de celular.**

---

### Passo 4: Adicionar a Validação de Username

**Cole o código abaixo ANTES da validação de celular:**

```php
// Verifica se já existe usuário com o mesmo username (mobile)
if ($nome_user != null) {
    $stmt = $mysqli->prepare("SELECT id FROM usuarios WHERE mobile = ?");
    $stmt->bind_param("s", $nome_user);
    $stmt->execute();
    $stmt->store_result();
    if ($stmt->num_rows > 0) {
        echo json_encode([
            "code" => 400,
            "msg" => "Este nome de usuário já está em uso. Escolha outro.",
            "data" => null,
            "succeed" => false,
            "time" => round(microtime(true) * 1000)
        ]);
        exit;
    }
    $stmt->close();
}
```

---

### Passo 5: Verificar a Estrutura Final

Após a correção, a ordem das validações deve ficar assim:

```php
// ... código anterior ...

// Verifica se já existe usuário com o mesmo username (mobile)
if ($nome_user != null) {
    $stmt = $mysqli->prepare("SELECT id FROM usuarios WHERE mobile = ?");
    $stmt->bind_param("s", $nome_user);
    $stmt->execute();
    $stmt->store_result();
    if ($stmt->num_rows > 0) {
        echo json_encode([
            "code" => 400,
            "msg" => "Este nome de usuário já está em uso. Escolha outro.",
            "data" => null,
            "succeed" => false,
            "time" => round(microtime(true) * 1000)
        ]);
        exit;
    }
    $stmt->close();
}

// Verifica se já existe usuário com o mesmo celular
if ($celular != null) {
    $stmt = $mysqli->prepare("SELECT id FROM usuarios WHERE celular = ?");
    // ... resto do código ...
}

// Função para gerar ID único de 9 dígitos
function gerarIdUnico($mysqli) {
    // ... código ...
}
```

---

### Passo 6: Validar a Sintaxe PHP

Após fazer a alteração, valide a sintaxe:

```bash
php -l api/v1/api.php
```

**Resultado esperado:**
```
No syntax errors detected in api/v1/api.php
```

Se aparecer algum erro, revise o código e verifique se:
- Todas as chaves `{ }` estão fechadas
- Não há vírgulas ou pontos e vírgulas faltando
- As aspas estão corretas

---

## 🧪 Como Testar a Correção

### Teste 1: Tentar criar conta com username duplicado

1. Crie uma conta normalmente (ex: username "teste123")
2. Tente criar outra conta com o mesmo username "teste123"
3. **Resultado esperado:** Deve retornar erro:
   ```json
   {
     "code": 400,
     "msg": "Este nome de usuário já está em uso. Escolha outro.",
     "data": null,
     "succeed": false
   }
   ```

### Teste 2: Verificar no banco de dados

```sql
-- Verificar se existem usuários duplicados (ANTES da correção)
SELECT mobile, COUNT(*) as total 
FROM usuarios 
GROUP BY mobile 
HAVING COUNT(*) > 1;
```

Se retornar resultados, você tem usuários duplicados que precisam ser tratados manualmente.

---

## 🔒 Proteção Adicional no Banco de Dados (Opcional mas Recomendado)

Para garantir que mesmo se houver um bug futuro, o banco de dados impeça duplicatas, adicione uma constraint UNIQUE:

### ⚠️ ATENÇÃO: Faça backup do banco antes!

```sql
-- 1. Verificar se já existe constraint
SHOW INDEX FROM usuarios WHERE Key_name = 'unique_mobile';

-- 2. Se não existir, adicionar constraint UNIQUE
ALTER TABLE usuarios ADD UNIQUE KEY unique_mobile (mobile);
```

**⚠️ IMPORTANTE:** 
- Se já existirem usuários duplicados, esta operação falhará
- Você precisará limpar os duplicados primeiro
- Faça backup completo do banco antes de executar

---

## 📝 Checklist de Aplicação

Use este checklist ao aplicar a correção em cada site:

- [ ] Backup do arquivo `api/v1/api.php` criado
- [ ] Rota `/hall/api/member/register` localizada
- [ ] Validação de username adicionada ANTES da validação de celular
- [ ] Sintaxe PHP validada (`php -l`)
- [ ] Teste de duplicação realizado
- [ ] Verificação de usuários duplicados no banco (se necessário)
- [ ] Constraint UNIQUE adicionada no banco (opcional, mas recomendado)

---

## 🐛 Troubleshooting

### Problema: "Erro de sintaxe após adicionar o código"

**Solução:**
- Verifique se todas as chaves `{ }` estão fechadas
- Confirme que não há vírgulas ou pontos e vírgulas faltando
- Use `php -l api/v1/api.php` para identificar o erro exato

### Problema: "A validação não está funcionando"

**Verificações:**
1. Confirme que a variável `$nome_user` está sendo definida antes da validação
2. Verifique se a query está correta: `SELECT id FROM usuarios WHERE mobile = ?`
3. Teste a query diretamente no banco de dados
4. Verifique se não há cache de API ativo

### Problema: "Já existem usuários duplicados no banco"

**Solução:**
1. Identifique os duplicados:
   ```sql
   SELECT mobile, COUNT(*) as total, GROUP_CONCAT(id) as ids
   FROM usuarios 
   GROUP BY mobile 
   HAVING COUNT(*) > 1;
   ```

2. Decida qual conta manter (geralmente a mais antiga)
3. Atualize ou remova as contas duplicadas manualmente
4. Depois adicione a constraint UNIQUE

---

## 📚 Explicação Técnica

### Por que isso aconteceu?

A rota de registro estava validando apenas:
- ✅ Duplicidade de celular
- ✅ Geração de ID único
- ❌ **Faltava:** Validação de unicidade do username

### Como a correção funciona?

1. **Antes de criar o usuário**, o sistema verifica se já existe um registro com o mesmo `mobile` (username)
2. Se encontrar, retorna erro imediatamente e **não cria** a conta
3. Se não encontrar, prossegue com as outras validações e criação da conta

### Variáveis importantes:

- `$nome_user`: Contém o username que será salvo no campo `mobile`
- `$mobile`: Campo no banco de dados que armazena o username
- `$celular`: Campo separado que armazena o número de telefone

---

## 📞 Suporte

Se encontrar problemas ao aplicar esta correção:

1. Verifique se o backup foi criado corretamente
2. Revise a sintaxe PHP com `php -l`
3. Confirme que a estrutura do banco está correta
4. Teste em ambiente de desenvolvimento primeiro

---

## ✅ Resultado Final

Após aplicar esta correção:

- ✅ Usuários não poderão criar contas com username duplicado
- ✅ Sistema retornará mensagem clara de erro
- ✅ Integridade dos dados será mantida
- ✅ Segurança do sistema será melhorada

---

**Data de criação:** 07/01/2025  
**Versão do documento:** 1.0  
**Autor:** Sistema de correção automática

