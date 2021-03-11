class Blocks{
  
  int bSize = 60;
  boolean solid;
  boolean collectable;
  boolean visible = true;
  String collectID = "";
  int damage = 0;
  int blockNr;
  int x;
  int y;
  boolean zielBlock = false;
  
  Blocks(int pX, int pY,int pBlockNr,boolean pSolid, boolean pCollectable,String pCollectID, int pDamage){
   solid = pSolid;
   blockNr = pBlockNr;
   collectable = pCollectable;
   collectID = pCollectID;
   if(collectID.equals("ziel")){
     zielBlock = true;
   }
   damage = pDamage;
   x = pX*bSize;
   y = pY*bSize;
   
  }
  
  void display(){
    if(visible){
      image(blockIm[blockNr],x,y);
    }
  }
  
  int doesCollide(float pX1,float pX2, float pY1, float pY2){
    if(solid){
      //print("Y:" + y + " - " + "pY2:" +pY2 + " || ");
      if(y+bSize+5 > pY1 && y < pY1){
        blob.getDamage(damage);
        print("HIT TOP " + pY1);
        return 2;
      }
      if(y <= pY2 && y >= pY1){
        //print("XBlock:" + (x) + " - " + "YBlock:" + (y) + "  ||  ");
        blob.getDamage(damage);
        blob.setGround(int(y+2));
        return 1;
      }
    }
    if(collectable && visible){
      if(y>pY1 && y < pY2 && !zielBlock){
        visible = false;
        addToScore(5);
      }else if(y>pY1 && y < pY2 && zielBlock){
        gameCompleted();
      }
    }
    return 0;  
  }
  
  int doesTouch(char pSide, float pX1,float pX2, float pY1, float pY2){
   if(solid){
     if(pSide == 'l'){
      if(y < pY2 && y+bSize-5 > pY1 && pX1 <= x+bSize){
        //print("X:" + x + " - " + "pX:" +pX1 + " || ");
        print("HITLinks");
        blob.getDamage(damage);
       return 3; 
        
      }
     }
     if(pSide == 'r'){
      if(y < pY2 && y+bSize-5 > pY1 && pX2 >= x){
        //print("X:" + x + " - " + "pX:" +pX1 + " || ");
        print("HITRechts");
        blob.getDamage(damage);
       return 4;
        
      }
     }
     
     return 0;
   }
   return 0;
    
  }
  

 
}
