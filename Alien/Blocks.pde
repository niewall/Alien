class Blocks{
  
  int bSize = 60;
  boolean solid;
  int blockNr;
  int x;
  int y;
  
  Blocks(int pX, int pY,int pBlockNr,boolean pSolid){
   solid = pSolid;
   blockNr = pBlockNr;
   x = pX*bSize;
   y = pY*bSize;
   
  }
  
  void display(){
    
    image(blockIm[blockNr],x,y);
  
  }
  
  int doesCollide(float pX1,float pX2, float pY1, float pY2){
    if(solid){
      //print("Y:" + y + " - " + "pY2:" +pY2 + " || ");
      if(y+bSize >= pY1 && y < pY1){
        //print("HEEE");
        return 2;
      }
      if(y <= pY2 && y >= pY1){
        //print("XBlock:" + (x) + " - " + "YBlock:" + (y) + "  ||  ");
        return 1;
      }
    }
    return 0;  
  }
  
  int doesTouch(char pSide, float pX1,float pX2, float pY1, float pY2){
   if(solid){
     if(pSide == 'l'){
      if(y <= pY2-10 && y >= pY1 && pX1 <= x+bSize){
        //print("X:" + x + " - " + "pX:" +pX1 + " || ");
        print("HITLinks");
       return 3; 
        
      }
     }
     if(pSide == 'r'){
      if(y <= pY2-10 && y >= pY1 && pX1+60 >= x){
        //print("X:" + x + " - " + "pX:" +pX1 + " || ");
        print("HITRechts");
       return 4; 
        
      }
     }
     
     return 0;
   }
   return 0;
    
  }
  

 
}
