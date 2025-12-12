@echo off
setlocal enabledelayedexpansion

echo =========================================
echo   Arduino Bibliotheken Installation
echo =========================================
echo.

:: === Skript-Verzeichnis ermitteln ===
set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT=%SCRIPT_DIR%"

:: === Dokumente-Verzeichnis zuverlaessig ermitteln ===
echo [1/6] Ermittle Dokumente-Verzeichnis...

:: Registry-Abfrage fuer Dokumente-Verzeichnis (funktioniert auch mit OneDrive)
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Personal 2^>nul ^| find "Personal"') do (
    set "DOCS_DIR=%%b"
)

:: Umgebungsvariablen in Pfad expandieren (z.B. %USERPROFILE%)
if defined DOCS_DIR (
    call set "DOCS_DIR=!DOCS_DIR!"
)

:: Finale Ueberpruefung
if not defined DOCS_DIR (
    echo.
    echo   [FEHLER] Dokumente-Verzeichnis konnte nicht ermittelt werden!
    echo   Registry-Abfrage fehlgeschlagen.
    pause
    exit /b 1
)

if not exist "!DOCS_DIR!" (
    echo.
    echo   [FEHLER] Dokumente-Verzeichnis existiert nicht!
    echo   Erwarteter Pfad: !DOCS_DIR!
    pause
    exit /b 1
)

echo   ^[OK^] Dokumente-Verzeichnis gefunden: !DOCS_DIR!
echo.

:: === Arduino Libraries Zielverzeichnis ===
set "ARDUINO_LIBS=!DOCS_DIR!\Arduino\libraries"
set "SOURCE_LIBS=%SCRIPT_DIR%libraries"

echo [2/6] Kopiere Bibliotheken...
echo   - Quelle: %SOURCE_LIBS%
echo   - Ziel: !ARDUINO_LIBS!

:: Überprüfen ob Quellverzeichnis existiert
if not exist "%SOURCE_LIBS%" (
    echo   [WARNUNG] Quellverzeichnis 'libraries' nicht gefunden!
    echo   Verzeichnis wird ueberspungen.
    set "LIBS_COPIED=0"
) else (
    :: Arduino\libraries Verzeichnis erstellen falls nicht vorhanden
    if not exist "!ARDUINO_LIBS!" (
        echo   - Erstelle Zielverzeichnis: !ARDUINO_LIBS!
        mkdir "!ARDUINO_LIBS!" 2>nul
        if errorlevel 1 (
            echo   [FEHLER] Konnte Zielverzeichnis nicht erstellen!
            pause
            exit /b 1
        )
    )

    :: Inhalt des libraries-Ordners kopieren
    echo   - Kopiere Bibliotheken...
    xcopy "%SOURCE_LIBS%\*" "!ARDUINO_LIBS!\" /E /I /Y /Q >nul 2>&1
    
    if errorlevel 1 (
        echo   [FEHLER] Fehler beim Kopieren der Bibliotheken!
        set "LIBS_COPIED=0"
    ) else (
        echo   ^[OK^] Bibliotheken erfolgreich kopiert
        set "LIBS_COPIED=1"
    )
)
echo.

:: === Arduino IDE Plugins Zielverzeichnis ===
set "ARDUINO_IDE_DIR=%USERPROFILE%\.arduinoIDE"
set "SOURCE_PLUGINS=%SCRIPT_DIR%plugins"

echo [3/6] Kopiere Plugins...
echo   - Quelle: %SOURCE_PLUGINS%
echo   - Ziel: !ARDUINO_IDE_DIR!

:: Überprüfen ob Quellverzeichnis existiert
if not exist "%SOURCE_PLUGINS%" (
    echo   [WARNUNG] Quellverzeichnis 'plugins' nicht gefunden!
    echo   Verzeichnis wird ueberspungen.
    set "PLUGINS_COPIED=0"
) else (
    :: .arduinoIDE Verzeichnis erstellen falls nicht vorhanden
    if not exist "!ARDUINO_IDE_DIR!" (
        echo   - Erstelle Zielverzeichnis: !ARDUINO_IDE_DIR!
        mkdir "!ARDUINO_IDE_DIR!" 2>nul
        if errorlevel 1 (
            echo   [FEHLER] Konnte Zielverzeichnis nicht erstellen!
            pause
            exit /b 1
        )
    )

    :: Plugins-Ordner komplett kopieren
    echo   - Kopiere Plugins...
    xcopy "%SOURCE_PLUGINS%" "!ARDUINO_IDE_DIR!\plugins\" /E /I /Y /Q >nul 2>&1
    
    if errorlevel 1 (
        echo   [FEHLER] Fehler beim Kopieren der Plugins!
        set "PLUGINS_COPIED=0"
    ) else (
        echo   ^[OK^] Plugins erfolgreich kopiert
        set "PLUGINS_COPIED=1"
    )
)
echo.

:: === Projekt-Verzeichnis kopieren ===
set "ARDUINO_DIR=!DOCS_DIR!\Arduino"
set "TARGET_PROJECT=!ARDUINO_DIR!\2025-WI-Schnuppertag"
set "SOURCE_PROJECT=%PROJECT_ROOT%\2025-WI-Schnuppertag"

echo [4/6] Kopiere Projekt-Verzeichnis...
echo   - Quelle: %SOURCE_PROJECT%
echo   - Ziel: !TARGET_PROJECT!

:: Überprüfen ob Quellverzeichnis existiert
if not exist "%SOURCE_PROJECT%" (
    echo   [WARNUNG] Quellverzeichnis '2025-WI-Schnuppertag' nicht gefunden!
    echo   Verzeichnis wird ueberspungen.
    set "PROJECT_COPIED=0"
) else (
    :: Arduino Verzeichnis erstellen falls nicht vorhanden
    if not exist "!ARDUINO_DIR!" (
        echo   - Erstelle Arduino-Verzeichnis: !ARDUINO_DIR!
        mkdir "!ARDUINO_DIR!" 2>nul
        if errorlevel 1 (
            echo   [FEHLER] Konnte Arduino-Verzeichnis nicht erstellen!
            pause
            exit /b 1
        )
    )

    :: Altes Verzeichnis loeschen falls vorhanden
    if exist "!TARGET_PROJECT!" (
        echo   - Loesche altes Verzeichnis: !TARGET_PROJECT!
        rmdir /s /q "!TARGET_PROJECT!" 2>nul
        if errorlevel 1 (
            echo   [FEHLER] Konnte altes Verzeichnis nicht loeschen!
            echo   Stelle sicher, dass keine Dateien geoeffnet sind.
            pause
            exit /b 1
        )
    )

    :: Projekt-Verzeichnis komplett kopieren
    echo   - Kopiere Projekt-Verzeichnis...
    xcopy "%SOURCE_PROJECT%" "!TARGET_PROJECT!\" /E /I /Y /Q >nul 2>&1
    
    if errorlevel 1 (
        echo   [FEHLER] Fehler beim Kopieren des Projekt-Verzeichnisses!
        set "PROJECT_COPIED=0"
    ) else (
        echo   ^[OK^] Projekt-Verzeichnis erfolgreich kopiert
        set "PROJECT_COPIED=1"
    )
)
echo.

:: === Desktop-Dateien kopieren ===
echo [5/6] Kopiere Desktop-Dateien...

:: Registry-Abfrage fuer Desktop-Verzeichnis (funktioniert auch mit OneDrive)
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop 2^>nul ^| find "Desktop"') do (
    set "DESKTOP_DIR=%%b"
)

:: Umgebungsvariablen in Pfad expandieren
if defined DESKTOP_DIR (
    call set "DESKTOP_DIR=!DESKTOP_DIR!"
)

if not defined DESKTOP_DIR (
    echo.
    echo   [FEHLER] Desktop-Verzeichnis konnte nicht ermittelt werden!
    set "DESKTOP_COPIED=0"
    goto :skip_desktop
)

echo   ^[OK^] Desktop-Verzeichnis gefunden: !DESKTOP_DIR!

set "SOURCE_DESKTOP=%SCRIPT_DIR%Desktop"

echo   - Quelle: %SOURCE_DESKTOP%
echo   - Ziel: !DESKTOP_DIR!

:: Ueberpruefen ob Quellverzeichnis existiert
if not exist "%SOURCE_DESKTOP%" (
    echo   [WARNUNG] Quellverzeichnis 'Desktop' nicht gefunden!
    echo   Verzeichnis wird ueberspungen.
    set "DESKTOP_COPIED=0"
) else (
    :: Desktop-Verzeichnis sollte existieren, aber sicherheitshalber prüfen
    if not exist "!DESKTOP_DIR!" (
        echo   [FEHLER] Desktop-Verzeichnis existiert nicht: !DESKTOP_DIR!
        set "DESKTOP_COPIED=0"
    ) else (
        :: Inhalt des Desktop-Ordners kopieren (ohne Unterordner zu erstellen)
        echo   - Kopiere Desktop-Dateien...
        xcopy "%SOURCE_DESKTOP%\*" "!DESKTOP_DIR!\" /E /I /Y /Q >nul 2>&1
        
        if errorlevel 1 (
            echo   [FEHLER] Fehler beim Kopieren der Desktop-Dateien!
            set "DESKTOP_COPIED=0"
        ) else (
            echo   ^[OK^] Desktop-Dateien erfolgreich kopiert
            set "DESKTOP_COPIED=1"
        )
    )
)

:skip_desktop
echo.

:: === Zusammenfassung ===
echo =========================================
echo   Installation abgeschlossen
echo =========================================
echo.

:: Ueberpruefung der Ergebnisse
set "SUCCESS=1"

if "!LIBS_COPIED!"=="1" (
    echo ^[OK^] Bibliotheken: !ARDUINO_LIBS!
    if exist "!ARDUINO_LIBS!" (
        dir "!ARDUINO_LIBS!" /B /A:D 2>nul | find /C /V "" > nul
        if errorlevel 1 (
            echo      ^(Keine Unterordner gefunden^)
        ) else (
            echo      Installierte Bibliotheken:
            for /d %%d in ("!ARDUINO_LIBS!\*") do echo      - %%~nxd
        )
    )
) else (
    if exist "%SOURCE_LIBS%" (
        echo [FEHLER] Bibliotheken konnten nicht kopiert werden!
        set "SUCCESS=0"
    ) else (
        echo [INFO] Keine Bibliotheken zum Installieren vorhanden
    )
)
echo.

if "!PLUGINS_COPIED!"=="1" (
    echo ^[OK^] Plugins: !ARDUINO_IDE_DIR!\plugins
    if exist "!ARDUINO_IDE_DIR!\plugins" (
        dir "!ARDUINO_IDE_DIR!\plugins" /B 2>nul | find /C /V "" > nul
        if errorlevel 1 (
            echo      ^(Keine Dateien gefunden^)
        ) else (
            echo      Installierte Plugins:
            dir "!ARDUINO_IDE_DIR!\plugins" /B 2>nul | findstr /R ".*" | more +0
        )
    )
) else (
    if exist "%SOURCE_PLUGINS%" (
        echo [FEHLER] Plugins konnten nicht kopiert werden!
        set "SUCCESS=0"
    ) else (
        echo [INFO] Keine Plugins zum Installieren vorhanden
    )
)
echo.

if "!PROJECT_COPIED!"=="1" (
    echo ^[OK^] Projekt: !TARGET_PROJECT!
    if exist "!TARGET_PROJECT!" (
        echo      Projekt-Dateien erfolgreich installiert
    )
) else (
    if exist "%SOURCE_PROJECT%" (
        echo [FEHLER] Projekt-Verzeichnis konnte nicht kopiert werden!
        set "SUCCESS=0"
    ) else (
        echo [INFO] Kein Projekt-Verzeichnis zum Installieren vorhanden
    )
)
echo.

if "!DESKTOP_COPIED!"=="1" (
    echo ^[OK^] Desktop-Dateien: !DESKTOP_DIR!
    if exist "!DESKTOP_DIR!" (
        echo      Desktop-Dateien erfolgreich kopiert
    )
) else (
    if exist "%SOURCE_DESKTOP%" (
        echo [FEHLER] Desktop-Dateien konnten nicht kopiert werden!
        set "SUCCESS=0"
    ) else (
        echo [INFO] Keine Desktop-Dateien zum Kopieren vorhanden
    )
)
echo.

if "!SUCCESS!"=="0" (
    echo =========================================
    echo   Installation mit Fehlern beendet!
    echo =========================================
    pause
    exit /b 1
) else (
    echo =========================================
    echo   Installation erfolgreich!
    echo =========================================
    echo.
    
    :: === Arduino IDE mit Sketch starten ===
    echo [6/6] Starte Arduino IDE...
    
    :: Arduino IDE Pfad suchen
    set "ARDUINO_EXE="
    
    if exist "%LOCALAPPDATA%\Programs\Arduino IDE\Arduino IDE.exe" (
        set "ARDUINO_EXE=%LOCALAPPDATA%\Programs\Arduino IDE\Arduino IDE.exe"
    )
    
    if not defined ARDUINO_EXE (
        if exist "C:\Program Files\Arduino IDE\Arduino IDE.exe" (
            set "ARDUINO_EXE=C:\Program Files\Arduino IDE\Arduino IDE.exe"
        )
    )
    
    if not defined ARDUINO_EXE (
        if exist "%ProgramFiles(x86)%\Arduino IDE\Arduino IDE.exe" (
            set "ARDUINO_EXE=%ProgramFiles(x86)%\Arduino IDE\Arduino IDE.exe"
        )
    )
    
    :: Sketch-Pfad ermitteln
    set "SKETCH_PATH=!ARDUINO_DIR!\2025-WI-Schnuppertag\01_Programmieren\01_Programmieren.ino"
    
    if defined ARDUINO_EXE (
        if exist "!SKETCH_PATH!" (
            echo   ^[OK^] Arduino IDE gefunden: !ARDUINO_EXE!
            echo   ^[OK^] Oeffne Sketch: 01_Programmieren
            echo.
            powershell -WindowStyle Hidden -Command "Start-Process -FilePath '!ARDUINO_EXE!' -ArgumentList '!SKETCH_PATH!'"
        ) else (
            echo   [WARNUNG] Sketch nicht gefunden: !SKETCH_PATH!
            echo   Starte Arduino IDE ohne Sketch...
            powershell -WindowStyle Hidden -Command "Start-Process -FilePath '!ARDUINO_EXE!'"
        )
    ) else (
        echo   [WARNUNG] Arduino IDE nicht gefunden!
        echo   Bitte installiere die Arduino IDE oder oeffne den Sketch manuell.
        echo.
    )
    
    timeout /t 2 /nobreak >nul
    exit /b 0
)
