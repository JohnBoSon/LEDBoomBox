#define REDPIN 5
#define GREENPIN 6
#define BLUEPIN 3
#define FADESPEED 5     // make this higher to slow down

#define DELAYREACTION 2
#define DELAYCOLORCHANGE 10
int asx = 0;

  
int sensorPin = 4;
int sensorValue = 0;

    int greenPinValue = 255;
    int redPinValue = 255;
    int bluePinValue = 255;

int changeColorCounter = 0;

void changeColorValue(int rgb){
  //change red
  if(rgb == 0){
      if(redPinValue > 5){
        redPinValue = redPinValue - 30; 
      }else{
        redPinValue = 255;
      }
  //change green
  }else if(rgb == 1){
      if(greenPinValue > 5){
        greenPinValue = greenPinValue - 30; 
      }else{
        greenPinValue = 255;
      }
  //change blue
  }else{
      if(bluePinValue > 5){
        bluePinValue = bluePinValue - 30; 
     
      }else{
        bluePinValue = 255;
      }
  }
}

void setup() {

  pinMode(REDPIN, OUTPUT);
  pinMode(GREENPIN, OUTPUT);
  pinMode(BLUEPIN, OUTPUT);
  
  Serial.begin(9600);
  Serial.println("Program Started Successfully");

}

void loop() {

  sensorValue = analogRead(sensorPin); 

  
if (sensorValue> 50){  //The 'silence' sensor value is 509-511
    Serial.println(sensorValue);           // The red LEDs stay on for 2 seconds
 
    if(changeColorCounter > DELAYCOLORCHANGE){
      changeColorCounter =0;
      int hold = (sensorValue % 3);
      changeColorValue(hold);  
    }
      changeColorCounter++;

    if (asx < DELAYREACTION) { 
      
      analogWrite(GREENPIN, greenPinValue);
      analogWrite(BLUEPIN, bluePinValue);
      analogWrite(REDPIN, redPinValue);

      Serial.println("Colorslit");
      Serial.print("changeColorCounter = ");
      Serial.println(changeColorCounter);

    }

    if (asx > DELAYREACTION) {
      asx = 0;
      Serial.println("Reset Sucessfully");
      analogWrite(GREENPIN, greenPinValue);
      analogWrite(BLUEPIN, bluePinValue);
      analogWrite(REDPIN, redPinValue);

    }

     asx++;

    Serial.print("asx = ");
    Serial.println(asx);
  
    Serial.print("red = ");
    Serial.println(redPinValue);

    Serial.print("green = ");
    Serial.println(greenPinValue);

    Serial.print("blue = ");
    Serial.println(bluePinValue);

    delay(30);

     asx++;

    
} else {
    
    analogWrite(REDPIN, 0);
    analogWrite(GREENPIN, 0);
    analogWrite(BLUEPIN, 0);

    
}






}
