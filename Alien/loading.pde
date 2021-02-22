PImage[] blockIm = new PImage[255];
PImage[] player = new PImage[2];
PImage background;

void loadImages(){
  //background = loadImage("MAPS.png");
  //background.resize(15360, 0);
  blockIm[0] = loadImage("blank.png");
  blockIm[1] = loadImage("skyBlock.png");
  blockIm[2] = loadImage("dirt.png");
  blockIm[3] = loadImage("grass.png");
  blockIm[4] = loadImage("stone.png");
  blockIm[5] = loadImage("sand.png");
  blockIm[6] = loadImage("fels.png");
  blockIm[7] = loadImage("coin.png");
  blockIm[8] = loadImage("forest.png");
  
  player[0] = loadImage("man.png");
  player[1] = loadImage("blobRight.png");

  
  
}

void createBlocks(String world){
    byte blockBytes[] = loadBytes("level3.dat"); 
    int counter = 0;
    for(int i = 0; i < 256; i++){
      for(int ii = 0; ii < 34; ii++){
        block[counter] = new Blocks(blockBytes[counter],i,ii);
        counter++;
      }
    }
    
}
