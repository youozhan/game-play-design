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

  Person(float personPosX_) {
    personLeft = new PImage[4];
    for (int i = 0; i < 4; i++) {
      personLeft[i] = loadImage("walk"+i+".png");
    }
    
    personLight = loadImage("stand.png");
    personIdle = loadImage("idle.png");
    personIndex = 0;
    personPosX = width/2 + personPosX_;
    personPosY = height/2;
    standPosX = personPosX - 45;
    standPosY = personPosY;
    faceLeft = true;
    lighting = false;
    idle = false;
  }

  void display() {
    if (faceLeft && !lighting) {
      //image(personLeft[personIndex], width/2+personPosX, height/2);
      image(personLeft[personIndex], personPosX, personPosY);
    }

    if (faceLeft && lighting) {
      //image(personLight, width/2+personPosX, height/2);
      image(personLight, standPosX, standPosY);
      println(standPosX);
    }

    if (personPosX > width) {
      personPosX = 0;
    }

    if (personPosX < 0) {
      personPosX = width;
    }
  }

  void update() {
    personPosX = personPosX - 30;
    personIndex = (personIndex + 1) % 4;
  }
}
