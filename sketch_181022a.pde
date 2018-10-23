color day, night;
Person person;
int lampCount = 5;
float lampInterval = 360;
Lamp[] lamp = new Lamp[lampCount];

PFont font;

int currentPos;
float delta = 0;

int gameScreen = 0;

void setup() {
  fullScreen();
  //size(2880, 720);
  font = createFont("Futura-Medium", 28);
  textFont(font);

  // draw background
  day = color(255);
  night = color(39, 32, 62);

  person = new Person();

  for (int i = 0; i < lamp.length; i++) {
    lamp[i] = new Lamp(lampInterval*i+20);
  }
}

void draw() {
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  }
}

void initScreen() {
  setGradient(0, 0, width, height, day, night);
  textAlign(CENTER);
  textSize(48);
  text("THE LAMPLIGHTER", width/2, height/2 - 80);
  textSize(24);
  text("S to Start", width/2, height/2);
  text("SPACE to Light", width/2, height/2 + 40);
  text("A/D or left/right keys to Move", width/2, height/2 + 80);
}

void gameScreen() {
  background(255);
  delta -= 30;
  moveCanvas();
  println(delta);

  //fill(0);
  //text("frameCount: " + millis(), 60, 60);

  for (int i = 0; i < lampCount; i++) {
    lamp[i].display();
    lamp[i].update();
  }

  person.display();
}

void setGradient(int x, int y, float w, float h, color c1, color c2) {
  noFill();
  for (int i = x; i <= x + w; i++) {
    float inter = map(i, x, x+w, 0, 1); 
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(i, y, i, y+h);
  }
}

void moveCanvas() {
  pushMatrix();
  if (delta <= -14400) {
    delta = 0;
    translate(14400, 0);
  }
  translate(delta, 0);
  setGradient(0, 0, width*2, height, day, day);
  setGradient(2*width, 0, width/2, height, day, night);
  setGradient(width*5/2, 0, width*2, height, night, night);
  setGradient(width*9/2, 0, width/2, height, night, day);
  popMatrix();
}

void checkCurrent() {
  currentPos = 0;
  for (int i = 0; i < lampCount; i++) {
    println(person.personPosX - lamp[i].lampPosX);
    if (person.faceLeft) {
      if (abs(person.personPosX - 100 - lamp[i].lampPosX) < 70) {
        currentPos = i + 1;
        println("current position is " + currentPos);
      }
    } else {
      if (abs(person.personPosX + 60 - lamp[i].lampPosX) < 90) {
        currentPos = i + 1;
        fill(0);
        println("current position is " + currentPos);
      }
    }
  }
}

void keyPressed() {
  person.idle = false;

  if (key == 's' || key == 'S') {
    gameScreen = 1;
  }

  if (key == CODED) {
    if (keyCode == LEFT) {
      person.faceLeft = true;
      person.update();
      person.lighting = false;
    }

    if (keyCode == RIGHT) {
      person.faceLeft = false;
      person.update();
      person.lighting = false;
    }
  }

  if (key == 'a' || key == 'A') {
    person.faceLeft = true;
    person.update();
    person.lighting = false;
  }

  if (key == 'd' || key == 'D') {
    person.faceLeft = false;
    person.update();
    person.lighting = false;
  }
}

void keyReleased() {
  person.idle = false;

  if (key == ' ') {
    person.lighting = true;
    checkCurrent();

    if (currentPos > 0) {
      if (lamp[currentPos - 1].lighted) {
        lamp[currentPos - 1].lighted = false;
      } else {
        lamp[currentPos - 1].lighted = true;
      }
    }
  }
}
