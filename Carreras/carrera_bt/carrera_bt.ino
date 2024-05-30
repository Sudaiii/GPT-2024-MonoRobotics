#include <SoftwareSerial.h>



//Bluetooth Serial
SoftwareSerial btSerial(10, 11); // RX, TX
//Motor A
#define AIN1 6
#define AIN2 5
//Motor B
#define BIN1 3
#define BIN2 9

String buffer = "";
float leftOffset = 0;
float rightOffset = 20;
int speed = 0;

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
  while (btSerial.available()) {
    char character = btSerial.read(); 
    buffer.concat(character); 
    if (character == '\n') {
      //Parse message received
      btSerial.print("Received: ");
      btSerial.println(buffer);

      if (buffer.length() > 1) {
        //Change speed
        String initial = buffer.substring(0, 1);
        if (initial == "S") {
          speed = buffer.substring(1, buffer.length()-1).toInt();
        }
        else {
          //Change direction
          int speedX = buffer.substring(buffer.indexOf('X')+1, buffer.indexOf('Y')).toInt();
          int speedY = buffer.substring(buffer.indexOf('Y')+1, buffer.length()-1).toInt();

          if (
            speedX > -255 && speedX < 255 
            && speedY > -255 && speedY < 255
          ) {
            chooseDirection(speedX, speedY);
          }
        }

      }
      buffer = "";
    }
  }
  while (Serial.available()) {
    char character = Serial.read(); 

    btSerial.write(character);
    Serial.println(character);
  }
}

void chooseDirection(int speedX, int speedY) {
  int speedL = speed + leftOffset;
  int speedR = speed + rightOffset;
  if (
    speedX > -100 && speedX < 100 
    && speedY > -100 && speedY < 100
  ) {  
    //Close to center, stop
    motor(0, 0);
  }
  else if (abs(speedX) > abs(speedY)) {
    if (speedX >= 0) {
      //Right
      motor(speedL, -speedR);
    }
    else {
      //Left
      motor(-speedL, speedR);
    }
  }
  else {
    if (speedY >= 0) {
      //Forward
      motor(speedL, speedR);
    }
    else {
      //Backward
      motor(-speedL, -speedR);
    }
  }
}
