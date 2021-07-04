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
  
  backButton();
}

void addToScore(int pAdd){
  sound[8].play();
  score = score + pAdd;   

}

void backButton(){
   image(arrow,Math.round(width/2-width/2.01), Math.round(height/2-height/2.01), Math.round(width/15), Math.round(width/30));
   if(overRect(Math.round(width/2-width/2.01), Math.round(height/2-height/2.01), Math.round(width/15), Math.round(width/30)) && mousePressed){ //Quit
    screen = 0;
    score = 0;
    blob.resetKoor();
    verschiebungMapX = 0;
    verschiebungMapY = 0;
  } 
  
}
