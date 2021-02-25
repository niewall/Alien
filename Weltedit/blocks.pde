PImage background;

void loadRest(){
    background = loadImage("background0.png");
}

void drawBlock(int pBlock,int pX,int pY){
  //Update to Image Array

  image(blockIm[pBlock],pX,pY);
  
}

void drawBlackground(){
  image(background,0,0, 1860, 1003);
  
  
}
