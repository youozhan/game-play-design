/*
  square of eeonyx fabric with 6 conductive rows and 6 conductive columns
  parsing through this grid by switching individual rows/columns to be
  HIGH, LOW or INPUT (high impedance) to detect location and pressure
  >> http://howtogetwhatyouwant.at/
*/

#define numRows 7
#define numCols 7
int rows[] = {
  A7, A3, A9, A11, A12, A14, A15
};
int cols[] = {
  22, 23, 26, 27, 30, 31, 35
};
int incomingValues[49] = {
};


int pressed = 0;
int col = 0;
int row = 0;

void setup() {
  // set all rows and columns to INPUT (high impedance):
  for (int i = 0; i < numRows; i++) {
    pinMode(rows[i], INPUT)
    ;
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

  for (int i = 0; i < 49; i++) {
    //Serial.print(incomingValues[i]);
    if (incomingValues[i] < 25) {
      //      Serial.print(i);
      //      Serial.print(",");
      pressed = i;
      row = i % 7 + 1;
      col = int(i / 7) + 1;

    }
  }

  Serial.print(pressed);
  Serial.print(",");
  Serial.print(row);
  Serial.print(",");
  Serial.print(col);
  Serial.print(",");
  Serial.println();

}
