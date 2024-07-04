#include <Otto.h>
#include <SoftwareSerial.h>

Otto Otto;

// Definir los pines para cada servomotor
const int leftLegPin = 2;
const int rightLegPin = 3;
const int leftFootPin = 4;
const int rightFootPin = 5;
const int buzzerPin = 13;

#define Buzzer 13

int speakerPin = 13;
int tempo = 150;

// Variables para la posición inicial de cada servomotor
int leftLegPos = 80;
int rightLegPos = 80;
int rightFootPos = 120;
int leftFootPos = 190;

void setup() {
    Serial.begin(9600);

    Otto.init(leftLegPin, rightLegPin, leftFootPin, rightFootPin, true, Buzzer);
    //Otto.setTrims(80, 80, 120, 190);
    int posInicial[4] = {leftLegPos, rightLegPos, rightFootPos, leftFootPos };
    pinMode(speakerPin, OUTPUT);
    Otto.home();
}


//Sonidos:


void talkRobot() {

    int tones[] = { 1000, 1200, 800, 1500 };
    int durations[] = { 100, 100, 100, 100 };

    for (int i = 0; i < sizeof(tones) / sizeof(tones[0]); i++) {
        playTone(tones[i], durations[i]);
        delay(durations[i] * 1.2);
    }
}

void talkRobot2() {
    int tones[] = { 2000, 1800, 1600, 1400 };
    int durations[] = { 50, 50, 50, 50 };

    for (int i = 0; i < sizeof(tones) / sizeof(tones[0]); i++) {
        playTone(tones[i], durations[i]);

        delay(durations[i] * 1.2);
    }
}
void happySound() {
    int tones[] = { 1500, 1700, 1900 };
    int durations[] = { 100, 100, 100 };

    for (int i = 0; i < sizeof(tones) / sizeof(tones[0]); i++) {
        playTone(tones[i], durations[i]);
        delay(durations[i] * 1.2);
    }
}

void sadSound() {
    int tones[] = { 1000, 800, 600 };
    int durations[] = { 150, 150, 150 };

    for (int i = 0; i < sizeof(tones) / sizeof(tones[0]); i++) {
        playTone(tones[i], durations[i]);
        delay(durations[i] * 1.2);
    }
}

void surprisedSound() {
    int tones[] = { 1000, 1800, 1000 };
    int durations[] = { 50, 100, 50 };

    for (int i = 0; i < sizeof(tones) / sizeof(tones[0]); i++) {
        playTone(tones[i], durations[i]);
        delay(durations[i] * 1.2);
    }
}


void playTone(int tone, int duration) {
    for (long i = 0; i < duration * 1000L; i += tone * 2) {
        digitalWrite(speakerPin, HIGH);
        delayMicroseconds(tone);
        digitalWrite(speakerPin, LOW);
        delayMicroseconds(tone);
    }
}


//Fin sonidos
void baile1() {
    Otto.home();
    for (int i = 0; i < 3; i++) {
        talkRobot();
        Otto.bend(1, 500, 1);
        Otto.bend(1, 500, -1);
        Otto.shakeLeg(1, 1000, 1);
        Otto.shakeLeg(1, 1000, -1);
        talkRobot2();
    }
}

void baile2() {
    Otto.home();
    for (int i = 0; i < 3; i++) {
        happySound();
        Otto.turn(1, 1000, 1);
        Otto.turn(1, 1000, -1);
        Otto.walk(1, 1000, 1);
        Otto.walk(1, 1000, -1);
        surprisedSound();
    }
}

void baile3() {
    Otto.home();
    for (int i = 0; i < 3; i++) {
        sadSound();
        Otto.moonwalker(1, 1000, 1);
        Otto.moonwalker(1, 1000, -1);
        Otto.crusaito(1, 1000, 1);
        Otto.crusaito(1, 1000, -1);
        happySound();
    }
}

void baile4() {
    Otto.home();
    for (int i = 0; i < 3; i++) {
        talkRobot2();
        Otto.crusaito(1, 1000, 1);
        Otto.crusaito(1, 1000, -1);
        Otto.shakeLeg(1, 1000, 1);
        Otto.shakeLeg(1, 1000, -1);
        happySound();
    }
}

void baile5() {
    Otto.home();
    for (int i = 0; i < 3; i++) {
        happySound();
        Otto.moonwalker(1, 1000, 1);
        Otto.moonwalker(1, 1000, -1);
        Otto.bend(1, 500, 1);
        Otto.bend(1, 500, -1);
        talkRobot();
    }
}

void loop() {
    if (Serial.available() > 0) {
        String command = Serial.readString();
        command.trim();

        if (command == "D1") {
            Serial.print("Baile 1 seleccionado\n");
            baile1();
        } else if (command == "D2") {
            Serial.print("Baile 2 seleccionado\n");
            baile2();
        } else if (command == "D3") {
            Serial.print("Baile 3 seleccionado\n");
            baile3();
        } else if (command == "D4") {
            Serial.print("Baile 4 seleccionado\n");
            baile4();
        } else if (command == "D5") {
            Serial.print("Baile 5 seleccionado\n");
            baile5();
        } else if (command == "W") {
            Serial.print("Caminando...\n");
            Otto.walk(10, 1000, FORWARD);
        } else if (command == "STOP") {
            Otto.home();
        }
    } else {

        Otto.home();
    }
}


