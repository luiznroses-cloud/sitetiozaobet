# Script para testar a página movida
param([int]$Porta = 8000)

Write-Host "🚀 Iniciando servidor para testar página movida..." -ForegroundColor Green
Write-Host "📁 Localização: e:\SITE\hiper\pagina_baixada" -ForegroundColor Cyan
Write-Host ""

Set-Location "e:\SITE\hiper\pagina_baixada"

Write-Host "🌐 Servidor online em: http://localhost:$Porta/hiper.html" -ForegroundColor Green
Write-Host "📋 Pressione Ctrl+C para parar" -ForegroundColor Yellow
Write-Host ""

python -m http.server $Porta