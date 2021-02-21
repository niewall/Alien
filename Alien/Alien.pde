long lastTime = 0;
long delta = 0;
Blocks[] block;
Player blob;

int playerOffsetY = 1020;
int positionX = 0;
int positionY = 0;

void setup(){
  size(1920,1020);
  frameRate(120);
  loadImages();
  block = new Blocks[8704];
  blob = new Player();
  createBlocks("level3");
}



void draw(){
  //print(millis()-lastTime);
  lastTime = millis();
  isKeyPressed();
  run(); 
  
       
}

void run(){
  println(delta);
  background(98,198,223);
  pushMatrix();
  
  translate(0-positionX, -playerOffsetY-positionY);
  
  for(int i = (int(positionX/60))*34; i< ((positionX/60) + 33)*34;i++){  
    // Weniger Auslastung, wenn man nur den Bereich Rendert,
    // den man sieht. Z.B. nur Bereich von x1 zu x2. 
    // Rechnung i = (verschiebungX/60) ; i Obergrenze = (verschiebungX/60)+33
   block[i].display();
  }
  
  //image(background,0,0);
  
  blob.display();
  
  popMatrix();
}

void test(){

  
}
