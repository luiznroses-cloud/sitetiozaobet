@echo off
REM Script para testar a página movida para a pasta hiper
cd /d e:\SITE\hiper\pagina_baixada
python -m http.server 8000
pause