float x;
float y;


//Blockgröße normalerweise 60x60, hier 58x58 um seitlich Edit-Infos zu zeigen
int bSize = 58;

int[][] block = new int[256][34];  //Jeder Block ist durch eine Nummer definiert und wird bei den entsprechenden Koordinaten im Raum platziert.

int currentBlock = 1;
int mausInput = 0;
int screenNum = 0;


void setup(){
  size(1920, 1020); 
  rectMode(CORNER);
  surface.setResizable(true);
  
  loadImages();
  
  for(int i = 0; i < 256; i++){
    for(int ii = 0; ii < 34; ii++){
      block[i][ii] = 0;
    }
  }
  
}

void draw(){
  background(98,198,223);
  //drawBlackground();
  
  if(mouseX >= 0 && mouseY >=0){
    x = mouseX;
    y = mouseY;
  }
  
  stroke(255);
  
  drawBlocks();
  buttonSave();
  buttonLoad();
  buttonClear();
  displayStats();
  

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
      
  
}

void placeBlock(int pX, int pY, int pBlock){
  int xIndex = round((pX-(bSize*0.5))/bSize); //Gibt den Index des angeklickten Blocks wieder. Um die Hälfte nach links verschoben um nachzujustieren, da immer auf die nächst niedrigste volle Zahl gerundet wird.
  int yIndex = round((pY-(bSize*0.5))/bSize);
  
  if(xIndex < 32 && yIndex < 17){
    if(screenNum % 2 == 0){
      block[xIndex + 32*(round(screenNum/2))][yIndex+ 17] = pBlock;
    }else{
      print(round(screenNum/2));
      block[xIndex + 32*(round(screenNum/2))][yIndex] = pBlock;
    }
  }
  
  //println("Original: " + str(pX) + " - " + str(pY));
  //println("Index   : " + str(xIndex) + " - " + str(yIndex));

}

void drawBlocks(){

  int[] f = {0,0};

  f = getScreenIndex();
  
  int xDiff = 32*(screenNum/2);
  int yDiff = 17*((screenNum+1) % 2);
  
  for(int i = f[0]; i < (32 + (32*(screenNum/2))); i++){
  for(int ii = f[1]; ii < (17+(17*((screenNum+1) % 2))); ii++){
    
      drawBlock(block[i][ii],(i-xDiff)*bSize,(ii - yDiff)*bSize);
      //rect((i-xDiff)*bSize,(ii - yDiff)*bSize,bSize,bSize);
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


int[] getScreenIndex(){
  int[] f = {0,0};
    switch(screenNum){
        case 0:
            f[0]=0; f[1]=17; break;
        case 1:
            f[0]=0; f[1]=0; break;
        case 2:
            f[0]=32; f[1]=17; break;
        case 3:
            f[0]=32; f[1]=0; break;
        case 4:
            f[0]=64; f[1]=17; break;
        case 5:
            f[0]=64; f[1]=0; break;
        case 6:
            f[0]=96; f[1]=17; break;
        case 7:
            f[0]=96; f[1]=0; break;
        case 8:
            f[0]=128; f[1]=17; break;
        case 9:
            f[0]=128; f[1]=0; break;
        case 10:
            f[0]=160; f[1]=17; break;
        case 11:
            f[0]=160; f[1]=0; break;
        case 12:
            f[0]=192; f[1]=17; break;
        case 13:
            f[0]=192; f[1]=0; break;
        case 14:
            f[0]=224; f[1]=17; break;
        case 15:
            f[0]=224; f[1]=0; break;
  }
  return f;
}
