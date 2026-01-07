# WI-Schnuppertage 2025/2026 - WI-smartLight Projekt

<img align="left" width="250" height="250" alt="WI_smartLight" src="https://github.com/user-attachments/assets/022d695d-0bb5-44d9-b165-b75d83b62885" style="margin-right: 20px;" />

Willkommen beim Schnupperprojekt der HTL Anichstraße - Abteilung Wirtschaftsingenieure / Betriebsinformatik! In diesem Projekt lernst du die Grundlagen der Programmierung mit einem ESP32-Mikrocontroller und einem LED-Ring mit 24 LEDs.

<br clear="left"/>

---

## 📚 Inhaltsverzeichnis

1. [📋 Was brauchst du?](#1--was-brauchst-du)
2. [🔧 Installation - Schritt für Schritt](#2--installation---schritt-für-schritt)
   - [Schritt 1: Arduino IDE installieren](#schritt-1-arduino-ide-installieren)
   - [Schritt 2: ESP32 Board Support installieren](#schritt-2-esp32-board-support-installieren)
   - [Schritt 3: Board auswählen](#schritt-3-board-auswählen)
   - [Schritt 4: Adafruit NeoPixel Bibliothek installieren](#schritt-4-adafruit-neopixel-bibliothek-installieren)
3. [🚀 Projekt herunterladen und installieren (Windows, Linux & macOS)](#3--projekt-herunterladen-und-installieren)
   - [Schritt 1: Download-Skript von GitHub herunterladen](#schritt-1-download-skript-von-github-herunterladen)
   - [Schritt 2: Download-Skript ausführen](#schritt-2-download-skript-ausführen)
   - [Schritt 3: Nach der Installation](#schritt-3-nach-der-installation)
4. [🚀 Projekt öffnen und hochladen](#4--projekt-öffnen-und-hochladen)
5. [📝 Programmieren lernen](#5--programmieren-lernen)
   - [Die wichtigsten Funktionen](#die-wichtigsten-funktionen)
   - [Beispiel-Code: Lauflicht](#beispiel-code-lauflicht)
6. [❓ Häufige Probleme und Lösungen](#6--häufige-probleme-und-lösungen)
7. [📚 Weitere Ressourcen](#7--weitere-ressourcen)
8. [👨‍🏫 Projekt-Info](#8--projekt-info)

---

## 1. 📋 Was brauchst du?

### Hardware
- **WI-smartLight Platine mit ESP32-Mikrocontroller und LED Ring** (mit USB-C-Kabel)

### Software
- **Arduino IDE** (Version 2.x empfohlen)
- **USB-Treiber** für ESP32 (normalerweise automatisch installiert)
- **WI-smartLight - Ablauf**: https://www.canva.com/design/DAG4TvWC8oM/0WDeYfE1SxNzTrlonSjVjg/view?utm_content=DAG4TvWC8oM&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h19186fe88a

---

## 2. 🔧 Installation - Schritt für Schritt

### Schritt 1: Arduino IDE installieren

1. Öffne deinen Browser und gehe zu: https://www.arduino.cc/en/software
2. Lade die **Arduino IDE 2.x** für Windows herunter
3. Führe die heruntergeladene Installationsdatei aus
4. Folge dem Installationsassistenten (Standard-Einstellungen sind okay)
5. Starte die Arduino IDE nach der Installation

### Schritt 2: ESP32 Board Support installieren

1. Öffne die Arduino IDE
2. Gehe zu **Datei** → **Einstellungen**
3. Füge im Feld **"Zusätzliche Boardverwalter-URLs"** folgende URL ein:
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
4. Klicke auf **OK**
5. Gehe zu **Tools** → **Board** → **Boardverwalter...**
6. Suche nach **"esp32"**
7. Installiere **"esp32 by Espressif Systems"** (neueste Version)
8. Warte, bis die Installation abgeschlossen ist

### Schritt 3: Board auswählen

1. Schließe deinen ESP32 per USB-Kabel an den Computer an
2. Gehe zu **Tools** → **Board** → **lolin** → **LOLIN C3 Mini**
3. Gehe zu **Tools** → **Port** und wähle den COM-Port aus (z.B. COM3, COM4...)
   - *Hinweis: Wenn kein Port angezeigt wird, müssen eventuell USB-Treiber installiert werden*

### Schritt 4: Adafruit NeoPixel Bibliothek installieren

1. Gehe zu **Tools** → **Bibliotheken verwalten...**
2. Suche nach **"Adafruit NeoPixel"**
3. Installiere **"Adafruit NeoPixel"** von Adafruit
4. Warte, bis die Installation abgeschlossen ist

---

## 3. 🚀 Projekt herunterladen und installieren

> 💻 **Hinweis für Linux und macOS Nutzer:** Die folgenden Schritte sind primär für Windows gedacht. Linux und macOS Nutzer finden eine Anleitung [hier ↓](#-installation-für-linux-und-macos).

### Schritt 1: Download-Skript von GitHub herunterladen

**Empfohlen - so kommst du an das Download-Skript:**

> **💡 Wichtig:** Wenn du das Download-Skript ausführst, werden **alle benötigten Bibliotheken und Dateien automatisch installiert**! Du musst dann **Schritt 4 (Adafruit NeoPixel Bibliothek)** aus der obigen Anleitung **nicht mehr manuell durchführen**, da dies bereits vom Skript erledigt wird. Die Arduino IDE und ESP32 Board Support (Schritte 1-3) sollten jedoch vorher installiert sein.

1. Öffne deinen Browser (Chrome, Firefox, Edge...)
2. Gehe zu: **https://github.com/AndreasEckhart/2025-wi-schnuppern**
3. Klicke oben rechts auf den grünen Button **"<> Code"**
4. Im aufklappenden Menü: Klicke auf **"Download ZIP"**
5. Speichere die ZIP-Datei (sie heißt `2025-wi-schnuppern-main.zip`)
6. Öffne deinen **Downloads**-Ordner
7. **Rechtsklick** auf die ZIP-Datei → **"Alle extrahieren..."**
8. Klicke auf **"Extrahieren"** (Standard-Einstellungen sind okay)
9. Es wird ein neuer Ordner **`2025-wi-schnuppern-main`** erstellt

**Alternative - nur die Download-Datei herunterladen:**

1. Gehe zu: **https://github.com/AndreasEckhart/2025-wi-schnuppern**
2. Klicke in der Dateiliste auf **`2025-wi-schnuppern-download.cmd`**
3. Klicke oben rechts auf das **Download-Symbol** (Pfeil nach unten) oder **"Raw"**
4. Wenn sich die Datei im Browser öffnet:
   - **Rechtsklick** → **"Seite speichern unter..."** oder **Strg+S**
   - Speichere sie als `2025-wi-schnuppern-download.cmd` (achte auf die Endung `.cmd`)
5. Die Datei landet in deinem **Downloads**-Ordner

### Schritt 2: Download-Skript ausführen

1. Öffne deinen **Downloads**-Ordner (Tastenkombination: **Windows-Taste + E**, dann links auf "Downloads")
2. Falls du die ZIP-Datei heruntergeladen hast: Öffne den Ordner **`2025-wi-schnuppern-main`**
3. Suche die Datei **`2025-wi-schnuppern-download.cmd`**
4. **Doppelklick** auf die Datei

**Was passiert jetzt automatisch?**

5. Ein schwarzes Fenster (Kommandozeile) öffnet sich
6. Das Skript lädt das komplette GitHub-Projekt herunter (`main.zip`)
7. Die ZIP-Datei wird automatisch in deinen **Downloads**-Ordner entpackt
8. Die Installation startet automatisch:
   - Arduino-Bibliotheken werden nach `Dokumente/Arduino/libraries` kopiert
   - Das Projekt wird nach `Dokumente/Arduino/2025-WI-Schnuppertag` kopiert
   - Arduino IDE Plugins werden installiert
   - Desktop-Verknüpfungen werden erstellt
9. Die Arduino IDE startet automatisch und öffnet den Sketch **01_Programmieren**

**Wichtig:** Wenn ein Sicherheitshinweis erscheint ("Windows hat diesen PC geschützt"), klicke auf **"Weitere Informationen"** und dann **"Trotzdem ausführen"**.

### Schritt 3: Nach der Installation

Nach erfolgreicher Installation findest du:
- **Auf dem Desktop:** Ordner `WI-Schnuppern-2025` mit Verknüpfungen und Anleitungen
- **In Dokumenten:** `Arduino/2025-WI-Schnuppertag` mit deinen Projekten
- **Arduino IDE:** sollte automatisch gestartet sein mit dem Sketch `01_Programmieren`

---

### 💻 Installation für Linux und macOS

Das Download-Skript ist primär für Windows gedacht. Für Linux und macOS-Nutzer:

#### **Linux (Ubuntu/Debian basiert):**

1. Öffne ein Terminal
2. Clone das Repository:
   ```bash
   git clone https://github.com/AndreasEckhart/2025-wi-schnuppern.git
   cd 2025-wi-schnuppern
   ```
3. Oder lade die ZIP-Datei herunter und entpacke sie:
   ```bash
   cd ~/Downloads
   unzip 2025-wi-schnuppern-main.zip
   cd 2025-wi-schnuppern-main
   ```
4. Kopiere die Bibliotheken und Plugins manuell:
   ```bash
   cp -r Install/libraries/* ~/Arduino/libraries/
   cp -r Install/2025-WI-Schnuppertag ~/Documents/Arduino/
   mkdir -p ~/.arduinoIDE/plugins
   cp -r Install/plugins ~/.arduinoIDE/
   ```

#### **macOS:**

1. Öffne Terminal (Finder → Programme → Dienstprogramme → Terminal)
2. Clone das Repository oder lade die ZIP herunter (wie oben unter Linux)
3. Kopiere die Dateien manuell:
   ```bash
   cp -r Install/libraries/* ~/Documents/Arduino/libraries/
   cp -r Install/2025-WI-Schnuppertag ~/Documents/Arduino/
   mkdir -p ~/Library/Arduino15/plugins
   cp -r Install/plugins ~/Library/Arduino15/
   ```

**Hinweis:** Stelle sicher, dass folgende Ordner existieren:
- `~/Documents/Arduino/` (unter macOS: `~/Documents/Arduino/`)
- `~/Arduino/libraries/` (Linux)

Danach öffne die Arduino IDE manuell und öffne das Projekt über **Datei** → **Öffnen** → navigiere zu `2025-WI-Schnuppertag` → `01_Programmieren`.

---

## 4. 🚀 Projekt öffnen und hochladen

### Methode 1: Automatisch (nach Installation)

Wenn du das Download-Skript ausgeführt hast, ist die Arduino IDE bereits geöffnet mit dem richtigen Sketch. Überspringe zu **"Code hochladen"** weiter unten.

### Methode 2: Manuell öffnen

1. Öffne die Arduino IDE.
2. Gehe zu **Datei** → **Öffnen**.
3. Navigiere zu **Dokumente** → **Arduino** → **2025-WI-Schnuppertag** → **01_Programmieren**.
4. Öffne **`01_Programmieren.ino`**.

Projektstruktur nach Installation:
- Bibliotheken: `Dokumente/Arduino/libraries` (z. B. Adafruit NeoPixel, ArduinoJson, PubSubClient)
- Projekt: `Dokumente/Arduino/2025-WI-Schnuppertag` mit zwei Unterordnern:
  - **`01_Programmieren`** – Programmierübungen zum Kennenlernen des LED-Rings
  - **`02_WI-smartLight`** – Code für das intelligente IoT-Gerät WI-smartLight
- Arduino IDE Plugins: `%USERPROFILE%/.arduinoIDE/plugins`
- Desktop-Verknüpfungen: werden nach `Desktop` kopiert

### Code hochladen

1. Stelle sicher, dass dein ESP32 angeschlossen ist
2. Klicke auf den **Upload-Button** (Pfeil nach rechts) oben links
3. Warte, bis der Code kompiliert und hochgeladen wird
4. In der Konsole sollte **"Hard resetting via RTS pin..."** erscheinen
5. Dein Programm läuft jetzt auf dem ESP32! 🎉

---

## 5. 📝 Programmieren lernen

### Datei-Struktur

Das Projekt, das unter `Dokumente/Arduino/2025-WI-Schnuppertag` zu finden ist, enthält drei Hauptordner:

**📁 01_Programmieren** – Programmierübungen für Anfänger:
- **`01_Programmieren.ino`** – Hier programmierst du! Dein Hauptcode für erste Übungen mit dem LED-Ring.
- **`helper.h`** – Hilfsfunktionen und Hardware-Setup (NICHT BEARBEITEN!).

**📁 02_WI-smartLight** – Intelligentes IoT-Gerät:
- **`WI-smartLight.ino`** – Vollständiger Code für das WI-smartLight IoT-Gerät mit Web-Interface.
- **`data/`** – Web-Interface Dateien (HTML, CSS, JavaScript) für die Steuerung über WLAN.

**📁 03_Musterlösungen** – Beispiel-Lösungen und Inspiration:
- Verschiedene Musterlösungen für Programmieraufgaben mit dem LED-Ring.
- Nutze diese als Inspiration, aber probiere zuerst selbst!

---

> 💡 **Hinweis zu Musterlösungen:** Im Projekt findest du Beispiele und Musterlösungen für verschiedene Programmieraufgaben. Diese dienen als Orientierung und Inspiration für deine eigenen Experimente. Probiere zuerst selbst aus, bevor du dir die Lösungen ansiehst – so lernst du am meisten!

---

### Die wichtigsten Funktionen

#### LED-Ring steuern

```cpp
// Einzelne LED einschalten (LED-Nummer 0-23, Rot, Grün, Blau)
ring.setPixelColor(0, 255, 0, 0);  // LED 0 wird rot

// Alle LEDs aktualisieren (immer nach setPixelColor aufrufen!)
ring.show();

// Alle LEDs ausschalten
ring.clear();
ring.show();

// Helligkeit ändern (0-255)
ring.setBrightness(50);
```

#### Farben definieren

```cpp
// RGB-Werte: Rot, Grün, Blau (jeweils 0-255)
ring.setPixelColor(0, 255, 0, 0);      // Rot
ring.setPixelColor(1, 0, 255, 0);      // Grün
ring.setPixelColor(2, 0, 0, 255);      // Blau
ring.setPixelColor(3, 255, 255, 0);    // Gelb
ring.setPixelColor(4, 255, 0, 255);    // Magenta
ring.setPixelColor(5, 0, 255, 255);    // Cyan
ring.setPixelColor(6, 255, 255, 255);  // Weiß
```

#### Timing und Animation

```cpp
// Verzögerung (in Millisekunden)
delay(1000);  // 1 Sekunde warten

// Animationsgeschwindigkeit ändern
effectSpeed = 50;  // Höhere Zahl = langsamer

// Auf nächsten Update warten
if (updateErforderlich()) {
    // Code für Animation hier
}

// Schrittzähler für Animationen
step  // Zählt automatisch hoch bei jedem Update
```

### Beispiel-Code: Lauflicht

```cpp
void setup() {
    ring.begin();           // LED-Ring initialisieren
    ring.setBrightness(20); // Helligkeit setzen
    ring.clear();           // Alle LEDs aus
    ring.show();            // Änderungen anzeigen
}

void loop() {
    if (updateErforderlich()) {
        ring.clear();
        
        // LED Nummer ist rest von step geteilt durch 24
        int aktuelleLED = step % 24;
        ring.setPixelColor(aktuelleLED, 0, 255, 0);  // Grün
        
        ring.show();
    }
}
```

---

## 6. ❓ Häufige Probleme und Lösungen

### Problem: "Port not found" oder kein COM-Port sichtbar

**Lösung:**
1. Überprüfe das USB-Kabel (manche Kabel können nur laden, nicht übertragen)
2. Installiere den USB-Treiber: https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers
3. Verwende einen anderen USB-Port
4. Starte den Computer neu

### Problem: "Compilation error" oder Fehler beim Kompilieren

**Lösung:**
1. Überprüfe, ob alle Bibliotheken installiert sind (Adafruit NeoPixel)
2. Stelle sicher, dass das richtige Board ausgewählt ist (LOLIN C3 Mini)
3. Überprüfe deinen Code auf Tippfehler (Semikolons, Klammern...)

### Problem: LEDs leuchten nicht

**Lösung:**
1. Überprüfe die Hardware-Verkabelung
2. Stelle sicher, dass `ring.show()` aufgerufen wird
3. Erhöhe die Helligkeit: `ring.setBrightness(50)`
4. Teste mit einem einfachen Beispiel:
   ```cpp
   void loop() {
       ring.setPixelColor(0, 255, 0, 0);
       ring.show();
   }
   ```

### Problem: Upload schlägt fehl "Failed to connect"

**Lösung:**
1. Halte den **BOOT-Button** auf dem ESP32 gedrückt
2. Klicke auf Upload
3. Lasse den Button los, wenn "Connecting..." erscheint

---

## 7. 📚 Weitere Ressourcen

- **Arduino Referenz:** https://www.arduino.cc/reference/de/
- **Adafruit NeoPixel Guide:** https://learn.adafruit.com/adafruit-neopixel-uberguide
- **ESP32 Dokumentation:** https://docs.espressif.com/projects/arduino-esp32/

---

## 8. 👨‍🏫 Projekt-Info

**HTL Anichstraße, Innsbruck**  
Wirtschaftsingenieure - Betriebsinformatik  
WI-Schnuppertage 2025/2026  
© 2025 Andreas Eckhart

---

## 🎯 Viel Erfolg!

Experimentiere mit verschiedenen Farben, Mustern und Animationen! Programmieren lernt man am besten durch ausprobieren. 🚀
