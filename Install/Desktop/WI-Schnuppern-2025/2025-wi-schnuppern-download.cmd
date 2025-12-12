@echo off
setlocal

:: === Einstellungen ===
set REPO_OWNER=AndreasEckhart
set REPO_NAME=2025-wi-schnuppern
set ZIP_URL=https://github.com/%REPO_OWNER%/%REPO_NAME%/archive/refs/heads/main.zip
set TARGET_DIR=%REPO_NAME%
set ZIP_FILE=%REPO_NAME%.zip

echo =========================================
echo   GitHub Repository herunterladen
echo =========================================
echo Lade %ZIP_URL%
echo.

curl -L -o "%ZIP_FILE%" "%ZIP_URL%"
if errorlevel 1 (
    echo Fehler beim Herunterladen!
    pause
    exit /b 1
)

echo.
echo =========================================
echo   ZIP entpacken
echo =========================================

if exist "%TARGET_DIR%" (
    echo Entferne alten Ordner "%TARGET_DIR%"...
    rmdir /s /q "%TARGET_DIR%"
)

powershell -command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath ."

if exist "%REPO_NAME%-main" (
    ren "%REPO_NAME%-main" "%TARGET_DIR%"
)

del "%ZIP_FILE%"

echo Fertig entpackt.
echo.

echo =========================================
echo   Arduino IDE suchen
echo =========================================

set ARDUINO_PATH1=%LOCALAPPDATA%\Programs\Arduino IDE\Arduino IDE.exe
set ARDUINO_PATH2=C:\Programme\Arduino IDE\Arduino IDE.exe

set IDE_PATH=

if exist "%ARDUINO_PATH1%" (
    set IDE_PATH=%ARDUINO_PATH1%
    echo Arduino IDE im Benutzerpfad gefunden.
) else (
    if exist "%ARDUINO_PATH2%" (
        set IDE_PATH=%ARDUINO_PATH2%
        echo Arduino IDE in C:\Programme gefunden.
    )
)

if "%IDE_PATH%"=="" (
    echo Fehler: Arduino IDE wurde nicht gefunden!
    pause
    exit /b 1
)

echo Verwende Arduino IDE: "%IDE_PATH%"
echo.

echo =========================================
echo   Schnuppern.ino vorbereiten
echo =========================================

set INO_PATH=%TARGET_DIR%\Schnuppern\Schnuppern.ino

if not exist "%INO_PATH%" (
    echo Fehler: Die Datei "%INO_PATH%" wurde nicht gefunden!
    pause
    exit /b 1
)

echo Gefunden: "%INO_PATH%"
echo.

echo =========================================
echo   Arduino IDE starten
echo =========================================

start "" "%IDE_PATH%" "%INO_PATH%"

echo Arduino IDE wurde mit Schnuppern.ino gestartet.
echo.
pause
