class Person {
  PImage[] personLeft;
  PImage[] personRight;
  PImage personLightLeft;
  PImage personLightRight;
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

    personLightLeft = loadImage("stand.png");
    personLightRight = loadImage("fstand.png");
    personIdle = loadImage("idle.png");
    personIndex = 0;
    personPosX = width/2;
    personPosY = height/2;
    standPosX = personPosX;
    standPosY = personPosY;
    faceLeft = true;
    lighting = false;
    idle = true;
  }

  void display() {
    if (!idle) {
      if (!lighting) {
        if (faceLeft) {
          image(personLeft[personIndex], personPosX, personPosY);
        } else {
          image(personRight[personIndex], personPosX, personPosY);
        }
      }

      if (lighting) {
        if (faceLeft) {
          image(personLightLeft, standPosX, standPosY);
        } else {
          image(personLightRight, standPosX, standPosY);
        }
      }
    } else {
      image(personIdle, standPosX, standPosY);
    }

    if (personPosX > width) {
      personPosX = 0;
    }

    if (personPosX < 0) {
      personPosX = width;
    }
  }

  void update() {
    if (faceLeft) {
      personPosX = personPosX - 30;
      standPosX = personPosX - 45;
    } else {
      personPosX = personPosX + 30;
      standPosX = personPosX + 25;
    }
    personIndex = (personIndex + 1) % 4;
  }
}
