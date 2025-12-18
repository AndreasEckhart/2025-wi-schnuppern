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

void setup() {
    ring.begin();
    ring.show();
    ring.setBrightness(BRIGHTNESS);
}

void loop() {
    if (updateErforderlich()) {
        deinEffekt1(step);
        ring.show();
    }
}

/***********************************************************************************
 * Spektakulärer Effekt: Polarlicht-Wellen
 * - Zwei sanfte Farb-Wellen wandern gegeneinander
 * - Helligkeit "atmet" und mischt sich zu neuen Farben
 ***********************************************************************************/
void deinEffekt1(int step) {
    effectSpeed = 22; // geschmeidig, aber flott genug

    const int count = ring.numPixels();

    // Atemkurve (0.3 .. 1.0)
    float phase = (step % 200) / 200.0f;
    float breath = 0.3f + 0.7f * (0.5f * (1.0f - cosf(phase * 2.0f * PI)));

    ring.clear();

    for (int i = 0; i < count; i++) {
        // Welle A läuft vorwärts, Welle B rückwärts
        float waveA = sinf((i + step * 0.35f) * 0.35f);
        float waveB = sinf((count - i + step * 0.28f) * 0.32f);

        // Mappe Wellen (-1..1) auf 0..1
        float a = 0.5f * (waveA + 1.0f);
        float b = 0.5f * (waveB + 1.0f);

        // Mische Hue anhand der beiden Wellen (blau/türkis ↔ violett)
        // Hue-Bereich: 120°..280° (in 0..65535 Skala)
        uint16_t hue = (uint16_t)(120 * 182 + (160 * 182) * (a * 0.6f + b * 0.4f));
        uint32_t color = ring.gamma32(ring.ColorHSV(hue));

        // Komponenten herausziehen
        uint8_t r = (color >> 16) & 0xFF;
        uint8_t g = (color >> 8) & 0xFF;
        uint8_t bC = color & 0xFF;

        // Intensität: Mischung aus beiden Wellen + Atem
        float intensity = breath * (0.4f + 0.6f * ((a + b) * 0.5f));
        r = (uint8_t)(r * intensity);
        g = (uint8_t)(g * intensity);
        bC = (uint8_t)(bC * intensity);

        ring.setPixelColor(i, r, g, bC);
    }
}
