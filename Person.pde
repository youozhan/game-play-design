class Person {
  PImage[] personLeft;
  PImage[] personRight;
  PImage personLight;
  PImage personIdle;
  int personIndex;
  float personPosX;
  float personPosY;
  float standPosX;
  float standPosY;
  boolean faceLeft;
  boolean lighting;
  boolean idle;

  Person() {
    personLeft = new PImage[4];
    personRight = new PImage[4];
    for (int i = 0; i < 4; i++) {
      personLeft[i] = loadImage("walk"+i+".png");
      personRight[i] = loadImage("fwalk"+i+".png");
    }

    personLight = loadImage("stand.png");
    personIdle = loadImage("idle.png");
    personIndex = 0;
    personPosX = width/2;
    personPosY = height/2;
    standPosX = personPosX - 45;
    standPosY = personPosY;
    faceLeft = true;
    lighting = false;
    idle = false;
  }

  void display() {
    if (!lighting) {
      if (faceLeft) {
        image(personLeft[personIndex], personPosX, personPosY);
      } else {
        image(personRight[personIndex], personPosX, personPosY);
      }
    }

    if (lighting) {
      image(personLight, standPosX, standPosY);
    }

    if (personPosX > width) {
      personPosX = 0;
    }

    if (personPosX < 0) {
      personPosX = width;
    }
  }

  void update() {
    if (faceLeft){
      personPosX = personPosX - 30;
    } else {
      personPosX = personPosX + 30;
    }
    standPosX = personPosX - 45;
    personIndex = (personIndex + 1) % 4;
  }
}
