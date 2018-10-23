color day, night;
Person person;
int lampCount = 5;
float lampInterval = 400;
Lamp[] lamp = new Lamp[lampCount];

PFont font;

int currentPos;

void setup() {
  fullScreen();
  //size(1280, 720);
  font = createFont("Futura-Medium", 28);
  textFont(font);

  // draw background
  day = color(255);
  night = color(39, 32, 62);
  setGradient(0, 0, width, height, day, night);

  person = new Person();

  for (int i = 0; i < lamp.length; i++) {
    lamp[i] = new Lamp(lampInterval*i);
  }

  //frameRate(20);
}

void draw() {
  setGradient(0, 0, width, height, day, night);

  for (int i = 0; i < lampCount; i++) {
    lamp[i].display();
    lamp[i].update();
  }

  person.display();
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
    println(person.personPosX - lamp[i].lampPosX);

    if (abs(person.personPosX - 100 - lamp[i].lampPosX) < 70) {
      currentPos = i + 1;
      fill(0);
      //text("current position is " + currentPos, 60, 60);
      println("current position is " + currentPos);
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      person.faceLeft = true;
      person.update();
      person.lighting = false;
    }
    
    if (keyCode == RIGHT){
      person.faceLeft = false;
      person.update();
      person.lighting = false;
    }
  }
}

void keyReleased() {
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
