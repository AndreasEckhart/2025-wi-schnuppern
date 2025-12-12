@echo off
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

set "INSTALL_SCRIPT_PS1=!DOWNLOADS_DIR!\%TARGET_DIR%\Install\2025-WI-Schnuppertag-Install.ps1"
set "INSTALL_SCRIPT_CMD=!DOWNLOADS_DIR!\%TARGET_DIR%\Install\2025-WI-Schnuppertag-Install.cmd"

:: Pruefe PowerShell-Version zuerst
if exist "!INSTALL_SCRIPT_PS1!" (
    echo   [OK] PowerShell Install-Script gefunden
    echo   Starte Installation...
    echo.
    start "" powershell -ExecutionPolicy Bypass -NoProfile -File "!INSTALL_SCRIPT_PS1!"
    exit
)

:: Fallback auf CMD-Version
if exist "!INSTALL_SCRIPT_CMD!" (
    echo   [OK] CMD Install-Script gefunden
    echo   Starte Installation...
    echo.
    start "" "!INSTALL_SCRIPT_CMD!"
    exit
)

:: Kein Script gefunden
echo   [FEHLER] Install-Script nicht gefunden!
echo   Gesucht:
echo   - !INSTALL_SCRIPT_PS1!
echo   - !INSTALL_SCRIPT_CMD!
pause
exit /b 1
