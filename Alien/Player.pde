class Player{
  
  int plWidth = 60;
  int plHeight = 100;
  int orientation = 0;
  float gravity = 0.1;
  boolean jump = true;
  PVector pos, veloc;
  int collitionStatusY = 0;
  int collitionStatusX = 0;
  boolean onGround = false;
  int stopMovement = 0;
  
  int playerPosRealX = width/2;
  int playerPosRealY = height/2 +510;
  
  Player(){
    pos = new PVector(0,0);
    veloc = new PVector(0,0);
    
  }
  
  void display(){
    update();
    image(player[orientation],playerPosRealX+ pos.x, height/2 +playerOffsetY + pos.y);
    
  }
  
  void update(){
    
    pos.x += veloc.x;
    pos.y += veloc.y;  
    
    positionX = int(pos.x);
    positionY = int(pos.y);
      
      
    collitionStatusY = collisionY();
    collitionStatusX = collisionX();
    onGround = false;
    stopMovement = 0;
    if(collitionStatusY == 1){
        veloc.y = 0;
        onGround = true;
    }else if(collitionStatusY == 2){
        veloc.y = 2;
    }else{
      stopMovement = 0;
      veloc.y += gravity;
    }
    
    if(collitionStatusX == 3){
        veloc.x = 0;
        stopMovement = 1;
    }else if(collitionStatusX == 4){
        veloc.x = 0;
        stopMovement = 2;
    }
    
    veloc.x = veloc.x*0.92;
    print("X:" + pos.x + " - " + "Y:" + pos.y);
  }
  
  void move(char pDirection){
    if(pDirection == 'l'){
      if(pos.x > 5 && stopMovement != 1){
      veloc.x = -2;
      }else{
        
      }
    }
    if(pDirection == 'r' && stopMovement != 2){
      veloc.x = +2;}
    if(pDirection == 'j' && onGround == true){
      veloc.y = -6;}
    
  }
  
  int collisionY(){
    int result = 0;
    for(int i = ((int((pos.x+plWidth/2)/60))+16)*34; i< (((pos.x+plWidth/2)/60) + 17)*34;i++){  //Fuer drunter oder drueber:
      
     result = block[i].doesCollide(pos.x,pos.x+plWidth, pos.y+playerOffsetY+510, pos.y+plHeight+playerOffsetY+510);
     if(result >0){
       return result;
    }}
 
    return 0;
  }

  int collisionX(){
    int result = 0;

    for(int i = ((int((pos.x+plWidth/2)/60))+15)*34; i< (((pos.x+plWidth/2)/60) + 16)*34;i++){ //Fuer daneben rechts
      
     result = block[i].doesTouch('l',pos.x+playerPosRealX,pos.x+playerPosRealX+plWidth, pos.y+playerOffsetY+510, pos.y+plHeight+playerOffsetY+510);
     if(result >0){
       return result;
    }}
    
    for(int i = ((int((pos.x+plWidth/2)/60))+17)*34; i< (((pos.x+plWidth/2)/60) + 18)*34;i++){ //Fuer daneben links
      
     result = block[i].doesTouch('r',pos.x+playerPosRealX,pos.x+playerPosRealX+plWidth, pos.y+playerOffsetY+510, pos.y+plHeight+playerOffsetY+510);
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
