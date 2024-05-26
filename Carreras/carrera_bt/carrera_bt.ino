#include <SoftwareSerial.h>



//Bluetooth Serial
SoftwareSerial btSerial(10, 11); // RX, TX
//Motor A
#define AIN1 5
#define AIN2 6
//Motor B
#define BIN1 9
#define BIN2 3

String Buffer = "";
int left = 0;
int right = 0;

void motorL(int value) {
  if ( value >= 0 ) {
    analogWrite(BIN1, value);
    analogWrite(BIN2, 0);
  } else {
    value *= -1;
    analogWrite(BIN1, 0);
    analogWrite(BIN2, value);
  }
}

void motorR(int value) {
  if ( value >= 0 ) {
    analogWrite(AIN1, value);
    analogWrite(AIN2, 0);
  } else {
    value *= -1;
    analogWrite(AIN1, 0);
    analogWrite(AIN2, value);
  }
}

void motor(int left, int right) {
  motorL(left);
  motorR(right);
}


void setup() {
  // Pin setup
  Serial.begin(9600);
  Serial.println("ENTER AT Commands:");

  pinMode(BIN2  , OUTPUT);
  pinMode(BIN1  , OUTPUT);
  pinMode(AIN1  , OUTPUT);
  pinMode(AIN2  , OUTPUT);
  btSerial.begin(9600);
}

void loop() {
  if (btSerial.available()) {
    char character = btSerial.read(); 
    Serial.print(character);
    Buffer.concat(character); 
    if (character == '\n') {
      btSerial.print("Received: ");
      btSerial.println(Buffer);
      Serial.print("Received: ");
      Serial.println(Buffer);

      if (Buffer.length() > 2) {
        String wheel = Buffer.substring(0, 1);
        int speed = Buffer.substring(1, Buffer.length()-1).toInt();
        if (speed > -255 && speed < 255) {
          if (wheel == "L") {
            left = speed;
          }
          else if (wheel == "R") {
            right = speed;
          }
          motor(left, right);
        }
      }
      Buffer = "";
    }
  }
  if (Serial.available()) {
    char character = Serial.read(); 

    btSerial.write(character);
    Serial.println(character);
  }
}
