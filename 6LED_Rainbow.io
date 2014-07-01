// Speed variables.
float flashdelay = 0.99;
int maxflashes = 100;

// GBR Pins for each LED
int pins[6][3]={
  {2,3,4},
  {5,6,7},
  {8,9,10},
  {11,12,13},
  {A0,A1,A2},
  {A3,A4,A5}};

// Initialize pins.
void setup(){
  for( int i=2; i<14; i++ ){ pinMode( i, OUTPUT ); }
  // These analogs didn't work in loop above. Is there a cleaner way to do this?
  pinMode( A0, OUTPUT );
  pinMode( A1, OUTPUT );
  pinMode( A2, OUTPUT );
  pinMode( A3, OUTPUT );
  pinMode( A4, OUTPUT );
  pinMode( A5, OUTPUT );
}

//Pin flash function
void flash(int pin){
  digitalWrite(pin, HIGH);
  delay(flashdelay);
  digitalWrite(pin, LOW);
}

// Main loop makes the colors go around. Good luck!
void loop() {
  for (int shift=0; shift<6; shift++){
    for (int i = 0; i <  maxflashes; i++) {
      for (int LED=0; LED < 6; LED++){
        for (int m=maxflashes; i < m ; m--){
          flash( pins[LED][ ( ((LED+shift)/2) )  % 3 ] );
          flash( pins[LED][ ( ((LED+shift)/2) + ((LED+shift)%2) )  % 3 ] );
        }
        for (int m=0; m < i; m++){
          flash( pins[LED][ ( ((LED+shift)/2) + ((LED+shift)%2) )  % 3 ] );
          flash( pins[LED][ ( ((LED+shift)/2) + 1 )  % 3 ] );
        }
      }
    }
  }
}
