//Pin connected to latch pin (ST_CP) of 74HC595
const int latchPin = 5;
//Pin connected to clock pin (SH_CP) of 74HC595
const int clockPin = 4;
//Pin connected to Data in (DS) of 74HC595
const int dataPin = 6;
//Rows pins for the LED matrix
const int rowpin[8] = { 11, 12, 13, 14, 15, 16, 17, 18 };
//Lit LEDs in binary. 
byte leds = 0xFF; // Hex for 11111111 so they are all turned off.

//Set pins to output.
void setup() {
  pinMode(latchPin, OUTPUT);
  pinMode(dataPin, OUTPUT);  
  pinMode(clockPin, OUTPUT);
  for(int i =0; i<8; i++){ pinMode(rowpin[i], OUTPUT); }
  Serial.begin(9600);
}
  
void loop() 
{
  updateShiftRegister();
  for (int j = 0; j < 8; j++){
    for (int i = 0; i < 8; i++)
    {
      bitClear(leds, i);
      digitalWrite(rowpin[j], HIGH);
      updateShiftRegister();
      delay(50);
      digitalWrite(rowpin[j], LOW);
      bitSet(leds, i);
    }
  }
}
 
void updateShiftRegister()
{
   digitalWrite(latchPin, LOW);
   shiftOut(dataPin, clockPin, LSBFIRST, leds);
   digitalWrite(latchPin, HIGH);
}
