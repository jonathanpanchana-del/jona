@echo off
title Sistema Documental en red
cd /d "%~dp0"
echo ============================================
echo  Sistema Documental compartido en red
echo ============================================
echo  1. Deja tambien encendido mi-firebase-local\INICIAR.bat
echo  2. En otro PC/celular (mismo WiFi) abre:
echo     http://10.10.10.211:8000/documentos.html
echo.
echo  Para detener: Ctrl + C
echo ============================================
python -m http.server 8000
pause
