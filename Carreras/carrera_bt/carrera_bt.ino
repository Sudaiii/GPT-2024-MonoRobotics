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
int leftOffset = 0;
int rightOffset = 20;
int speed = 0;
int speedL = 0;
int speedR = 0;
int speedCategory = 0;
int valueX = 0;
int valueY = 0;
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
  Serial.println("ENTER AT Commands AA:");

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
      Serial.println(buffer);

      if (buffer.length() > 1) {
        //Change speed
        String initial = buffer.substring(0, 1);
        Serial.println(buffer.length());
        if (initial == "S" && buffer.length() == 3) {
          speedCategory = buffer.substring(1, buffer.length()-1).toInt();
          setBaseSpeed();
          chooseDirection();
        }
        else {
          //Change direction
          valueX = buffer.substring(buffer.indexOf('X')+1, buffer.indexOf('Y')).toInt();
          valueY = buffer.substring(buffer.indexOf('Y')+1, buffer.length()-1).toInt();

          if (
            valueX > -255 && valueX < 255 
            && valueY > -255 && valueY < 255
          ) {
            chooseDirection();
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

void setBaseSpeed() {
  if (speedCategory == 3) {
    speed = 180;
  }
  
  else if (speedCategory == 2) {
    speed = 160;
  }
  
  else if (speedCategory == 1) {
    speed = 120;
  }
  else {
    speed = 0;
  }
}

void chooseDirection() {
  int targetL = speed + leftOffset;
  int targetR = speed + rightOffset;
  if (
    valueX > -100 && valueX < 100 
    && valueY > -100 && valueY < 100
  ) {  
    //Close to center, stop
    changeSpeed(0, 0);
  }
  else if (abs(valueX) > abs(valueY)) {
    if (valueX >= 0) {
      //Right
      changeSpeed(-targetL, targetR);
    }
    else {
      //Left
      changeSpeed(targetL, -targetR);
    }
  }
  else {
    if (valueY >= 0) {
      //Forward
      changeSpeed(-targetL, -targetR);
    }
    else {
      //Backward
      changeSpeed(targetL, targetR);
    }
  }
}

void changeSpeed(int targetL, int targetR){
  while (speedL != targetL || speedR != targetR) {
    if (speedL > targetL) {
      speedL = speedL - 20;
    }
    else if (speedL < targetL) {
      speedL = speedL + 20;
    }

    if (speedR > targetR) {
      speedR = speedR - 20;
    }
    else if (speedR < targetR) {
      speedR = speedR + 20;
    }

    motor(speedL, speedR);
    delay(5);
  }
}