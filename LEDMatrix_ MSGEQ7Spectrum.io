// Define LED Matrix Pins
const int rownum[6] = { 18, 17, 16, 15, 14, 13 };
const int colnum[9] = { 4, 5, 6, 7, 8, 9, 10, 11, 12 };

// Define EQ7 Pins
int analogPin = 19; // read from multiplexer using analog input 5
int strobePin = 2; // strobe is attached to digital pin 2
int resetPin = 3; // reset is attached to digital pin 3
int spectrumValue[7]; // to hold a2d values

void setup()
{
  // Initialize LED Pins  
  for (int thisPin = 0; thisPin < 9; thisPin++) {
      pinMode(colnum[thisPin], OUTPUT);
      digitalWrite(colnum[thisPin], HIGH);
    }
    for (int thisPin = 0; thisPin < 7; thisPin++) {
      pinMode(rownum[thisPin], OUTPUT);
      digitalWrite(rownum[thisPin], LOW);
    }

   // Initialize EQ7 Pins
   Serial.begin(9600);
   pinMode(analogPin, INPUT);
   pinMode(strobePin, OUTPUT);
   pinMode(resetPin, OUTPUT);
   analogReference(DEFAULT);
  
   digitalWrite(resetPin, LOW);
   digitalWrite(strobePin, HIGH);
  }

void loop() {
  digitalWrite(resetPin, HIGH);
  digitalWrite(resetPin, LOW);
  
  for (int i = 0; i < 7; i++) {
    digitalWrite(strobePin, LOW);
    delayMicroseconds(30); // to allow the output to settle
    spectrumValue[i] = analogRead(analogPin);
  
    for (int j=0; j < ( spectrumValue[i] / 170 ); j++ ){
      flash(j,i);
      if ( i == 2){ flash(j,7); } // Add some color.
      else if ( i == 5){ flash(j,8); } // Add some color.
    }
  
    digitalWrite(strobePin, HIGH);
  }

}

//Pin flash function
void flash(int row, int col){
  digitalWrite(rownum[row], HIGH);
  digitalWrite(colnum[col], LOW);
  delay(0.75);
  digitalWrite(rownum[row], LOW);
  digitalWrite(colnum[col], HIGH);
}
