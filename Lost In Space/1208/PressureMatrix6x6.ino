
/*
  square of eeonyx fabric with 6 conductive rows and 6 conductive columns
  parsing through this grid by switching individual rows/columns to be
  HIGH, LOW or INPUT (high impedance) to detect location and pressure
  >> http://howtogetwhatyouwant.at/
*/

#define numRows 8
#define numCols 8
int rows[] = {
  A0, A1, A2, A3, A4, A5, 3, 5
};
int cols[] = {
  2, 4, 7, 8, 9, 10, 11, 12
};
int incomingValues[64] = {
};

int pressedValues[64] = {};
int pressed = 0;
int col = 0;
int row = 0;


void setup() {
  // set all rows and columns to INPUT (high impedance):
  for (int i = 0; i < numRows; i++) {
    pinMode(rows[i], INPUT);
  }
  for (int i = 0; i < numCols; i++) {
    pinMode(cols[i], INPUT);
  }
  Serial.begin(9600);
}

void loop() {
  for (int colCount = 0; colCount < numCols; colCount++) {
    pinMode(cols[colCount], OUTPUT);  // set as OUTPUT
    digitalWrite(cols[colCount], LOW);  // set LOW

    for (int rowCount = 0; rowCount < numRows; rowCount++) {
      pinMode(rows[rowCount], INPUT_PULLUP);  // set as INPUT with PULLUP RESISTOR
      delay(1);
      incomingValues[ ( (colCount)*numRows) + (rowCount)] = analogRead(rows[rowCount]);  // read INPUT

      // set pin back to INPUT
      pinMode(rows[rowCount], INPUT);

    }// end rowCount

    pinMode(cols[colCount], INPUT);  // set back to INPUT!

  }// end colCount

  // Print the incoming values of the grid:
  for (int i = 0; i < 64; i++) {
//        Serial.print(incomingValues[i]);
//        Serial.print(",");
    if (incomingValues[i] < 20) {
      pressedValues[i] = 1;
      row = i % 8 + 1;
      col = (i - row) / 8 + 1;
    }
  }

  for (int i = 0; i < 64; i++) {
    pressed = pressed || pressedValues[i];
  }

  Serial.print(pressed);
  Serial.print(",");
  Serial.print(row);
  Serial.print(",");
  Serial.print(col);
  Serial.println();

//  Serial.println();
}
