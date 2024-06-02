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
int direction = 0; //1 right, 2 left, 3 forward, 4 backward

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
          int directionX = buffer.substring(buffer.indexOf('X')+1, buffer.indexOf('Y')).toInt();
          int directionY = buffer.substring(buffer.indexOf('Y')+1, buffer.length()-1).toInt();

          if (
            directionX > -255 && directionX < 255 
            && directionY > -255 && directionY < 255
          ) {
            chooseDirection(directionX, directionY);
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

void chooseDirection(int directionX, int directionY) {
  int speedL = speed + leftOffset;
  int speedR = speed + rightOffset;
  if (
    directionX > -100 && directionX < 100 
    && directionY > -100 && directionY < 100
  ) {  
    //Close to center, stop
    motor(0, 0);
  }
  else if (abs(directionX) > abs(directionY)) {
    if (directionX >= 0) {
      //Right
      if (direction != 1) {
        motor(0, 0);
        delay(200);
        direction = 1;
      }
      motor(speedL, -speedR);
    }
    else {
      //Left
      if (direction != 2) {
        motor(0, 0);
        delay(200);
        direction = 2;
      }
      motor(-speedL, speedR);
    }
  }
  else {
    if (directionY >= 0) {
      //Forward
      if (direction != 3) {
        motor(0, 0);
        delay(200);
        direction = 3;
      }
      motor(speedL, speedR);
    }
    else {
      //Backward
      if (direction != 4) {
        motor(0, 0);
        delay(200);
        direction = 4;
      }
      motor(-speedL, -speedR);
    }
  }
}
