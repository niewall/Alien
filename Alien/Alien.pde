long lastTime = 0;
long delta = 0;
Blocks[] block;
Player blob;

int screen = 0;

static final String RENDER = FX2D; //P3D oder JAVA2D FX2D

int playerOffsetY;
float verschiebungMapX = 0;
float verschiebungMapY = 0;

void setup(){
  size(1280,720,RENDER);
  frameRate(90);
  surface.setResizable(true);
  playerOffsetY = height/2+200;
  loadImages();
  block = new Blocks[8704];
  blob = new Player();
}



void draw(){
  //print(millis()-lastTime);
  lastTime = millis();
  //println(frameRate);
  isKeyPressed();
  
  if(screen == 0){
   menu(); 
  }
  
  if(screen == 1){
  levelMenu();
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
  print("XMap:" + (verschiebungMapX) + " - " + "YMap:" + (verschiebungMapY-playerOffsetY) + "  ||  ");


  blob.display();
  for(int i = (int(-verschiebungMapX/60))*34; i< ((-verschiebungMapX/60) + 33)*34;i++){  
    // Weniger Auslastung, wenn man nur den Bereich Rendert,
    // den man sieht. Z.B. nur Bereich von x1 zu x2. 
    // Rechnung i = (verschiebungX/60) ; i Obergrenze = (verschiebungX/60)+33
   block[i].display();
  }
  
  //image(background,0,0);
  
  popMatrix();
}

void displayBackground(){
  
  image(background,verschiebungMapX/10-50,verschiebungMapY/20-150);
  
}

void test(){

  
}
