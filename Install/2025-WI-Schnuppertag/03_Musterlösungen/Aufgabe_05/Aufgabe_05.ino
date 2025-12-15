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
    // hier kommt der Setup-Code hin
    ring.begin();
    ring.show();
    ring.setBrightness(BRIGHTNESS);
}

// Loop-Funktion - wird ununterbrochen ausgeführt
void loop() {
    // hier kommt der Effekt-Code hin
    // SOS Morsecode: ... --- ...
    // kurz (blau) = 200ms, lang (rot) = 750ms
    
    int rot = ring.Color(255, 0, 0);
    int blau = ring.Color(0, 0, 255);

    // S: kurz-kurz-kurz (...)
    ring.fill(blau);
    ring.show();
    delay(200);
    ring.clear();
    ring.show();
    delay(200);
    
    ring.fill(blau);
    ring.show();
    delay(200);
    ring.clear();
    ring.show();
    delay(200);
    
    ring.fill(blau);
    ring.show();
    delay(200);
    ring.clear();
    ring.show();
    delay(200);
    
    delay(400); // Pause zwischen Buchstaben
    
    // O: lang-lang-lang (---)
    ring.fill(rot);
    ring.show();
    delay(750);
    ring.clear();
    ring.show();
    delay(200);
    
    ring.fill(rot);
    ring.show();
    delay(750);
    ring.clear();
    ring.show();
    delay(200);
    
    ring.fill(rot);
    ring.show();
    delay(750);
    ring.clear();
    ring.show();
    delay(200);
    
    delay(400); // Pause zwischen Buchstaben
    
    // S: kurz-kurz-kurz (...)
    ring.fill(blau);
    ring.show();
    delay(200);
    ring.clear();
    ring.show();
    delay(200);
    
    ring.fill(blau);
    ring.show();
    delay(200);
    ring.clear();
    ring.show();
    delay(200);
    
    ring.fill(blau);
    ring.show();
    delay(200);
    ring.clear();
    ring.show();
    delay(200);
    
    delay(1000); // Pause vor Wiederholung
}


/***********************************************************************************
 * hier kommt am Ende dein Effekt 1 hin - bis dahin einfach leer lassen
 ***********************************************************************************/
void deinEffekt1(int step) {

}
