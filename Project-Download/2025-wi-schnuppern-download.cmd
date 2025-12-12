@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: === Einstellungen ===
set REPO_OWNER=AndreasEckhart
set REPO_NAME=2025-wi-schnuppern
set ZIP_URL=https://github.com/%REPO_OWNER%/%REPO_NAME%/archive/refs/heads/main.zip

:: === Downloads-Verzeichnis ermitteln ===
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" 2^>nul ^| find "374DE290"') do (
    set "DOWNLOADS_DIR=%%b"
)

:: Umgebungsvariablen expandieren
if defined DOWNLOADS_DIR (
    call set "DOWNLOADS_DIR=!DOWNLOADS_DIR!"
)

:: Fallback auf Standard-Downloads-Pfad
if not defined DOWNLOADS_DIR (
    set "DOWNLOADS_DIR=%USERPROFILE%\Downloads"
)

if not exist "!DOWNLOADS_DIR!" (
    echo ✗ [FEHLER] Downloads-Verzeichnis nicht gefunden: !DOWNLOADS_DIR!
    pause
    exit /b 1
)

echo =========================================
echo   GitHub Repository herunterladen
echo =========================================
echo Ziel: !DOWNLOADS_DIR!
echo Lade %ZIP_URL%
echo.

:: Wechsle ins Downloads-Verzeichnis
cd /d "!DOWNLOADS_DIR!"

set "ZIP_FILE=%REPO_NAME%.zip"
set "TARGET_DIR=%REPO_NAME%"

:: Versuche curl mit SSL-Fehlerbehandlung
curl -L -k -o "%ZIP_FILE%" "%ZIP_URL%" 2>nul
if errorlevel 1 (
    echo   Curl fehlgeschlagen, versuche PowerShell...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile '%ZIP_FILE%' -UseBasicParsing"
    if errorlevel 1 (
        echo   ✗ [FEHLER] Download fehlgeschlagen!
        pause
        exit /b 1
    )
)

echo   ✓ Download erfolgreich
echo.
echo =========================================
echo   ZIP entpacken
echo =========================================

if exist "%TARGET_DIR%" (
    echo   - Entferne alten Ordner "%TARGET_DIR%"...
    rmdir /s /q "%TARGET_DIR%" 2>nul
)

echo   - Entpacke ZIP-Archiv...
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '.' -Force" 2>nul
if errorlevel 1 (
    echo   ✗ [FEHLER] Entpacken fehlgeschlagen!
    pause
    exit /b 1
)

if exist "%REPO_NAME%-main" (
    ren "%REPO_NAME%-main" "%TARGET_DIR%"
)

del "%ZIP_FILE%" 2>nul

echo   ✓ Fertig entpackt
echo.

echo =========================================
echo   Installation starten
echo =========================================

set "INSTALL_SCRIPT=!DOWNLOADS_DIR!\%TARGET_DIR%\Install\2025-WI-Schnuppertag-Install.cmd"

if not exist "!INSTALL_SCRIPT!" (
    echo   ✗ [FEHLER] Install-Script nicht gefunden!
    echo   Erwarteter Pfad: !INSTALL_SCRIPT!
    pause
    exit /b 1
)

echo   ✓ Install-Script gefunden
echo   Starte Installation...
echo.

timeout /t 2 /nobreak >nul

:: Install-Script ausführen
call "!INSTALL_SCRIPT!"

exit /b 0
