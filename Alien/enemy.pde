class Enemy{
  
  float x;
  float y;
  int damage;
  int health = 100;
  int eSize = 60;
  float speed = 10;
  int direction = 1;
  PImage imageEnemy;
  
  Enemy(int pX, int pY, int pDamage, String pImage){
    x = pX*eSize;
    y = pY*eSize;
    damage = pDamage;
    imageEnemy = loadImage(pImage);
  }
  
  void display(){
    
    if(health > 0){
    move();
    hit();
    image(imageEnemy,x,y);
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
    println(pCollition);
    println(x);

  }
  
  void hit(){
    float playerX = blob.getX();
    float playerY = blob.getY();
    
    if(playerX > x-eSize && playerX < x+eSize && playerY+120 > y && playerY < y){
        blob.getDamage(damage);
    }
    
  }
  
  int collisionX(){
    int result = 0;

    for(int i = (int(x+eSize*1.5)/60)*34; i< (int(x+eSize*2.5)/60)*34;i++){ //Fuer daneben rechts
      
     result = block[i].doesTouch('r',x,x+eSize, y, y+eSize);
     if(result >0){
       return result;
    }}
    
    for(int i = (int(x-eSize/2)/60)*34; i< (int(x+eSize/2)/60)*34;i++){ //Fuer daneben links
      
     result = block[i].doesTouch('l',x,x+eSize, y, y+eSize);
     if(result >0){
       return result;
    }}
    return 0;
  }
  
  void getDamage(int pDamage){
    health -= pDamage;
  }
  
  float getX(){
   return x; 
  }
  
  float getY(){
    return y;
  }
  
  
}
