// Color fader for RGB LED Strip.

// Define RGB pins
#define REDPIN 6
#define GREENPIN 5
#define BLUEPIN 3
 
#define FADESPEED 40     // make this higher to slow down
 
void setup() {
  pinMode(REDPIN, OUTPUT);
  pinMode(GREENPIN, OUTPUT);
  pinMode(BLUEPIN, OUTPUT);
}
 
 
void loop() {
  int i;
 
  // fade from green to red
  for (i = 0; i < 256; i++) { 
    analogWrite(GREENPIN, (255 - i) );
    analogWrite(REDPIN, i);
    delay(FADESPEED);
  } 
  // fade from red to blue
  for (i = 0; i < 256 ; i++) { 
    analogWrite(REDPIN, (255 - i) );
    analogWrite(BLUEPIN, i);
    delay(FADESPEED);
  } 
  // fade from blue to green
  for (i = 0; i < 256; i++) { 
    analogWrite(BLUEPIN, ( 255 - i) );
    analogWrite(GREENPIN, i);
    delay(FADESPEED);
  } 
}
