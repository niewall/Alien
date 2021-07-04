// Class for animating a sequence of GIFs

class Animation {
  PImage[] images;
  int imageCount;
  float frame;
  float speed;
  
  Animation(String imagePrefix,float pSpeed, int count) {
    imageCount = count;
    speed = pSpeed;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + str(i) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+0.1) % imageCount;
    image(images[int(frame)], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
