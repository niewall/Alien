PImage background;
PImage[] blockIm = new PImage[255];
int blockAmount = 9;


void loadImages(){
  background = loadImage("background0.png");
  blockIm[0] = loadImage("blank.png");
  blockIm[1] = loadImage("skyBlock.png");
  blockIm[2] = loadImage("dirt.png");
  blockIm[3] = loadImage("grass.png");
  blockIm[4] = loadImage("stone.png");
  blockIm[5] = loadImage("sand.png");
  blockIm[6] = loadImage("fels.png");
  blockIm[7] = loadImage("man.png");
  blockIm[8] = loadImage("forest.png");
}

void drawBlock(int pBlock,int pX,int pY){
  //Update to Image Array
  if(pBlock < blockAmount){
    image(blockIm[pBlock],pX,pY);
  }
}

void drawBlackground(){
  image(background,0,0, 1860, 1003);
  
  
}
