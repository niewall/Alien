int score = 0;
  

void hud(){
  
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

}

void addToScore(int pAdd){
    score = score + pAdd;   

}
