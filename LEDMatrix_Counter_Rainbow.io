/*
Binary counter with scrolling RGB gradient background.
*/

// Eight column pins and three row pins for each RGB:
const int rownum[9] = { 10,11,12,13,14,15,16,17,18 };
const int colnum[8] = { 2,3,4,5,6,7,8,9,};

// Initialize pins and set all LEDS off.
void setup() {
  Serial.begin(9600);
  for (int thisPin = 0; thisPin < 8; thisPin++) {
    pinMode(colnum[thisPin], OUTPUT);
    digitalWrite(colnum[thisPin], HIGH);
  }
  for (int thisPin = 0; thisPin < 9; thisPin++) {
    pinMode(rownum[thisPin], OUTPUT);
    digitalWrite(rownum[thisPin], LOW);
  }
}

//Initialize counter at zero.
int count[3][8] = {
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0}
  };

//Define gradient pattern.
const int gradient[4][8] = {
  {2,2,2,0,1,1,1,2},
  {2,2,0,0,0,1,2,2},
  {2,0,0,0,0,1,2,2},
  {0,0,0,0,1,1,1,2}
  };


//This function adds one to the clock.
void updateClock(){
  int flag=1;
  for(int j = 0; j < 3; j++) {
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
  }

//This function flashes any LED.
void flash(int row, int col){
  digitalWrite(rownum[row], HIGH);
  digitalWrite(colnum[col], LOW);
  delay(0.75);
  digitalWrite(rownum[row], LOW);
  digitalWrite(colnum[col], HIGH);
  }

//Main loop: Shift gradient, update clock and display count.
void loop() {
	int rowpin=0;
	int colcol=0;
	int colpin=0;
	
	for(int shift=0; shift<8; shift++)
	  {
	
	  updateClock();
	
	  for (int shiftpause=0; shiftpause<25; shiftpause++)
		{
		for (int color=0; color < 4; color++)
		  {
		  for (int row=0; row<3; row++)
			{
			for (int col=0; col<8; col++)
			  {
			  colcol = (col + row) % 8 ;
			  rowpin = row + (3 * gradient[color][colcol]);
			  colpin = (col + shift) % 8;
			  // If cell is off, flash the gradient as background
			  if ( count[row][colpin] == 0 ) { flash(rowpin,colpin); }
			  //Else flash bright color.
			  else
				{
				flash(row + 3, colpin);
				flash(row, colpin);
				flash(row+3,colpin);
				flash(row+6,colpin);
				flash(row+3,colpin);
				}
			  }
			}
		  }
		}
	  }
	}

