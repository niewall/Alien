void levelMenu(){
  
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

boolean overRect(int x, int y, int width, int height)  {
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
  
  boolean getUnlockStatus(){
    
   return unlocked; 
  }
  
  int getScore(){
    
   return lvlscore; 
  }
  
  void setScore(int pScore){
   if(pScore > lvlscore){
    lvlscore = pScore; 
   }
  }
  
  void lvlUnlock(){
   unlocked = true; 
  }
}
