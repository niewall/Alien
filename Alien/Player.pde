class Player{
  
  int plWidth = 60;
  int plHeight = 100;
  int orientation = 0;
  float gravity = 0.1;
  boolean jump = true;
  PVector pos, veloc;
  int collitionStatus = 0;
  boolean onGround = false;
  
  int playerPosRealX = width/2;
  int playerPosRealY = height/2 +1020;
  
  Player(){
    pos = new PVector(0,0);
    veloc = new PVector(0,0);
    
  }
  
  void display(){
    update();
    image(player[orientation],playerPosRealX+ pos.x, height/2 +1020 + pos.y);
    
  }
  
  void update(){
    
    pos.x += veloc.x;
    pos.y += veloc.y;  
    
    positionX = int(pos.x);
    positionY = int(pos.y);
      
      
    collitionStatus = collition();
    onGround = false;
    if(collitionStatus == 1){
        veloc.y = 0;
        onGround = true;
    }else if(collitionStatus == 2){
        veloc.y = 2;
    }else{
      veloc.y += gravity;
    }
    
    veloc.x = veloc.x*0.92;
    print("X:" + pos.x + " - " + "Y:" + pos.y);
  }
  
  void move(char pDirection){
    if(pDirection == 'l'){
      if(pos.x > 5){
      veloc.x = -2;
      }else{
        
      }
    }
    if(pDirection == 'r'){
      veloc.x = +2;}
    if(pDirection == 'j' && onGround == true){
      veloc.y = -6;}
    
  }
  
  int collition(){
    int result = 0;
    for(int i = ((int((pos.x+plWidth/2)/60))+16)*34; i< (((pos.x+plWidth/2)/60) + 17)*34;i++){  
      
     result = block[i].doesCollide(pos.x,pos.x+plWidth, pos.y+1020+510, pos.y+plHeight+1020+510);
     if(result >0){
       return result;
    }}
    return 0;
  }

  float getX(){
    
   return pos.x; 
  }
  
  float getY(){
    
    return pos.y;
  }

}
