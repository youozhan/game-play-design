class Lamp {
  PImage lampImage;
  PImage lampLight;
  //int lampCount;
  float lampPosX;
  float lampPosY;
  float lightPosX;
  float lightPosY;
  boolean lighted;

  Lamp(float lampPosX_) {
    lampImage = loadImage("lamp.png");
    lampLight = loadImage("light.png");
    //lampCount = lampCount_;
    lampPosX = lampPosX_;
    lampPosY = height/2 - 60;
    lightPosX = lampPosX - 130;
    lightPosY = height/2 - 180;
    lighted = false;
  }

  void display() {
    image(lampImage, lampPosX, lampPosY);
  }

  void update() {
    if (lighted) {
      image(lampLight, lightPosX, lightPosY);
    } else {
    }
  }
}
