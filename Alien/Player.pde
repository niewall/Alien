class Player{
  
  int plWidth = 60;
  int plHeight = 100;
  int orientation = 0;
  float gravity = 0.15;
  boolean jump = true;
  PVector pos, veloc;
  int collitionStatusY = 0;
  int collitionStatusX = 0;
  boolean onGround = false;
  int stopMovement = 0;
  
  float[] posOnMap = {width/2,height*1.2};
  float[] refposOnMap = {width/2,height*1.2};
  
  Player(){
    veloc = new PVector(0,0);
    
  }
  
  void display(){
    update();
    image(player[orientation],posOnMap[0], posOnMap[1]);
    
  }
  
  void update(){
    if(posOnMap[0] > width/2+100){  //Check for BorderLeft
    verschiebungMapX = refposOnMap[0]-posOnMap[0];}
    if(posOnMap[1] < 1500){  // Check for BorderBottom
    verschiebungMapY = refposOnMap[1]-posOnMap[1];}
    
    posOnMap[0] += veloc.x;
    posOnMap[1] += veloc.y;
      
    collitionStatusY = collisionY();
    collitionStatusX = collisionX();
    onGround = false;
    stopMovement = 0;
    
    //Y-Direction
    if(collitionStatusY == 1){  //Hit Ground
        veloc.y = 0;
        onGround = true;
    }else if(collitionStatusY == 2){ //Hit Celling
        veloc.y = 2;
    }else{
      stopMovement = 0;
      veloc.y += gravity;
    }
    
    if(collitionStatusX == 3){  //Hit Left
        veloc.x = 0;
        stopMovement = 1;
    }else if(collitionStatusX == 4){ //Hit Right
        veloc.x = 0;
        stopMovement = 2;
    }
    
    veloc.x = veloc.x*0.92;
    println("X:" + (posOnMap[0]) + " - " + "Y:" + (posOnMap[1]));
    //println("||  verX:" + (verschiebungMapX) + " - " + "verY:" + (verschiebungMapY));
  }
  
  void move(char pDirection){
    if(pDirection == 'l' && posOnMap[0] > 30){
      if(stopMovement != 1){
      veloc.x = -4;
      }else{
        
      }
    }
    if(pDirection == 'r' && stopMovement != 2){
      veloc.x = +4;}
    if(pDirection == 'j' && onGround == true){
      veloc.y = -7.5;}
    
  }
  
  int collisionY(){
    int result = 0;
    for(int i = (int(posOnMap[0]+plWidth/2)/60)*34; i< (int(posOnMap[0]+plWidth*1.5)/60)*34;i++){  //Fuer drunter oder drueber:
      
     result = block[i].doesCollide(posOnMap[0],posOnMap[0]+plWidth, posOnMap[1], posOnMap[1]+plHeight);
     if(result >0){
       return result;
    }}
 
    return 0;
  }

  int collisionX(){
    int result = 0;

    for(int i = (int(posOnMap[0]+plWidth*1.5)/60)*34; i< (int(posOnMap[0]+plWidth*2.5)/60)*34;i++){ //Fuer daneben rechts
      
     result = block[i].doesTouch('r',posOnMap[0],posOnMap[0]+plWidth, posOnMap[1], posOnMap[1]+plHeight);
     if(result >0){
       return result;
    }}
    
    for(int i = (int(posOnMap[0]-plWidth/2)/60)*34; i< (int(posOnMap[0]+plWidth/2)/60)*34;i++){ //Fuer daneben links
      
     result = block[i].doesTouch('l',posOnMap[0],posOnMap[0]+plWidth, posOnMap[1], posOnMap[1]+plHeight);
     if(result >0){
       return result;
    }}
    return 0;
  }

  float getX(){
    
   return posOnMap[0]; 
  }
  
  float getY(){
    
    return posOnMap[1];
  }
  
  void setY(int pY){
    
  }

}
