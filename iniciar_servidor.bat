@echo off
REM Script para iniciar servidor HTTP local (CMD)
setlocal enabledelayedexpansion

set ARQUIVO=hiper.html
set PORTA=8000

if "%1"=="" (
    set ARQUIVO=hiper.html
) else (
    set ARQUIVO=%1%
)

if "%2"=="" (
    set PORTA=8000
) else (
    set PORTA=%2%
)

cls
echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║              SERVIDOR HTTP LOCAL - TESTE DE PÁGINAS            ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

if not exist "%ARQUIVO%" (
    echo ❌ Erro: Arquivo '%ARQUIVO%' não encontrado!
    echo.
    echo Arquivos disponíveis:
    dir /B *.html
    pause
    exit /b 1
)

echo ⚙️  Ativando virtual environment...
call venv\Scripts\activate.bat
echo ✅ Virtual environment ativado
echo.

echo 🚀 Iniciando servidor HTTP na porta %PORTA%...
echo 📄 Arquivo: %ARQUIVO%
echo.

echo ════════════════════════════════════════════════════════════════
echo    🌐 Acesse: http://localhost:%PORTA%/%ARQUIVO%
echo    📋 Pressione Ctrl+C para parar o servidor
echo ════════════════════════════════════════════════════════════════
echo.

echo 🌍 Abrindo navegador...
timeout /t 2 /nobreak
start http://localhost:%PORTA%/%ARQUIVO%

echo.
python -m http.server %PORTA%

pause
