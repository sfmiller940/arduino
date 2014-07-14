//Rainbow audio spectrum.


// GTM2088ARGB-28 LED matrix row pins
const int rowpin[8] = { 8, 12, 13, 14, 15, 16, 17, 18 };
// 74HC595 shift register pins
const int latchPin = 5;
const int clockPin = 4;
const int dataPin = 6;
// Brightness pins
const int brightpin[3]={ 11, 10, 9};
// MSGEQ7 Pins
int analogPin = 19; // read from multiplexer using analog input 5
int strobePin = 2; // strobe is attached to digital pin 2
int resetPin = 3; // reset is attached to digital pin 3
int spectrumValue[7]; // to hold a2d values


// Array of shift bytes
byte leds[3] = { 0xFF, 0xFF, 0xFF } ; // 0xFF is hex for 11111111, all RGB turned off.


void setup() {
  // Initialize shift register pins.
  pinMode(latchPin, OUTPUT);
  pinMode(dataPin, OUTPUT);  
  pinMode(clockPin, OUTPUT);
  // Set shift register to blank.
  flash_row();
  // Initialize LED matrix row pins and set to off.
  for(int i =0; i<8; i++){
    pinMode(rowpin[i], OUTPUT);
    digitalWrite(rowpin[i], LOW);
  }
  // Initialize bright pins and set to bright.
  for(int i =0; i<3; i++){
    pinMode(brightpin[i], OUTPUT);
    analogWrite(brightpin[i], 0);
  }
  // Initialize MSGEQ7 Pins
  pinMode(analogPin, INPUT);
  pinMode(strobePin, OUTPUT);
  pinMode(resetPin, OUTPUT);
  analogReference(DEFAULT);  
  digitalWrite(resetPin, LOW);
  digitalWrite(strobePin, HIGH);
}
  

void loop() 
{
  // Reset MSGEQ7
  digitalWrite(resetPin, HIGH);
  digitalWrite(resetPin, LOW);
  
  // Loop over columns/frequencies
  for(int j=0; j<7;j++){

    //Set BG brightness.
    analogWrite(brightpin[1], 255 - (42 * j) );
    analogWrite(brightpin[0], 3 + (42 * j) );

    //Read EQ7
    digitalWrite(strobePin, LOW);
    delayMicroseconds(30); // to allow the output to settle
    spectrumValue[j] = analogRead(analogPin);
    digitalWrite(strobePin, HIGH);

    //Turn on row.
    digitalWrite(rowpin[j], HIGH);
    
    //Start flashing
    for (int flash=0; flash<7; flash++){
      for (int i = 0; i <= (spectrumValue[j] / 128); i++){
        //if(i <= (spectrumValue[j] / 128) ){
           if (i > flash ) { bitClear(leds[2],i); }
           else{
            bitClear(leds[1],i); 
            bitClear(leds[0],i); 
           }
        //}
      }
      //Flash and reset to blank.
      flash_row();
      for (int k=0; k<3; k++){ leds[k] = 0xFF; }
    }
    //Turn off row.
    digitalWrite(rowpin[j], LOW);
  }
}


// Set shift registers to leds[]
void flash_row()
{
   digitalWrite(latchPin, LOW);
   for (int q=0;q<3;q++) { shiftOut(dataPin, clockPin, LSBFIRST, leds[q]); }
   digitalWrite(latchPin, HIGH);
}
