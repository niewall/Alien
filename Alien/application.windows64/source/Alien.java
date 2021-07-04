import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Alien extends PApplet {

float lastTime = 0;
float lvlStartTime = 0;
float delta = 0;
Blocks[][] block;
Enemy[] enemy;
int counterEnemys = -1;
Player blob;
int screen = 0;
String currentLevel;
int currentLvlID;
boolean buttonPressed = true;

static final String RENDER = FX2D; //P3D oder JAVA2D FX2D

int playerOffsetY;
float verschiebungMapX = 0;
float verschiebungMapY = 0;

public void setup(){
  
  surface.setTitle("Alien Spiel SGS Ver: 0.6");
  surface.setResizable(false);
  frameRate(90);
  soundSetup();
  playerOffsetY = height/2+200;
  loadImages();
  loadProgress();
  sound(true);
  block = new Blocks[256][68];
  enemy = new Enemy[50];
  blob = new Player();
}



public void draw(){
  //print(millis()-lastTime);
  delta = (millis() - lastTime)/100;
  lastTime = millis();
  //print(delta);
  
  if(delta > 0.13f){
   delta = 0.13f; 
  }
  //println(delta);
  isKeyPressed();
  
  if(screen == 0){
   menu(); 
  }
  
  if(screen == 1){
  levelMenu();
  }
  if(screen == 3){
  optionen(); 
  }
  if(screen == 2){
  run(); 
  }
       
}

public void run(){
  background(98,198,223);
  displayBackground();
  pushMatrix();
  translate(verschiebungMapX, verschiebungMapY-playerOffsetY);
  //print("XMap:" + (verschiebungMapX) + " - " + "YMap:" + (verschiebungMapY-playerOffsetY) + "  ||  ");

  for(int i=0;i<=counterEnemys;i++){
    //println(counterEnemys);
    enemy[i].display();
  }
  for(int i = PApplet.parseInt(-verschiebungMapX/60); i< -verschiebungMapX/60+32;i++){  
    for(int ii = 0; ii<34;ii++){
    // Weniger Auslastung, wenn man nur den Bereich Rendert,
    // den man sieht. Z.B. nur Bereich von x1 zu x2. 
    // Rechnung i = (verschiebungX/60) ; i Obergrenze = (verschiebungX/60)+33
     block[i][ii].display();
    }
  }
  blob.display();
  
  //image(background,0,0);
  
  popMatrix();
  
  hud();
}

public void gameOver(){
  background(0);
  textSize(50);
  text("GAME OVER",width/2,height/10);
  score = 0;
  sound[5].play();
  blob.resetKoor();
  verschiebungMapX = 0;
  verschiebungMapY = 0;
  createBlocks(currentLevel);
  
}

public void gameCompleted(){
  if(currentLvlID >= 0){
    lvlData[currentLvlID].setScore(score);
    if(currentLvlID+1 <4){
    lvlData[currentLvlID+1].lvlUnlock();
    }
  }
  
  saveProgress();
  
  score = 0;
  blob.resetKoor();
  verschiebungMapX = 0;
  verschiebungMapY = 0;
  screen = 1;
}

public void optionen(){
  image(backgroundAudio,0,0,width,height);  
  if(vol > 0){
    image(audioImage,width/2-width/18,height/2-width/18, width/9,width/9);
      }else{
    image(audioImageOff,width/2-width/18,height/2-width/18, width/9,width/9);
   }
  imageMode(CENTER);
  fill(0);
  if(overRect(width/2-width/18,height/2-width/18, width/9,width/9) && mousePressed && buttonPressed == false){
    if(vol > 0){
        vol = 0;}else{
        vol = 1; 
      }
    buttonPressed = true;
  }
  
  if(buttonPressed && !mousePressed){
   buttonPressed= false;
  }

  
  for(int i = 0; i < 9; i++){
  sound[i].amp(vol);
  }
  imageMode(CORNER);
  backButton();
}



public void displayBackground(){
  
  image(background,verschiebungMapX/10-50,verschiebungMapY/20-150);
  
}

public void test(){

  
}
// Class for animating a sequence of GIFs

class Animation {
  PImage[] images;
  int imageCount;
  float frame;
  float speed;
  
  Animation(String imagePrefix,float pSpeed, int count) {
    imageCount = count;
    speed = pSpeed;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + str(i) + ".png";
      images[i] = loadImage(filename);
    }
  }

  public void display(float xpos, float ypos) {
    frame = (frame+0.1f) % imageCount;
    image(images[PApplet.parseInt(frame)], xpos, ypos);
  }
  
  public int getWidth() {
    return images[0].width;
  }
}
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
  
  public void display(){
    if(visible){
      image(blockIm[blockNr],x,y);
    }
  }
  
  public int doesCollide(float pX1,float pX2, float pY1, float pY2){
    if(solid){
      //print("Y:" + y + " - " + "pY2:" +pY2 + " || ");
      if(y+bSize+5 > pY1 && y < pY1){
        blob.getDamage(damage);
        //print("HIT TOP " + pY1);
        return 2;
      }
      if(y <= pY2 && y >= pY1){
        //print("XBlock:" + (x) + " - " + "YBlock:" + (y) + "  ||  ");
        blob.getDamage(damage);
        blob.setGround(PApplet.parseInt(y+2));
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
  
  public int doesTouch(char pSide, float pX1,float pX2, float pY1, float pY2, char entity){
   if(solid){
     if(pSide == 'l'){
      if(y < pY2 && y+bSize-5 > pY1 && pX1 <= x+bSize  && pX1 > x){
        //print("X:" + x + " - " + "pX:" +pX1 + " || ");
        //print("HITLinks");
        if(entity == 'p'){
          blob.getDamage(damage);
        }
       return 3; 
        
      }
     }
     if(pSide == 'r'){
      if(y < pY2 && y+bSize-5 > pY1 && pX2 >= x){
        //print("X:" + x + " - " + "pX:" +pX1 + " || ");
        //print("HITRechts");
        if(entity == 'p'){
          blob.getDamage(damage);
        }
       return 4;
        
      }
     }
     
     return 0;
   }
   return 0;
    
  }
  

 
}
PImage menuBack;

public void menu(){
  background(20);
  imageMode(CENTER); 
  menuBack = loadImage("menuBack.jpg");
  buttonPressed = true;
  image(menuBack, width/2, height/2, width, height);

  //fill(0, 0, 0, 100);
  //stroke(255, 255, 255);
  //rect(width/2-width/15, Math.round(height/2-height/6.55), width/8, Math.round(height/14.4));
  //rect(Math.round(width/2-width/9.48), height/2-height/24, Math.round(width/4.92), Math.round(height/14.4));
  //rect(Math.round(width/2-width/12.8), height/2+height/18 , Math.round(width/6.74), Math.round(height/14.4));
  //rect(Math.round(width/2-width/18.29), Math.round(height/2+height/6.26), Math.round(width/9.85), Math.round(height/14.4));

  if(overRect(width/2-width/15, Math.round(height/2-height/6.55f),width/8, Math.round(height/14.4f)) && mousePressed){ //Start
    sound[4].play();
    screen = 1;
  }
  if(overRect(Math.round(width/2-width/9.48f), height/2-height/24, Math.round(width/4.92f), Math.round(height/14.4f)) && mousePressed){ //Tutorial
    createBlocks("tutLVL");
    currentLvlID = -1;
    sound[4].play();
    screen = 2;
  }
  if(overRect(Math.round(width/2-width/12.8f), height/2+height/18 , Math.round(width/6.74f), Math.round(height/14.4f)) && mousePressed){ //Option
    sound[4].play();
    screen = 3;
  }
  if(overRect(Math.round(width/2-width/18.29f), Math.round(height/2+height/6.26f), Math.round(width/9.85f), Math.round(height/14.4f)) && mousePressed){ //Quit
    sound[4].play();
    System.exit(0);
  }
  imageMode(CORNER);

}
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
  
  float[] posOnMap = {width/2,height*1.2f};
  float[] refposOnMap = {width/2,height*1.2f};
  
  Player(){
    veloc = new PVector(0,0);
    
  }
  
  public void display(){
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
  
  public void update(){
    if(posOnMap[0] > width/2){  //Check for BorderLeft
    verschiebungMapX = refposOnMap[0]-posOnMap[0];}
    if(posOnMap[1] < 1550&& posOnMap[1] > 300){  // Check for BorderBottom
    verschiebungMapY = refposOnMap[1]-posOnMap[1];}
        
    if(verschiebungMapX >0){
      verschiebungMapX = 0;
      //print("MapX > 0");
    }
    if(verschiebungMapY >0){
      //verschiebungMapY = 0;
      //print("MapY > 0");
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
    
    veloc.x = veloc.x*0.92f;
    
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
  
  public void move(char pDirection){
    if(pDirection == 'l' && posOnMap[0] > 30 && stopMovement != 1){
      if(veloc.x >= -30 && veloc.x <= -0.01f){
        veloc.x = -laufgeschw - counterLaufen[0]/10;
        counterLaufen[0] += 0.5f+ counterLaufen[0]/100;
      }else if(veloc.x > -0.01f){
        counterLaufen[0] = 0;
        veloc.x = -laufgeschw;
      }else if(veloc.x < -30){
        veloc.x = -35;
        counterLaufen[0] = 0;
      }
    
  }
    if(pDirection == 'r' && stopMovement != 2){
     if(veloc.x <= 30 && veloc.x >= 0.01f){
        veloc.x = laufgeschw + counterLaufen[1]/10;
        counterLaufen[1] += 0.5f+ counterLaufen[1]/100;
      }else if(veloc.x < 0.01f){
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
  
  public int collisionY(){
    int result = 0;
    int px = PApplet.parseInt((posOnMap[0])/60+0.5f);
    for(int i = PApplet.parseInt(posOnMap[1]/60); i< PApplet.parseInt(posOnMap[1]/60)+3;i++){  //Fuer drunter oder drueber:
      
     result = block[px][i].doesCollide(posOnMap[0],posOnMap[0]+plWidth, posOnMap[1]+5, posOnMap[1]+plHeight);
     if(result >0){
       return result;
    }}

 
    return 0;
  }

  public int collisionX(){
    int result = 0;
    int pxR = PApplet.parseInt(posOnMap[0]/60+0.5f)+1;
    for(int i = PApplet.parseInt(posOnMap[1]/60)-1; i< PApplet.parseInt(posOnMap[1]/60)+2;i++){ //Fuer daneben rechts
      
     result = block[pxR][i].doesTouch('r',posOnMap[0],posOnMap[0]+plWidth, posOnMap[1], posOnMap[1]+plHeight, 'p');
     if(result >0){
       return result;
    }}
    int pxL = PApplet.parseInt(posOnMap[0]/60+0.5f)-1;
    for(int i = PApplet.parseInt(posOnMap[1]/60); i< PApplet.parseInt(posOnMap[1]/60)+2;i++){ //Fuer daneben links
      
     result = block[pxL][i].doesTouch('l',posOnMap[0],posOnMap[0]+plWidth, posOnMap[1]+5, posOnMap[1]+plHeight, 'p');
     if(result >0){
       return result;
    }}
    return 0;
  }

  public float getX(){
    
   return posOnMap[0]; 
  }
  
  public float getY(){
    
    return posOnMap[1];
  }
  
  public void setY(int pY){
    
  }
  
  public void getDamage(int pDamage){
    if(pDamage > 0){
      sound[1].play();
      health -= pDamage; 
      println("Damage: " + pDamage + " || Xplayer: " + posOnMap[0]);
    }
  }
  
  public void attack(){
   
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
  
  public void resetKoor(){
  posOnMap[0] = width/2;
  posOnMap[1] = height*1.2f;
  
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
  
  public void setGround(int pGroundY){
    posOnMap[1] =pGroundY-plHeight;
  }
}

class Bullet{
  
  
  Bullet(){
    
    
  }
  
  
}
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
    enemyAn = new Animation("gegner/Gegner-",0.05f,11);
    imageEnemy = loadImage(pImage);
  }
  
  public void display(){
    
    if(health > 0){
    if(counter > 0){
      counter--;}
    move();
    hit();
    enemyAn.display(x,y);
    }
  }
  
  public void move(){
    
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
  
  public void hit(){
    float playerX = blob.getX();
    float playerY = blob.getY();
    
    if(playerX > x-eSize && playerX < x+eSize && playerY+120 > y && playerY < y && counter <= 0){
        blob.getDamage(damage);
        counter = 100;
    }
    
  }
  
  public int collisionX(){
    
    int result = 0;
    int py = PApplet.parseInt(y/60);

    if(x<10){return 3;}
    
    int pxR = PApplet.parseInt(x/60+0.5f)+1;    
      
     result = block[pxR][py].doesTouch('r',x,x+eSize, y, y+eSize, 'e');
     if(result >0){
       return result;
    }
    
    int pxL = PApplet.parseInt(x/60+0.5f)-1; 
    
    if(pxL > 0){
     result = block[pxL][py].doesTouch('l',x,x+eSize, y, y+eSize, 'e');
     if(result >0){
       return result;
    }}
    return 0;
  }
  
  public void getDamage(int pDamage){
    if(health >= 0){
      sound[7].play();
      health -= pDamage;
      if(health <= 0){
        addToScore(5);
      }
    }
  }
  
  public float getX(){
   return x; 
  }
  
  public float getY(){
    return y;
  }
  
  
}
int score = 0;
  

public void hud(){
  
  textSize(16);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  fill(20,20,20,120);
  rect(width-30, 32,50,20);
  fill(255,255,255);
  text(score, width-30, 30);
  
  textSize(32);
  fill(20,20,20,120);
  rect( width-140, height-55,200,40);
  fill(255,255,255);
  text("Health: " + blob.health, width-140, height-60);
  
  backButton();
}

public void addToScore(int pAdd){
  sound[8].play();
  score = score + pAdd;   

}

public void backButton(){
   image(arrow,Math.round(width/2-width/2.01f), Math.round(height/2-height/2.01f), Math.round(width/15), Math.round(width/30));
   if(overRect(Math.round(width/2-width/2.01f), Math.round(height/2-height/2.01f), Math.round(width/15), Math.round(width/30)) && mousePressed){ //Quit
    screen = 0;
    score = 0;
    blob.resetKoor();
    verschiebungMapX = 0;
    verschiebungMapY = 0;
  } 
  
}
PImage[] blockIm = new PImage[255];
int blockAmount = 50;

public void loadImages(){
  
  blockData = loadJSONArray("blocks.json");

  for (int i = 0; i < blockData.size(); i++) {
    
    JSONObject block = blockData.getJSONObject(i); 

    int id = block.getInt("id");
    String image = block.getString("image");
    blockIm[i] = loadImage(image);

    println(id + ", " + image);
  }
  
  for(int i = blockAmount; i<blockIm.length;i++){
    blockIm[i] = loadImage("blank.png");
  }
  
  loadRest();
}
public void isKeyPressed() {
    if (moveKeys[0]) {
      blob.move('j');
    }
    if (moveKeys[2]){
      screen = 1;
      //surface.setSize(100,1020);
    }
    if (moveKeys[3]){
      blob.move('r');
    }
    if ((moveKeys[1])){
      blob.move('l');
    }
    if ((moveKeys[4])){
      blob.attack();
    }


}

boolean[] moveKeys = new boolean[5];


public void setMovement(int k, boolean b) {
  if(RENDER.equals(FX2D)){
  switch (k) {
  case 'W':
    moveKeys[0] = b;
    break;
  case 'A':
    moveKeys[1] = b;
    break;
  case 'S':
    //moveKeys[2] = b;
    break;
  case 'D':
    moveKeys[3] = b;
    break;
  case' ':
    moveKeys[4] = b;
    break;
  }
}else{
    switch (k) {
  case 'w':
    moveKeys[0] = b;
    break;
  case 'a':
    moveKeys[1] = b;
    break;
  case 's':
    //moveKeys[2] = b;
    break;
  case 'd':
    moveKeys[3] = b;
    break;
  }
  
  
}
}

public void keyPressed() {
  setMovement(key, true);
}

public void keyReleased() {
  setMovement(key, false);
}
public void levelMenu(){
  
  background(20);
  textAlign(CENTER);
  textSize(50);
  text("LEVEL",width/2,height/10);
  rectMode(CORNER);
  
  //level
  fill(255);
  if(!lvlData[0].getUnlockStatus()){fill(150);}
  image(lvlPic[0],width/9*1,height/3, width/9,height/3);
  noTint();
  text(lvlData[0].getScore(),width/9+(width/9/2),height/3+height/3+50);
  if(overRect(width/9*1,height/3, width/9,height/3) && mousePressed && lvlData[0].getUnlockStatus()== true){
    createBlocks("level1");
    currentLvlID = 0;
    sound[4].play();
    screen = 2;
  }
  fill(255);
  if(!lvlData[1].getUnlockStatus()){tint(150);}
  image(lvlPic[1],width/9*3,height/3, width/9,height/3);
  noTint();
  text(lvlData[1].getScore(),width/9*3+(width/9/2),height/3+height/3+50);
  if(overRect(width/9*3,height/3, width/9,height/3) && mousePressed && lvlData[1].getUnlockStatus()== true){
    createBlocks("level2");
    currentLvlID = 1;
    sound[4].play();
    screen = 2;
  }
  fill(255);
  if(!lvlData[2].getUnlockStatus()){tint(150);}
  image(lvlPic[2],width/9*5,height/3, width/9,height/3);
  noTint();
  text(lvlData[2].getScore(),width/9*5+(width/9/2),height/3+height/3+50);
  if(overRect(width/9*5,height/3, width/9,height/3) && mousePressed && lvlData[2].getUnlockStatus()== true){
    createBlocks("level3");
    currentLvlID = 2;
    sound[4].play();
    screen = 2;
  }
  fill(255);
  if(!lvlData[3].getUnlockStatus()){tint(150);}
  image(lvlPic[2],width/9*7,height/3, width/9,height/3);
  noTint();
  text(lvlData[3].getScore(),width/9*7+(width/9/2),height/3+height/3+50);
  if(overRect(width/9*7,height/3, width/9,height/3) && mousePressed && lvlData[3].getUnlockStatus()== true){
    createBlocks("level4");
    currentLvlID = 3;
    sound[4].play();
    screen = 2;
  }
  backButton();

}

public boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
  
class LvlData{
  int id;
  boolean unlocked;
  int lvlscore;
  boolean[] archivments = new boolean[3];
  
 
  LvlData(int pID, boolean pUnlocked, int pScore, boolean[] pArchivments){
    id = pID;
    unlocked = pUnlocked;
    lvlscore = pScore;
    archivments = pArchivments;
  }
  
  public boolean getUnlockStatus(){
    
   return unlocked; 
  }
  
  public int getScore(){
    
   return lvlscore; 
  }
  
  public void setScore(int pScore){
   if(pScore > lvlscore){
    lvlscore = pScore; 
   }
  }
  
  public void lvlUnlock(){
   unlocked = true; 
  }
}
PImage[] player = new PImage[4];
PImage[] lvlPic = new PImage[3];
PImage background;PImage backgroundAudio;
PImage audioImage;PImage audioImageOff;
PImage arrow;
JSONArray blockData;
JSONArray progressData;
JSONArray pArray;
LvlData[] lvlData = new LvlData[4];


public void loadRest(){
  background = loadImage("background.png");
  backgroundAudio = loadImage("backgroundOption.png");
  audioImage = loadImage("audio.png");
  audioImageOff = loadImage("audioOFF.png");
  arrow = loadImage("arrow.png");

  //background.resize(15360, 0);
  player[0] = loadImage("man.png");
  player[1] = loadImage("manl.png");
  player[2] = loadImage("manFightRight.png");
  player[3] = loadImage("manFightLeft.png");
  
  lvlPic[0] = loadImage("LVL1.png");
  lvlPic[1] = loadImage("LVL2.png");
  lvlPic[2] = loadImage("LVLErr.png");
  
}

public void createBlocks(String world){
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

public void loadProgress(){
  progressData = loadJSONArray("progress.json");
  
  for(int i = 0; i<4;i++){

    JSONObject lvlValues = progressData.getJSONObject(i);
        
    boolean unlocked = lvlValues.getBoolean("unlocked");
    int pScore = lvlValues.getInt("score");
    boolean[] archivments = {lvlValues.getBoolean("archivment1"),lvlValues.getBoolean("archivment2"),lvlValues.getBoolean("archivment3")};
    lvlData[i] = new LvlData(i,unlocked,pScore,archivments);
  }
}

public void saveProgress(){

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

public int bytesToInt(byte[] pData){
  int blNr = 0;
  String st1 = Integer.toString(PApplet.parseInt(pData[0]), 2);
  String st2 = Integer.toString(PApplet.parseInt(pData[1]), 2);
  blNr = Integer.parseInt(st2+st1,2);
  
  return blNr;
}

boolean soundPlaying = false;
SoundFile[] sound = new SoundFile[10];
float vol = 1;


public void soundSetup(){
  sound[0] = new SoundFile(this, "titel.wav");
  sound[1] = new SoundFile(this, "hit.mp3");
  sound[2] = new SoundFile(this, "jump.wav");
  sound[3] = new SoundFile(this, "jump2.wav");
  sound[4] = new SoundFile(this, "click.wav");
  sound[5] = new SoundFile(this, "gameover.wav");
  sound[6] = new SoundFile(this, "sword.wav");
  sound[7] = new SoundFile(this, "sword.wav");
  sound[8] = new SoundFile(this, "coin.wav");


}

public void sound(boolean switchS) {
  
  soundPlaying = switchS;
  if (soundPlaying) {
    // Load a soundfile from the /data folder of the sketch and play it back
    sound[0].loop();
  } else {

    sound[0].loop();
  }
}
  public void settings() {  size(1280,800,RENDER); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Alien" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
