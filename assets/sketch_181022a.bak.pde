PImage[] lamp = new PImage[2];
PImage[] personLeft = new PImage[4];
PImage personLight;
PImage light;
color day, night;

PFont font;

//int lampIndex = 0;
int personIndex = 0;
float personPosX = 0;
//float yPosition;
boolean faceLeft = true;
int lampCount = 5;
float[] lampPosX = new float[lampCount];
float lampInterval = 400;
int currentPos;
boolean lighting = false;
boolean lighted = false;

void setup() {
  fullScreen();
  //size(1280, 720);
  font = createFont("Futura", 28);
  textFont(font);

  // draw background
  day = color(255);
  night = color(39, 32, 62);
  setGradient(0, 0, width, height, day, night);

  // draw person
  for (int i = 0; i < 4; i++) {
    personLeft[i] = loadImage("walk"+i+".png");
  }
  personLight = loadImage("stand.png");

  // draw lamp
  lamp[0] = loadImage("lamp.png");
  light = loadImage("light.png");

  frameRate(20);
}

void draw() {
  setGradient(0, 0, width, height, day, night);

  for (int i = 0; i < lampCount; i++) {
    lampPosX[i] = lampInterval * i;
    image(lamp[0], lampPosX[i], height/2-60);
  }

  if (lighted && currentPos != 0) {
    image(light, lampPosX[currentPos-1]-130, height/2-180);
  }

  if (faceLeft && !lighting) {
    image(personLeft[personIndex], width/2+personPosX, height/2);
  }

  if (faceLeft && lighting) {
    image(personLight, width/2+personPosX-45, height/2);
  }

  if (personPosX > width/2) {
    personPosX = -width/2;
  }

  if (personPosX < -width/2) {
    personPosX = width/2;
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

void checkCurrent() {
  currentPos = 0;
  for (int i = 0; i < lampCount; i++) {
    println(abs(width/2 + personPosX - lampPosX[i]));

    if (abs(width/2 + personPosX - lampPosX[i]) < 100) {
      currentPos = i + 1;
      fill(0);
      text("current position is " + currentPos, 60, 60);
      println("current position is " + currentPos);
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      faceLeft = true;
      personPosX = personPosX - 30;
      personIndex = (personIndex + 1) % 4;
      lighting = false;
    }
  }

  if (key == ' ') {
    lighting = true;
    checkCurrent();

    if (currentPos > 0) {
      lighted = true;
      println("current position is lighted");
    }
  }
}
