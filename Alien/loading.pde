PImage[] player = new PImage[4];
PImage background;
JSONArray blockData;
JSONArray progressData;
JSONArray pArray;
LvlData[] lvlData = new LvlData[4];


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
    currentLevel = world;
    int blockNr;
    byte data[] = {0,0};
    int counter = 0;
    int counterEnemy = 0;
    lvlStartTime = lastTime;
    counterEnemys = -1;
    for(int i = 0; i < 256; i++){
      for(int ii = 0; ii < 68; ii++){
        data[0] = blockBytes[counter];
        data[1] = blockBytes[counter+1];
        blockNr = bytesToInt(data);
        
        if(blockNr > blockAmount){blockNr = 0;}
        JSONObject blockDat = blockData.getJSONObject(blockNr);
        
        if(blockDat.isNull("enemy")){
          boolean pSolid = blockDat.getBoolean("solid");
          boolean pCollect = blockDat.getBoolean("collectable");
          String pCollectID = "";
          int pDamage = blockDat.getInt("damage");
          if(pCollect){
            pCollectID = blockDat.getString("collectID");
          }
          block[i][ii/2] = new Blocks(i,ii/2,blockNr,pSolid,pCollect,pCollectID,pDamage);  //The Block gets the position and value for solid
        }else if(blockDat.getBoolean("enemy")== true){
          counterEnemys++;
          String pImage = blockDat.getString("image");
          int pDamage = blockDat.getInt("damage");
          enemy[counterEnemy] = new Enemy(i,ii/2,pDamage,pImage);
          counterEnemy++;
          block[i][ii/2] = new Blocks(i,ii/2,0,false,false,"",0);
      }
        
        counter = counter +2;
        ii++;
        println(counter);
    }
    }
    
}

void loadProgress(){
  progressData = loadJSONArray("progress.json");
  
  for(int i = 0; i<4;i++){

    JSONObject lvlValues = progressData.getJSONObject(i);
        
    boolean unlocked = lvlValues.getBoolean("unlocked");
    int pScore = lvlValues.getInt("score");
    boolean[] archivments = {lvlValues.getBoolean("archivment1"),lvlValues.getBoolean("archivment2"),lvlValues.getBoolean("archivment3")};
    lvlData[i] = new LvlData(i,unlocked,pScore,archivments);
  }
}

void saveProgress(){

  pArray = new JSONArray();
  
  for(int i = 0; i<4;i++){

    JSONObject pSaveData = new JSONObject();
    
    pSaveData.setInt("id", i);
    pSaveData.setBoolean("unlocked", lvlData[i].getUnlockStatus());
    pSaveData.setInt("score", lvlData[i].getScore());
    pSaveData.setBoolean("archivment1", lvlData[i].archivments[0]);
    pSaveData.setBoolean("archivment2", lvlData[i].archivments[1]);
    pSaveData.setBoolean("archivment3", lvlData[i].archivments[2]);
  
    pArray.setJSONObject(i, pSaveData);
  }
  
  saveJSONArray(pArray,"data/progress.json");
  
  
}

int bytesToInt(byte[] pData){
  int blNr = 0;
  String st1 = Integer.toString(int(pData[0]), 2);
  String st2 = Integer.toString(int(pData[1]), 2);
  blNr = Integer.parseInt(st2+st1,2);
  
  return blNr;
}
