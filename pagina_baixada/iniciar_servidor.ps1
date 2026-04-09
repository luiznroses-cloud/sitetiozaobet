# Script para iniciar servidor local e testar página offline
# Navegar para o diretório da página baixada
Set-Location "E:\SITE\hiper\pagina_baixada"

# Verificar se Python está instalado
$pythonInstalled = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonInstalled) {
    Write-Host "Python não encontrado. Tentando com python3..." -ForegroundColor Yellow
    $pythonInstalled = Get-Command python3 -ErrorAction SilentlyContinue
    if (-not $pythonInstalled) {
        Write-Host "Python não encontrado. Instale o Python primeiro." -ForegroundColor Red
        exit 1
    }
    $pythonCmd = "python3"
} else {
    $pythonCmd = "python"
}

Write-Host "Iniciando servidor HTTP local na porta 8000..." -ForegroundColor Green
Write-Host "Acesse: http://localhost:8000/teste_offline.html" -ForegroundColor Cyan
Write-Host "Ou diretamente: http://localhost:8000/hiper.html" -ForegroundColor Cyan
Write-Host "Pressione Ctrl+C para parar o servidor" -ForegroundColor Yellow

# Iniciar servidor HTTP simples do Python
& $pythonCmd -m http.server 8000