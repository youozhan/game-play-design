PImage[] lamp = new PImage[2];
PImage[] personLeft = new PImage[4];
PImage personStand;
color day, night;

int lampIndex = 0;
int personIndex = 0;
float xPosition = 0;
float yPosition;
boolean faceLeft = true;

void setup() {
  fullScreen();

  // draw background
  day = color(255);
  night = color(39, 32, 62);
  setGradient(0, 0, width, height, day, night);

  // draw person
  for (int i = 0; i < 4; i++) {
    personLeft[i] = loadImage("walk"+i+".png");
  }

  frameRate(10);
}

void draw() {
  setGradient(0, 0, width, height, day, night);
  if (faceLeft) {
    image(personLeft[personIndex], width/2+xPosition, height/2);
    //if(keyPressed){
    //  personIndex = (personIndex + 1) % 4;
    //}
  }
  
  if (xPosition > width/2){
    xPosition = -width/2;
  }
  
  if (xPosition < -width/2){
    xPosition = width/2;
  }
}

void setGradient(int x, int y, float w, float h, color c1, color c2) {
  noFill();
  for (int i=x; i<=x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(i, y, i, y+h);
  }
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      faceLeft = true;
      xPosition = xPosition - 30;
      personIndex = (personIndex + 1) % 4;
    }
  }
}
