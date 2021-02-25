PImage[] blockIm = new PImage[255];
int blockAmount = 10;

void loadImages(){
  blockIm[0] = loadImage("blank.png");
  blockIm[1] = loadImage("skyBlock.png");
  blockIm[2] = loadImage("dirt.png");
  blockIm[3] = loadImage("grass.png");
  blockIm[4] = loadImage("stone.png");
  blockIm[5] = loadImage("sand.png");
  blockIm[6] = loadImage("fels.png");
  blockIm[7] = loadImage("man.png");
  blockIm[8] = loadImage("forest.png");
  blockIm[9] = loadImage("coin.png");
  
  for(int i = blockAmount; i<blockIm.length;i++){
    blockIm[i] = loadImage("blank.png");
  }
  
  loadRest();
}
