PImage[] player = new PImage[4];
PImage background;
JSONArray blockData;



void loadRest(){
  background = loadImage("background.png");
  //background.resize(15360, 0);
  player[0] = loadImage("man.png");
  player[1] = loadImage("manl.png");
  player[2] = loadImage("manFightRight.png");
  player[3] = loadImage("manFightLeft.png");
  
}

void createBlocks(String world){
    byte blockBytes[] = loadBytes(world+".dat"); 
    int blockNr;
    byte data[] = {0,0};
    int counter = 0;
    int counterEnemy = 0;
    for(int i = 0; i < 256; i++){
      for(int ii = 0; ii < 68; ii++){
        data[0] = blockBytes[counter];
        data[1] = blockBytes[counter+1];
        blockNr = bytesToInt(data);
        
        //if(blockNr > blockAmount){blockNr = 0;}
        JSONObject blockDat = blockData.getJSONObject(blockNr);
        
        if(blockDat.isNull("enemy")){
          boolean pSolid = blockDat.getBoolean("solid");
          boolean pCollect = blockDat.getBoolean("collectable");
          String pCollectID = "";
          int pDamage = blockDat.getInt("damage");
          if(pCollect){
            pCollectID = blockDat.getString("collectID");
          }
          block[counter/2] = new Blocks(i,ii/2,blockNr,pSolid,pCollect,pCollectID,pDamage);  //The Block gets the position and value for solid
        }else if(blockDat.getBoolean("enemy")== true){
          String pImage = blockDat.getString("image");
          int pDamage = blockDat.getInt("damage");
          enemy[counterEnemy] = new Enemy(i,ii/2,pDamage,pImage);
          counterEnemy++;
          block[counter/2] = new Blocks(i,ii/2,0,false,false,"",0);
      }
        
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
