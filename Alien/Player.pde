

class Player{
  
  int plWidth = 60;
  int plHeight = 100;
  int orientation = 0;
  float gravity = 10;
  float sprungkraft = 50;
  float laufgeschw = 20;
  float laufboost = 10;
  float[] counterLaufen = {0,0};
  int hitCooldown = 0;
  boolean jump = true;
  PVector pos, veloc;
  int collitionStatusY = 0;
  int collitionStatusX = 0;
  boolean onGround = false;
  int stopMovement = 0;
  int health = 100;
  int damage = 30;
  
  float[] posOnMap = {width/2,height*1.2};
  float[] refposOnMap = {width/2,height*1.2};
  
  Player(){
    veloc = new PVector(0,0);
    
  }
  
  void display(){
    update();
    rectMode(CORNER);
    //rect(posOnMap[0], posOnMap[1]+5,plWidth, plHeight);
    
    if(veloc.x > 0 && hitCooldown <= 0){orientation = 0;}else if(veloc.x < 0 && hitCooldown <= 0){orientation = 1;}
    
    if(orientation != 3){
      image(player[orientation],posOnMap[0], posOnMap[1]);
    }else{
      image(player[orientation],posOnMap[0]-40, posOnMap[1]);
    }
    fill(255);
    
  }
  
  void update(){
    if(posOnMap[0] > width/2){  //Check for BorderLeft
    verschiebungMapX = refposOnMap[0]-posOnMap[0];}
    if(posOnMap[1] < 1550&& posOnMap[1] > 300){  // Check for BorderBottom
    verschiebungMapY = refposOnMap[1]-posOnMap[1];}
        
    if(verschiebungMapX >0){
      verschiebungMapX = 0;
      print("MapX > 0");
    }
    if(verschiebungMapY >0){
      //verschiebungMapY = 0;
      print("MapY > 0");
    }
    
    posOnMap[0] += veloc.x *delta;
    posOnMap[1] += veloc.y *delta;
      
    collitionStatusY = collisionY();
    collitionStatusX = collisionX();
    onGround = false;
    stopMovement = 0;
    
    //Y-Direction
    if(collitionStatusY == 1){  //Hit Ground
        veloc.y = 0;
        onGround = true;
    }else if(collitionStatusY == 2){ //Hit Celling
        veloc.y = 4;
    }else{
      stopMovement = 0;
      veloc.y += gravity*delta;
    }
    
    if(collitionStatusX == 3){  //Hit Left
        veloc.x = 0;
        stopMovement = 1;
    }else if(collitionStatusX == 4){ //Hit Right
        veloc.x = 0;
        stopMovement = 2;
    }
    
    veloc.x = veloc.x*0.92;
    
    if(hitCooldown>0){hitCooldown--;}
    
    if(health <= 0 || posOnMap[1] > 2000){
     gameOver(); 
    }
    
    if(posOnMap[1] > 1900){
     gameOver(); 
    }
    if(posOnMap[1] < 100){
    veloc.y = 5;
    }
    if(posOnMap[0] < 41){
     posOnMap[0] = 41;
    }
    if((lastTime-lvlStartTime) > 5000){
      score = score - 1;
      lvlStartTime = lastTime;
    }
    
    //println("X:" + (posOnMap[0]) + " - " + "Y:" + (posOnMap[1]));
    //println("||  verX:" + (verschiebungMapX) + " - " + "verY:" + (verschiebungMapY));
    //println(veloc.x);
    //println(counterLaufen[0]);
  }
  
  void move(char pDirection){
    if(pDirection == 'l' && posOnMap[0] > 30 && stopMovement != 1){
      if(veloc.x >= -30 && veloc.x <= -0.01){
        veloc.x = -laufgeschw - counterLaufen[0]/10;
        counterLaufen[0] += 0.5+ counterLaufen[0]/100;
      }else if(veloc.x > -0.01){
        counterLaufen[0] = 0;
        veloc.x = -laufgeschw;
      }else if(veloc.x < -30){
        veloc.x = -35;
        counterLaufen[0] = 0;
      }
    
  }
    if(pDirection == 'r' && stopMovement != 2){
     if(veloc.x <= 30 && veloc.x >= 0.01){
        veloc.x = laufgeschw + counterLaufen[1]/10;
        counterLaufen[1] += 0.5+ counterLaufen[1]/100;
      }else if(veloc.x < 0.01){
        counterLaufen[1] = 0;
        veloc.x = laufgeschw;
      }else if(veloc.x > 30){
        veloc.x = 35;
        counterLaufen[1] = 0;
      }
    
  }
      
    if(pDirection == 'j' && onGround == true){
      sound[3].play();
      veloc.y = -sprungkraft;}
    
  }
  
  int collisionY(){
    int result = 0;
    int px = int((posOnMap[0])/60+0.5);
    for(int i = int(posOnMap[1]/60); i< int(posOnMap[1]/60)+3;i++){  //Fuer drunter oder drueber:
      
     result = block[px][i].doesCollide(posOnMap[0],posOnMap[0]+plWidth, posOnMap[1]+5, posOnMap[1]+plHeight);
     if(result >0){
       return result;
    }}

 
    return 0;
  }

  int collisionX(){
    int result = 0;
    int pxR = int(posOnMap[0]/60+0.5)+1;
    for(int i = int(posOnMap[1]/60)-1; i< int(posOnMap[1]/60)+2;i++){ //Fuer daneben rechts
      
     result = block[pxR][i].doesTouch('r',posOnMap[0],posOnMap[0]+plWidth, posOnMap[1], posOnMap[1]+plHeight);
     if(result >0){
       return result;
    }}
    int pxL = int(posOnMap[0]/60+0.5)-1;
    for(int i = int(posOnMap[1]/60); i< int(posOnMap[1]/60)+2;i++){ //Fuer daneben links
      
     result = block[pxL][i].doesTouch('l',posOnMap[0],posOnMap[0]+plWidth, posOnMap[1]+5, posOnMap[1]+plHeight);
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
  
  void getDamage(int pDamage){
    if(pDamage > 0){sound[1].play();}
    health -= pDamage; 
  }
  
  void attack(){
   
   if(veloc.x > 0){
    orientation = 2;
    hitCooldown = 25;
    for(int i = 0; i<=counterEnemys;i++){
     float pX = enemy[i].getX();
     float pY = enemy[i].getY();
      if(pX > posOnMap[0] &&  pX < posOnMap[0]+150 && pY > posOnMap[1] && pY < posOnMap[1]+plHeight){
         enemy[i].getDamage(damage);
      }
    }
     
   }else if(veloc.x < 0){
    orientation = 3;
    hitCooldown = 25;
    for(int i = 0; i<=counterEnemys;i++){
     float pX = enemy[i].getX();
     float pY = enemy[i].getY();
      if(pX < posOnMap[0] &&  pX > posOnMap[0]-150 && pY > posOnMap[1] && pY < posOnMap[1]+plHeight){
         enemy[i].getDamage(damage);
      }
    }
     
   }
   
  }
  
  void resetKoor(){
  posOnMap[0] = width/2;
  posOnMap[1] = height*1.2;
  
  orientation = 0;
  float gravity = 10;
  counterLaufen[0] = 0;
  counterLaufen[1] = 0;
  hitCooldown = 0;
  jump = true;
  collitionStatusY = 0;
  collitionStatusX = 0;
  onGround = false;
  stopMovement = 0;
  health = 100;
  }
  
  void setGround(int pGroundY){
    posOnMap[1] =pGroundY-plHeight;
  }
}
