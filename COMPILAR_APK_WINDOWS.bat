@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0COMPILAR_APK_WINDOWS.ps1"
if errorlevel 1 (
  echo.
  echo No se pudo compilar. Lee el mensaje anterior.
)
pause
