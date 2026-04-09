# Script para iniciar servidor HTTP local e abrir a página em teste
param(
    [string]$Arquivo = "hiper.html",
    [int]$Porta = 8000
)

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║              SERVIDOR HTTP LOCAL - TESTE DE PÁGINAS            ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Verifica se o arquivo existe
if (-not (Test-Path $Arquivo)) {
    Write-Host "❌ Erro: Arquivo '$Arquivo' não encontrado!" -ForegroundColor Red
    Write-Host "Arquivos disponíveis:" -ForegroundColor Yellow
    Get-ChildItem *.html | Select-Object Name
    exit 1
}

# Ativa venv
Write-Host "⚙️  Ativando virtual environment..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1

Write-Host "✅ Virtual environment ativado" -ForegroundColor Green
Write-Host ""

# Inicia servidor
Write-Host "🚀 Iniciando servidor HTTP na porta $Porta..." -ForegroundColor Green
Write-Host "📄 Arquivo: $Arquivo" -ForegroundColor Cyan
Write-Host ""
Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "   🌐 Acesse: http://localhost:$Porta/$Arquivo" -ForegroundColor Green
Write-Host "   📋 Pressione Ctrl+C para parar o servidor" -ForegroundColor Yellow
Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""

# Aguarda um pouco e abre no navegador
Start-Sleep -Seconds 2

$url = "http://localhost:$Porta/$Arquivo"
Write-Host "🌍 Abrindo navegador em: $url" -ForegroundColor Cyan

try {
    Start-Process $url
}
catch {
    Write-Host "⚠️ Não foi possível abrir o navegador automaticamente" -ForegroundColor Yellow
    Write-Host "   Abra manualmente: $url" -ForegroundColor Yellow
}

Write-Host ""

# Inicia servidor
python -m http.server $Porta --directory .
