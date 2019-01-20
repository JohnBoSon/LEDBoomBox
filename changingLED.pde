//Beau Johnson 2016 
//code for color changing LED strip based on a gradient value
 
#define REDPIN 5
#define GREENPIN 6
#define BLUEPIN 2
#define FADESPEED 5     // higher value = slower fade speed


int sensorPin = 4;
int sensorValue = 0;
int cycles = 0;

int superMegaUltraImportantAwesomeOmegaVar = 6;

uint16_t gr = 0;
uint16_t gg = 0;
uint16_t gb = 0;

uint16_t gradient = 0; //Used to iterate and loop through each color palette gradually

uint8_t volume = 0;    //Holds the volume level read from the sound detector.
uint8_t last = 0;      //Holds the value of volume from the previous loop() pass.

float maxVol = 15;     //Holds the largest volume recorded thus far to proportionally adjust the visual's responsiveness.
float avgVol = 0;      //Holds the "average" volume-level to proportionally adjust the visual experience.
float avgBump = 0;     //Holds the "average" volume-change to trigger a "bump."

bool bump = false;     //Used to pass if there was a "bump" in volume


void setup() {

  pinMode(REDPIN, OUTPUT);
  pinMode(GREENPIN, OUTPUT);
  pinMode(BLUEPIN, OUTPUT);

  Serial.begin(9600);
  Serial.println("Program Started Successfully");

}

void loop() {

  sensorValue = analogRead(sensorPin); 
  volume = sensorValue;
  avgVol = (avgVol + volume) / 2.0;     //Take our "average" of volumes.

  //Sets a threshold for volume.
  //  In practice I've found noise can get up to 15, so if it's lower, the visual thinks it's silent.
  //  Also if the volume is less than average volume / 2 (essentially an average with 0), it's considered silent.
  if (volume < avgVol / 2.0 || volume < 15) volume = 0;

  //If the current volume is larger than the loudest value recorded, overwrite
  if (volume > maxVol) maxVol = volume;
  

//THIS IS THE BEST VALUE
if (sensorValue>superMegaUltraImportantAwesomeOmegaVar){  //The 'silence' sensor value is 509-511
    Serial.println(sensorValue);           // The red LEDs stay on for 2 seconds
    Serial.print("global r g b: ");
    Serial.print(gr);
    Serial.println(""); 
    Serial.print(gg);
    Serial.println(""); 
    Serial.println(gb);
    Serial.println(""); 

    //added
  if (gradient > 1529) {

    gradient %= 1530;

    //Everytime a palette gets completed is a good time to readjust "maxVol," just in case
    //  the song gets quieter; we also don't want to lose brightness intensity permanently 
    //  because of one stray loud sound.
//    maxVol = (maxVol + volume) / 2.0;
  }


  //If there is a decent change in volume since the last pass, average it into "avgBump"
  if (volume - last > avgVol - last && avgVol - last > 0) avgBump = (avgBump + (volume - last)) / 2.0;

  //if there is a notable change in volume, trigger a "bump"
  bump = (volume - last) > avgBump;

    if (bump) gradient += 64;
    Rainbow(gradient);

    gradient = gradient + 5;
    
}
    Color();
    fade(0.75);
    delay(30);

}

int Color(){

    analogWrite(REDPIN, gr);
    analogWrite(GREENPIN, gg);
    analogWrite(BLUEPIN, gb);

    return 0;
}

int fade(float damper){
    if (damper >= 1) damper = 0.99;

    gr = gr * damper;
    gg = gg * damper;
    gb = gb * damper;

    return 0;
}


uint32_t Rainbow(unsigned int i) {

  if (i > 1529) return Rainbow(i % 1530);

  if (i > 1274) { 
    gr = 255; 
    gg = 0;
    gb = 255 - (i % 255);   //violet -> red
    return 0;
  }
  if (i > 1019) {
    gr = i % 255;
    gg = 0;
    gb = 255; //blue -> violet
    return 0;
  }
  if (i > 764){
    gr = 0;
    gg = 255 - (i % 255);
    gb = 255; //aqua -> blue
    return 0;
  }
  if (i > 509){
    gr = 0;
    gg = 255;
    gb = (i % 255); //green -> aqua
    return 0;
  }
  if (i > 255){
    gr = 255 - (i % 255);
    gg = 255;
    gb = 0; //yellow -> green
    return 0;
  }
  if (i > 0){
    gr = 255;
    gg = i;
    gb = 0; //red -> yellow
    return 0;
  } 
}
