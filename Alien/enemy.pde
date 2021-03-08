class Enemy{
  
  float x;
  float y;
  int damage;
  int health = 100;
  int eSize = 60;
  float speed = 10;
  int direction = 1;
  PImage imageEnemy;
  Animation enemyAn;
  int counter = 0;
  
  Enemy(int pX, int pY, int pDamage, String pImage){
    x = pX*eSize;
    y = pY*eSize;
    damage = pDamage;
    enemyAn = new Animation("gegner/Gegner-",0.05,11);
    imageEnemy = loadImage(pImage);
  }
  
  void display(){
    
    if(health > 0){
    if(counter > 0){
      counter--;}
    move();
    hit();
    enemyAn.display(x,y);
    }
  }
  
  void move(){
    
    int pCollition = collisionX();
    if(pCollition == 3){
      direction = 0;
    }else if(pCollition == 4){
      direction = 1;
    }
    
    if(direction == 0){
     x += speed*delta; 
    }else if(direction == 1){
     x -= speed*delta; 
    }
    //println(pCollition);
    //println(x);

  }
  
  void hit(){
    float playerX = blob.getX();
    float playerY = blob.getY();
    
    if(playerX > x-eSize && playerX < x+eSize && playerY+120 > y && playerY < y && counter <= 0){
        blob.getDamage(damage);
        counter = 100;
    }
    
  }
  
  int collisionX(){
    
    int result = 0;
    int py = int(y/60);

    if(x<10){return 3;}
    
    int pxR = int(x/60+0.5)+1;    
      
     result = block[pxR][py].doesTouch('r',x,x+eSize, y, y+eSize);
     if(result >0){
       return result;
    }
    
    int pxL = int(x/60+0.5)-1; 
    
     result = block[pxL][py].doesTouch('l',x,x+eSize, y, y+eSize);
     if(result >0){
       return result;
    }
    return 0;
  }
  
  void getDamage(int pDamage){
    if(health >= 0){
    sound[7].play();
    health -= pDamage;}
  }
  
  float getX(){
   return x; 
  }
  
  float getY(){
    return y;
  }
  
  
}
