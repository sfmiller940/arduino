//Makes a lil rainbow square.

//Delay in milliseconds for each flash.
const float pause = 0.2;
//Shift Register Pins
const int latchPin = 5;
const int clockPin = 4;
const int dataPin = 6;
//Rows pins for the LED matrix
const int rowpin[8] = { 11, 12, 13, 14, 15, 16, 17, 18 };
//RGB LEDs in binary. 
byte leds[3] = { 0xFF, 0xFF, 0xFF } ; // Hex for 11111111 so they are all turned off.


//Set pins to output.
void setup() {
  pinMode(latchPin, OUTPUT);
  pinMode(dataPin, OUTPUT);  
  pinMode(clockPin, OUTPUT);
  for(int i =0; i<8; i++){ pinMode(rowpin[i], OUTPUT); }
  Serial.begin(9600);
}
  
  
//Main Loop
void loop() 
{
  updateShiftRegister();
  for (int j = 0; j < 8; j++){
    digitalWrite(rowpin[j], HIGH);
    for (int flash=0; flash<8; flash++){
      for (int i = 0; i < 8; i++)
      {
         if ( flash > i ) { bitClear(leds[2],i); }
         if ( flash < i && flash > j ) { bitClear(leds[0],i); }
         if ( flash < i && flash < j ) { bitClear(leds[1],i); }
      }
      updateShiftRegister();
      for (int k=0; k<3; k++){ leds[k] = 0xFF; }
    }
    digitalWrite(rowpin[j], LOW);
  }
}
 
void updateShiftRegister()
{
   digitalWrite(latchPin, LOW);
   for (int i=0;i<3;i++) { shiftOut(dataPin, clockPin, LSBFIRST, leds[i]); }
   digitalWrite(latchPin, HIGH);
   delay(pause);
}
