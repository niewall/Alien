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

void setup(){
  size(1280,800,RENDER);
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



void draw(){
  //print(millis()-lastTime);
  delta = (millis() - lastTime)/100;
  lastTime = millis();
  //print(delta);
  
  if(delta > 0.13){
   delta = 0.13; 
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

void run(){
  background(98,198,223);
  displayBackground();
  pushMatrix();
  translate(verschiebungMapX, verschiebungMapY-playerOffsetY);
  //print("XMap:" + (verschiebungMapX) + " - " + "YMap:" + (verschiebungMapY-playerOffsetY) + "  ||  ");

  for(int i=0;i<=counterEnemys;i++){
    //println(counterEnemys);
    enemy[i].display();
  }
  for(int i = int(-verschiebungMapX/60); i< -verschiebungMapX/60+32;i++){  
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

void gameOver(){
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

void gameCompleted(){
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

void optionen(){
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



void displayBackground(){
  
  image(background,verschiebungMapX/10-50,verschiebungMapY/20-150);
  
}

void test(){

  
}
