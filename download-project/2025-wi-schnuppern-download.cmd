@echo off
:: ***************************************************************
:: WICHTIG: Setzt die Codepage auf UTF-8 für korrekte Umlaute.
:: Das Skript MUSS selbst als UTF-8 gespeichert werden.
chcp 65001 > nul
:: ***************************************************************

SET "REPO_URL=https://github.com/AndreasEckhart/2025-wi-schnuppern/archive/refs/heads/main.zip"
SET "ZIP_FILE=repo_source.zip"
SET "TARGET_DIR=2025-wi-schnuppern"

ECHO --- Vorbereitung und Bereinigung des Downloads ---

:: 1. PRÜFEN und LÖSCHEN der alten ZIP-Datei
IF EXIST "%ZIP_FILE%" (
    ECHO Alte ZIP-Datei (%ZIP_FILE%) gefunden. Wird gelöscht...
    DEL "%ZIP_FILE%"
)

:: 2. PRÜFEN und LÖSCHEN des Zielordners
IF EXIST "%TARGET_DIR%" (
    ECHO Alter Zielordner (%TARGET_DIR%) gefunden. Wird gelöscht...
    RD /S /Q "%TARGET_DIR%"
)

ECHO --- Download starten ---

ECHO Starte Download des Source Codes für die Übung...

:: Verwende PowerShell, um das ZIP herunterzuladen
PowerShell -Command "Invoke-WebRequest -Uri '%REPO_URL%' -OutFile '%ZIP_FILE%'"

IF EXIST "%ZIP_FILE%" (
    ECHO Download erfolgreich. Entpacke Dateien...

    :: Verwende PowerShell, um das ZIP zu entpacken
    PowerShell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%TARGET_DIR%' -Force"

    IF EXIST "%TARGET_DIR%" (
        ECHO Source Code erfolgreich in den Ordner "%TARGET_DIR%" entpackt.
        ECHO Bereinige temporäre ZIP-Datei...
        DEL "%ZIP_FILE%"
        ECHO --- Erfolgreich abgeschlossen! ---
        ECHO Source Code ist in "%TARGET_DIR%" verfügbar.
    ) ELSE (
        ECHO FEHLER: Das Entpacken ist fehlgeschlagen.
    )
) ELSE (
    ECHO FEHLER: Der Download ist fehlgeschlagen. Überprüfen Sie die URL.
)

PAUSE