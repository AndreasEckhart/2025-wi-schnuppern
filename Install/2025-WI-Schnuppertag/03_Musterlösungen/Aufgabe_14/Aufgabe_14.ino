/***********************************************************************************
 * Teil 1: Grundlagen
 * WI-Schnuppertage 2025 / 2026
 ***********************************************************************************
 * Einführung in die Programmierung mittels ESP32 und LED-Ring
 * HTL-Anichstrasse, Innsbruck
 * Wirtschaftsingenieure - Betriebsinformatik / (c)2025 Andreas Eckhart
 ***********************************************************************************/

#include "helper.h"   // Alle Hilfsfunktionen und Hardware-Definitionen

/***********************************************************************************
 * ✅ AB HIER KANNST DU BEARBEITEN! ✅
 ***********************************************************************************/

// Setup-Funktion - wird einmal beim Start ausgeführt
void setup() {
    ring.begin();
    ring.show();
    ring.setBrightness(BRIGHTNESS);
}

// Loop-Funktion - wird ununterbrochen ausgeführt
void loop() {
    if (updateErforderlich()) {
        deinEffekt14(step); // deinen neuen Farbeffekt aufrufen
        ring.show();        // Änderungen anzeigen
    }
}

/***********************************************************************************
 * Cooler Farbeffekt: Doppel-Komet mit Ausklang
 * Zwei Kometen laufen gegeneinander, haben farbige Schweife und atmen in der Helligkeit.
 ***********************************************************************************/
void deinEffekt14(int step) {
    effectSpeed = 25; // Update-Geschwindigkeit des Effekts

    const int count = ring.numPixels();
    const int tail = 8; // Schweiflänge

    // Position der beiden Kometen (laufen gegenläufig)
    int posA = step % count;
    int posB = (count - (step % count)) % count;

    // Sanftes "Atmen" der Helligkeit (0.4 .. 1.0)
    float phase = (step % 120) / 120.0f;
    float breath = 0.4f + 0.6f * (0.5f * (1.0f - cosf(phase * 2.0f * PI)));

    // Basisfarben
    uint8_t aR = 0, aG = 200, aB = 255;   // Cyan/Blau
    uint8_t bR = 255, bG = 90, bB = 0;    // Orange

    ring.clear();

    // Hilfsfunktion zum Skalieren einer Farbe
    auto scaled = [&](uint8_t r, uint8_t g, uint8_t b, float f) {
        return ring.Color((uint8_t)(r * f), (uint8_t)(g * f), (uint8_t)(b * f));
    };

    // Schweif für Komet A
    for (int i = 0; i < tail; i++) {
        float fade = breath * (1.0f - (float)i / tail);
        int idx = (posA - i + count) % count;
        ring.setPixelColor(idx, scaled(aR, aG, aB, fade));
    }

    // Schweif für Komet B
    for (int i = 0; i < tail; i++) {
        float fade = breath * (1.0f - (float)i / tail);
        int idx = (posB + i) % count;
        ring.setPixelColor(idx, scaled(bR, bG, bB, fade));
    }
}
