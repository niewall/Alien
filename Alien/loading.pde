PImage[] player = new PImage[2];
PImage background;


void loadRest(){
  //background = loadImage("MAPS.png");
  //background.resize(15360, 0);
  player[0] = loadImage("man.png");
  player[1] = loadImage("blobRight.png");
  
}

void createBlocks(String world){
    byte blockBytes[] = loadBytes("level3New.dat"); 
    int blockNr;
    byte data[] = {0,0};
    int counter = 0;
    for(int i = 0; i < 256; i++){
      for(int ii = 0; ii < 68; ii++){
        data[0] = blockBytes[counter];
        data[1] = blockBytes[counter+1];
        blockNr = bytesToInt(data);
        block[counter/2] = new Blocks(i,ii/2,blockNr,getBlockSolid(blockNr));  //The Block gets the position and value for solid
        counter = counter +2;
        ii++;
        println(counter);
    }
    }
    
}

int bytesToInt(byte[] pData){
  int blNr = 0;
  String st1 = Integer.toString(int(pData[0]), 2);
  String st2 = Integer.toString(int(pData[1]), 2);
  blNr = Integer.parseInt(st2+st1,2);
  
  return blNr;
}
