class Blocks{
  
  int bSize = 60;
  int kind;
  int x;
  int y;
  
  Blocks(int bKind,int pX, int pY){
   kind = bKind;
   x = pX*bSize;
   y = pY*bSize;
   
   
   
  }
  
  void display(){
    
    image(blockIm[kind],x,y);
  
  }
  
  int doesCollide(float pX1,float pX2, float pY1, float pY2){
    if(kind > 1){
      print("Y:" + y + " - " + "pY:" +pY1 + " || ");
      if(y+bSize >= pY1 && y < pY1){
        print("HEEE");
        return 2;
      }
      if(y <= pY2 && y >= pY1-50){
        return 1;
      }
    }
    return 0;
  }
  
  int getY(){
    return y;
  }
 
}
