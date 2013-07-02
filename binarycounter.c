/*
Binary Counter
*/

// Column and row pin numbers:
const int colnum[8] = { 7,9,11,14,3,5,16,18  };
const int rownum[8] = { 6,8,10,12,2,4,15,17 };

// Initialize and Turn Off All Pins
void setup() {
  Serial.begin(9600);
  for (int thisPin = 0; thisPin < 8; thisPin++) {
    pinMode(colnum[thisPin], OUTPUT);
    pinMode(rownum[thisPin], OUTPUT);
    digitalWrite(colnum[thisPin], HIGH);
    digitalWrite(rownum[thisPin], LOW);
  }
}

// Initialize Binary Count at Zero
int count[8][8] = {
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0}
};

// Initialize Loop Variables.
const int persec = 31;
int flag;

void loop() {

  // Add one to the counter.
  flag = 1;
  for(int j = 0; j < 8; j++) {
    for (int k = 0; k < 8; k++) {
      if( flag == 1) {
        if ( count[j][k]==1 ) { count[j][k]=0; }
        else {
          count[j][k]=1;
          flag=0;
        }
      }
    }
  }

  // Flash the Counter
  for (int flash = 0; flash < persec; flash++) {
    for(int j = 0; j < 8; j++) {
      for (int k = 0; k < 8; k++) {
        if(count[j][k] == 1) {
          digitalWrite(colnum[j], LOW);
          digitalWrite(rownum[k], HIGH);
          digitalWrite(rownum[k], LOW);
          digitalWrite(colnum[j], HIGH);
        }
      }
    }
  }
}