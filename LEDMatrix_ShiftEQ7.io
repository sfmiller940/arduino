//Makes a rainbow EQ7

//Shift Register Pins
const int latchPin = 5;
const int clockPin = 4;
const int dataPin = 6;
//Rows pins for the LED matrix
const int rowpin[8] = { 11, 12, 13, 14, 15, 16, 17, 18 };
//RGB LEDs in binary. 
byte leds[3] = { 0xFF, 0xFF, 0xFF } ; // Hex for 11111111 so they are all turned off.
// Define EQ7 Pins
int analogPin = 19; // read from multiplexer using analog input 5
int strobePin = 2; // strobe is attached to digital pin 2
int resetPin = 3; // reset is attached to digital pin 3
int spectrumValue[7]; // to hold a2d values

void setup() {
  //Initialize shift register pins.
  pinMode(latchPin, OUTPUT);
  pinMode(dataPin, OUTPUT);  
  pinMode(clockPin, OUTPUT);
  //Set shift register to blank.
  flash_row();
  //Initialize LED matrix row pins and set to off.
  for(int i =0; i<8; i++){
    pinMode(rowpin[i], OUTPUT);
    digitalWrite(rowpin[i], LOW);
  }
  // Initialize EQ7 Pins
  pinMode(analogPin, INPUT);
  pinMode(strobePin, OUTPUT);
  pinMode(resetPin, OUTPUT);
  analogReference(DEFAULT);  
  digitalWrite(resetPin, LOW);
  digitalWrite(strobePin, HIGH);
}
  
  
//Main Loop
void loop() 
{
  // Reset EQ7.
  digitalWrite(resetPin, HIGH);
  digitalWrite(resetPin, LOW);
  
  for(int j=0; j<7;j++){
    //Read EQ7
    digitalWrite(strobePin, LOW);
    delayMicroseconds(30); // to allow the output to settle
    spectrumValue[j] = analogRead(analogPin);
    digitalWrite(strobePin, HIGH);
    //Turn on row.
    digitalWrite(rowpin[j], HIGH);
    for (int flash=0; flash<7; flash++){
      for (int i = 0; i < 8; i++){
        if(i <= (spectrumValue[j] / 128) ){
           if (i > flash ) { bitClear(leds[2],i); }
             if (j < flash - i ) { bitClear(leds[0],i); }
             if (j > flash + i) { bitClear(leds[1],i); }

        }
      }
      //Flash and reset to blank.
      flash_row();
      for (int k=0; k<3; k++){ leds[k] = 0xFF; }
    }
    //Turn off row.
    digitalWrite(rowpin[j], LOW);
  }
}
 
void flash_row()
{
   digitalWrite(latchPin, LOW);
   for (int q=0;q<3;q++) { shiftOut(dataPin, clockPin, LSBFIRST, leds[q]); }
   digitalWrite(latchPin, HIGH);
}
