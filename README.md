# WI-Schnuppertage 2025/2026 - WI-smartLight Projekt

Willkommen beim Schnupperprojekt der HTL Anichstraße - Abteilung Wirtschaftsingenieure / Betriebsinformatik! In diesem Projekt lernst du die Grundlagen der Programmierung mit einem ESP32-Mikrocontroller und einem LED-Ring mit 24 LEDs.

## 📋 Was brauchst du?

### Hardware
- **WI-smartLight Platine mit ESP32-Mikrocontroller und LED Ring** (mit USB-C-Kabel)

### Software
- **Arduino IDE** (Version 2.x empfohlen)
- **USB-Treiber** für ESP32 (normalerweise automatisch installiert)

---

## 🔧 Installation - Schritt für Schritt

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

## 🚀 Projekt öffnen und hochladen

### Methode 1: Mit dem Download-Skript (empfohlen)

1. Doppelklicke auf **`2025-wi-schnuppern-download.cmd`** im Projektordner.
2. Das Skript lädt das GitHub-Archiv (`main.zip`) in deinen **Downloads**-Ordner und entpackt es unter `2025-wi-schnuppern`.
3. Anschließend startet es automatisch die Installation: Bibliotheken, Plugins und das Projekt werden in deine Benutzerordner kopiert.
4. Wird die Arduino IDE gefunden, startet sie und öffnet den Sketch **01_Programmieren**.

Hinweise zum Skript:
- Verwendet `curl` (Fallback: PowerShell `Invoke-WebRequest`) für den Download.
- Entpackt mit `Expand-Archive` und entfernt ggf. alte Zielordner.
- Sucht und startet `Install/2025-WI-Schnuppertag-Install.ps1` (Fallback: `.cmd`).

### Methode 2: Manuell öffnen

1. Öffne die Arduino IDE.
2. Gehe zu **Datei** → **Öffnen**.
3. Navigiere zu **Dokumente** → **Arduino** → **2025-WI-Schnuppertag** → **01_Programmieren**.
4. Öffne **`01_Programmieren.ino`**.

Projektstruktur nach Installation:
- Bibliotheken: `Dokumente/Arduino/libraries` (z. B. Adafruit NeoPixel, ArduinoJson, PubSubClient)
- Projekt: `Dokumente/Arduino/2025-WI-Schnuppertag` (Unterordner `01_Programmieren`, `02_WI-smartLight`)
- Arduino IDE Plugins: `%USERPROFILE%/.arduinoIDE/plugins`
- Desktop-Verknüpfungen: werden nach `Desktop` kopiert

### Code hochladen

1. Stelle sicher, dass dein ESP32 angeschlossen ist
2. Klicke auf den **Upload-Button** (Pfeil nach rechts) oben links
3. Warte, bis der Code kompiliert und hochgeladen wird
4. In der Konsole sollte **"Hard resetting via RTS pin..."** erscheinen
5. Dein Programm läuft jetzt auf dem ESP32! 🎉

---

## 📝 Programmieren lernen

### Datei-Struktur

- **`01_Programmieren/01_Programmieren.ino`** – Hier programmierst du! Dein Hauptcode.
- **`01_Programmieren/helper.h`** – Hilfsfunktionen und Hardware-Setup (NICHT BEARBEITEN!).

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

## ❓ Häufige Probleme und Lösungen

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

## 📚 Weitere Ressourcen

- **Arduino Referenz:** https://www.arduino.cc/reference/de/
- **Adafruit NeoPixel Guide:** https://learn.adafruit.com/adafruit-neopixel-uberguide
- **ESP32 Dokumentation:** https://docs.espressif.com/projects/arduino-esp32/

---

## 👨‍🏫 Projekt-Info

**HTL Anichstraße, Innsbruck**  
Wirtschaftsingenieure - Betriebsinformatik  
WI-Schnuppertage 2025/2026  
© 2025 Andreas Eckhart

---

## 🎯 Viel Erfolg!

Experimentiere mit verschiedenen Farben, Mustern und Animationen! Programmieren lernt man am besten durch ausprobieren. 🚀
