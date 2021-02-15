float x;
float y;


//Blockgröße normalerweise 60x60, hier 58x58 um seitlich Edit-Infos zu zeigen
int bSize = 58;

int[][] block = new int[256][34];  //Jeder Block ist durch eine Nummer definiert und wird bei den entsprechenden Koordinaten im Raum platziert.

int currentBlock = 1;
int mausInput = 0;

void setup(){
  size(1920, 1020); 
  rectMode(CORNER);
  surface.setResizable(true);
  
  for(int i = 0; i < 256; i++){
    for(int ii = 0; ii < 34; ii++){
      block[i][ii] = 0;
    }
  }
  
}

void draw(){
  background(0);
  
  if(mouseX >= 0 && mouseY >=0){
    x = mouseX;
    y = mouseY;
  }
  
  stroke(255);
  
  drawBlocks();
  buttonSave();
  buttonLoad();
  buttonClear();
  

  //println(str(x) + str(y));
  mausInput = maus();
  if(mausInput == 0){
   releaseCurser = true;  
  }
  if(mausInput == 1){
    placeBlock(int(x),int(y), currentBlock);     
  }
  if(mausInput == 2){
    placeBlock(int(x),int(y), 0);
  }
    
  
  
  
  //rect(x, y, bSize, bSize);
  
  
}

void placeBlock(int pX, int pY, int pBlock){
  int xIndex = round((pX-(bSize*0.5))/bSize); //Gibt den Index des angeklickten Blocks wieder. Um die Hälfte nach links verschoben um nachzujustieren, da immer auf die nächst niedrigste volle Zahl gerundet wird.
  int yIndex = round((pY-(bSize*0.5))/bSize);
  
  if(xIndex < 32 && yIndex < 17){
    block[xIndex][yIndex+ 17] = pBlock;
  }
  
  //println("Original: " + str(pX) + " - " + str(pY));
  //println("Index   : " + str(xIndex) + " - " + str(yIndex));

}

void drawBlocks(){
  
  for(int i = 0; i < 32; i++){
  for(int ii = 17; ii < 34; ii++){
      fill(0);
      if(block[i][ii] == 1){
        fill(180);
      }
      rect(i*bSize,(ii-17)*bSize,bSize,bSize);
      
    }
  }
  
}

int maus(){
  if(mousePressed == true){
    if (mouseButton == LEFT) {
      return 1;
    }else
    if (mouseButton == RIGHT) {
      return 2;
    }else{
    return 0;
    }
  }else{
    return 0;
  }
}
