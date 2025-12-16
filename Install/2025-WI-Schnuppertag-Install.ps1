# Arduino Installation Script
# PowerShell Version - keine Probleme mit Umlauten

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Arduino Bibliotheken Installation" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Skript-Verzeichnis ermitteln
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$PROJECT_ROOT = $SCRIPT_DIR

# === Dokumente-Verzeichnis ermitteln ===
Write-Host "[1/6] Ermittle Dokumente-Verzeichnis..." -ForegroundColor Yellow

$DOCS_DIR = [Environment]::GetFolderPath("MyDocuments")

if (-not (Test-Path $DOCS_DIR)) {
    Write-Host "  [FEHLER] Dokumente-Verzeichnis nicht gefunden!" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit 1
}

Write-Host "  [OK] Dokumente-Verzeichnis gefunden: $DOCS_DIR" -ForegroundColor Green
Write-Host ""

# === Arduino Libraries ===
$ARDUINO_LIBS = Join-Path $DOCS_DIR "Arduino\libraries"
$SOURCE_LIBS = Join-Path $SCRIPT_DIR "libraries"

Write-Host "[2/6] Kopiere Bibliotheken..." -ForegroundColor Yellow
Write-Host "  - Quelle: $SOURCE_LIBS"
Write-Host "  - Ziel: $ARDUINO_LIBS"

$LIBS_COPIED = $false

if (-not (Test-Path $SOURCE_LIBS)) {
    Write-Host "  [WARNUNG] Quellverzeichnis 'libraries' nicht gefunden!" -ForegroundColor Yellow
    Write-Host "  Verzeichnis wird uebersprungen."
} else {
    # Arduino\libraries Verzeichnis erstellen
    if (-not (Test-Path $ARDUINO_LIBS)) {
        Write-Host "  - Erstelle Zielverzeichnis..."
        New-Item -ItemType Directory -Path $ARDUINO_LIBS -Force | Out-Null
    }
    
    Write-Host "  - Kopiere Bibliotheken..."
    try {
        Copy-Item -Path "$SOURCE_LIBS\*" -Destination $ARDUINO_LIBS -Recurse -Force -ErrorAction Stop
        Write-Host "  [OK] Bibliotheken erfolgreich kopiert" -ForegroundColor Green
        $LIBS_COPIED = $true
    } catch {
        Write-Host "  [FEHLER] Fehler beim Kopieren: $_" -ForegroundColor Red
    }
}
Write-Host ""

# === Arduino IDE Plugins ===
$ARDUINO_IDE_DIR = Join-Path $env:USERPROFILE ".arduinoIDE"
$SOURCE_PLUGINS = Join-Path $SCRIPT_DIR "plugins"

Write-Host "[3/6] Kopiere Plugins..." -ForegroundColor Yellow
Write-Host "  - Quelle: $SOURCE_PLUGINS"
Write-Host "  - Ziel: $ARDUINO_IDE_DIR"

$PLUGINS_COPIED = $false

if (-not (Test-Path $SOURCE_PLUGINS)) {
    Write-Host "  [WARNUNG] Quellverzeichnis 'plugins' nicht gefunden!" -ForegroundColor Yellow
    Write-Host "  Verzeichnis wird uebersprungen."
} else {
    if (-not (Test-Path $ARDUINO_IDE_DIR)) {
        Write-Host "  - Erstelle Zielverzeichnis..."
        New-Item -ItemType Directory -Path $ARDUINO_IDE_DIR -Force | Out-Null
    }
    
    $PLUGINS_TARGET = Join-Path $ARDUINO_IDE_DIR "plugins"
    
    Write-Host "  - Kopiere Plugins..."
    try {
        Copy-Item -Path $SOURCE_PLUGINS -Destination $PLUGINS_TARGET -Recurse -Force -ErrorAction Stop
        Write-Host "  [OK] Plugins erfolgreich kopiert" -ForegroundColor Green
        $PLUGINS_COPIED = $true
    } catch {
        Write-Host "  [FEHLER] Fehler beim Kopieren: $_" -ForegroundColor Red
    }
}
Write-Host ""

# === Projekt-Verzeichnis ===
$ARDUINO_DIR = Join-Path $DOCS_DIR "Arduino"
$TARGET_PROJECT = Join-Path $ARDUINO_DIR "2025-WI-Schnuppertag"
$SOURCE_PROJECT = Join-Path $PROJECT_ROOT "2025-WI-Schnuppertag"

Write-Host "[4/6] Kopiere Projekt-Verzeichnis..." -ForegroundColor Yellow
Write-Host "  - Quelle: $SOURCE_PROJECT"
Write-Host "  - Ziel: $TARGET_PROJECT"

$PROJECT_COPIED = $false

if (-not (Test-Path $SOURCE_PROJECT)) {
    Write-Host "  [WARNUNG] Quellverzeichnis '2025-WI-Schnuppertag' nicht gefunden!" -ForegroundColor Yellow
    Write-Host "  Verzeichnis wird uebersprungen."
} else {
    if (-not (Test-Path $ARDUINO_DIR)) {
        Write-Host "  - Erstelle Arduino-Verzeichnis..."
        New-Item -ItemType Directory -Path $ARDUINO_DIR -Force | Out-Null
    }
    
    # Altes Verzeichnis loeschen
    if (Test-Path $TARGET_PROJECT) {
        Write-Host "  - Loesche altes Verzeichnis..."
        try {
            Remove-Item -Path $TARGET_PROJECT -Recurse -Force -ErrorAction Stop
        } catch {
            Write-Host "  [FEHLER] Konnte altes Verzeichnis nicht loeschen!" -ForegroundColor Red
            Write-Host "  Stelle sicher, dass keine Dateien geoeffnet sind."
            Start-Sleep -Seconds 3
            exit 1
        }
    }
    
    Write-Host "  - Kopiere Projekt-Verzeichnis..."
    try {
        Copy-Item -Path $SOURCE_PROJECT -Destination $TARGET_PROJECT -Recurse -Force -ErrorAction Stop
        Write-Host "  [OK] Projekt-Verzeichnis erfolgreich kopiert" -ForegroundColor Green
        $PROJECT_COPIED = $true
    } catch {
        Write-Host "  [FEHLER] Fehler beim Kopieren: $_" -ForegroundColor Red
    }
}
Write-Host ""

# === Desktop-Dateien ===
Write-Host "[5/6] Kopiere Desktop-Dateien..." -ForegroundColor Yellow

$DESKTOP_DIR = [Environment]::GetFolderPath("Desktop")
$SOURCE_DESKTOP = Join-Path $SCRIPT_DIR "Desktop"

Write-Host "  - Quelle: $SOURCE_DESKTOP"
Write-Host "  - Ziel: $DESKTOP_DIR"

$DESKTOP_COPIED = $false

if (-not (Test-Path $SOURCE_DESKTOP)) {
    Write-Host "  [WARNUNG] Quellverzeichnis 'Desktop' nicht gefunden!" -ForegroundColor Yellow
    Write-Host "  Verzeichnis wird uebersprungen."
} else {
    # Falls der Zielordner schon existiert (z. B. WI-Schnuppern-2025), vorher aufraeumen
    $TARGET_DESKTOP_FOLDER = Join-Path $DESKTOP_DIR "WI-Schnuppern-2025"
    if (Test-Path $TARGET_DESKTOP_FOLDER) {
        Write-Host "  - Entferne alten Desktop-Ordner: $TARGET_DESKTOP_FOLDER"
        try {
            Remove-Item -Path $TARGET_DESKTOP_FOLDER -Recurse -Force -ErrorAction Stop
        } catch {
            Write-Host "  [FEHLER] Konnte alten Desktop-Ordner nicht loeschen!" -ForegroundColor Red
            Write-Host "  Stelle sicher, dass keine Dateien geoeffnet sind."
        }
    }

    Write-Host "  - Kopiere Desktop-Dateien..."
    try {
        Copy-Item -Path "$SOURCE_DESKTOP\*" -Destination $DESKTOP_DIR -Recurse -Force -ErrorAction Stop
        Write-Host "  [OK] Desktop-Dateien erfolgreich kopiert" -ForegroundColor Green
        $DESKTOP_COPIED = $true
    } catch {
        Write-Host "  [FEHLER] Fehler beim Kopieren: $_" -ForegroundColor Red
    }
}
Write-Host ""

# === Zusammenfassung ===
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Installation abgeschlossen" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

$SUCCESS = $true

if ($LIBS_COPIED) {
    Write-Host "[OK] Bibliotheken: $ARDUINO_LIBS" -ForegroundColor Green
    if (Test-Path $ARDUINO_LIBS) {
        $libs = Get-ChildItem -Path $ARDUINO_LIBS -Directory -ErrorAction SilentlyContinue
        if ($libs) {
            Write-Host "     Installierte Bibliotheken:"
            $libs | ForEach-Object { Write-Host "     - $($_.Name)" }
        }
    }
} elseif (Test-Path $SOURCE_LIBS) {
    Write-Host "[FEHLER] Bibliotheken konnten nicht kopiert werden!" -ForegroundColor Red
    $SUCCESS = $false
} else {
    Write-Host "[INFO] Keine Bibliotheken zum Installieren vorhanden"
}
Write-Host ""

if ($PLUGINS_COPIED) {
    Write-Host "[OK] Plugins: $(Join-Path $ARDUINO_IDE_DIR 'plugins')" -ForegroundColor Green
} elseif (Test-Path $SOURCE_PLUGINS) {
    Write-Host "[FEHLER] Plugins konnten nicht kopiert werden!" -ForegroundColor Red
    $SUCCESS = $false
} else {
    Write-Host "[INFO] Keine Plugins zum Installieren vorhanden"
}
Write-Host ""

if ($PROJECT_COPIED) {
    Write-Host "[OK] Projekt: $TARGET_PROJECT" -ForegroundColor Green
    Write-Host "     Projekt-Dateien erfolgreich installiert"
} elseif (Test-Path $SOURCE_PROJECT) {
    Write-Host "[FEHLER] Projekt-Verzeichnis konnte nicht kopiert werden!" -ForegroundColor Red
    $SUCCESS = $false
} else {
    Write-Host "[INFO] Kein Projekt-Verzeichnis zum Installieren vorhanden"
}
Write-Host ""

if ($DESKTOP_COPIED) {
    Write-Host "[OK] Desktop-Dateien: $DESKTOP_DIR" -ForegroundColor Green
} elseif (Test-Path $SOURCE_DESKTOP) {
    Write-Host "[FEHLER] Desktop-Dateien konnten nicht kopiert werden!" -ForegroundColor Red
    $SUCCESS = $false
} else {
    Write-Host "[INFO] Keine Desktop-Dateien zum Kopieren vorhanden"
}
Write-Host ""

if (-not $SUCCESS) {
    Write-Host "=========================================" -ForegroundColor Red
    Write-Host "  Installation mit Fehlern beendet!" -ForegroundColor Red
    Write-Host "=========================================" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit 1
}

# === Arduino IDE starten ===
Write-Host "[6/6] Starte Arduino IDE..." -ForegroundColor Yellow
Write-Host ""

$ARDUINO_PATHS = @(
    "$env:LOCALAPPDATA\Programs\Arduino IDE\Arduino IDE.exe",
    "C:\Program Files\Arduino IDE\Arduino IDE.exe",
    "${env:ProgramFiles(x86)}\Arduino IDE\Arduino IDE.exe"
)

$ARDUINO_EXE = $null
foreach ($path in $ARDUINO_PATHS) {
    if (Test-Path $path) {
        $ARDUINO_EXE = $path
        break
    }
}

$SKETCH_PATH = Join-Path $ARDUINO_DIR "2025-WI-Schnuppertag\01_Programmieren\01_Programmieren.ino"

if ($ARDUINO_EXE) {
    if (Test-Path $SKETCH_PATH) {
        Write-Host "  [OK] Arduino IDE gefunden: $ARDUINO_EXE" -ForegroundColor Green
        Write-Host "  [OK] Oeffne Sketch: 01_Programmieren" -ForegroundColor Green
        Write-Host ""
        Write-Host "  Starte Arduino IDE..." -ForegroundColor Cyan
        
        # Erstelle temporaeres VBScript zum Starten (zuverlaessigste Methode)
        $tempVbs = Join-Path $env:TEMP "start_arduino.vbs"
        $vbsContent = @"
Set objShell = CreateObject("WScript.Shell")
objShell.Run """$ARDUINO_EXE"" ""$SKETCH_PATH""", 1, False
"@
        Set-Content -Path $tempVbs -Value $vbsContent -Force
        
        # Starte VBScript und beende sofort
        Start-Process -FilePath "wscript.exe" -ArgumentList "`"$tempVbs`"" -WindowStyle Hidden
        
    } else {
        Write-Host "  [WARNUNG] Sketch nicht gefunden: $SKETCH_PATH" -ForegroundColor Yellow
        Write-Host "  Starte Arduino IDE ohne Sketch..."
        
        $tempVbs = Join-Path $env:TEMP "start_arduino.vbs"
        $vbsContent = @"
Set objShell = CreateObject("WScript.Shell")
objShell.Run """$ARDUINO_EXE""", 1, False
"@
        Set-Content -Path $tempVbs -Value $vbsContent -Force
        Start-Process -FilePath "wscript.exe" -ArgumentList "`"$tempVbs`"" -WindowStyle Hidden
    }
    
    Write-Host ""
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "  Installation erfolgreich!" -ForegroundColor Green
    Write-Host "  Arduino IDE wird gestartet..." -ForegroundColor Green
    Write-Host "=========================================" -ForegroundColor Cyan
} else {
    Write-Host "  [WARNUNG] Arduino IDE nicht gefunden!" -ForegroundColor Yellow
    Write-Host "  Bitte installiere die Arduino IDE oder oeffne den Sketch manuell."
    Write-Host ""
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "  Installation abgeschlossen!" -ForegroundColor Green
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host ""
    Start-Sleep -Seconds 2
}

# Beende sofort
[Environment]::Exit(0)
