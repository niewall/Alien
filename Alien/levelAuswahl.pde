void levelMenu(){
  
  background(20);
  textAlign(CENTER);
  textSize(50);
  text("LEVEL",width/2,height/10);
  rectMode(CORNER);
  
  //level
  rect(width/9*1,height/3, width/9,height/3);
  if(overRect(width/9*1,height/3, width/9,height/3) && mousePressed){
    createBlocks("level1");
    screen = 2;
  }
  rect(width/9*3,height/3, width/9,height/3);
  if(overRect(width/9*3,height/3, width/9,height/3) && mousePressed){
    createBlocks("level2");
    screen = 2;
  }
  rect(width/9*5,height/3, width/9,height/3);
  if(overRect(width/9*5,height/3, width/9,height/3) && mousePressed){
    createBlocks("level3New");
    screen = 2;
  }
  rect(width/9*7,height/3, width/9,height/3);
  if(overRect(width/9*7,height/3, width/9,height/3) && mousePressed){
    createBlocks("level4");
    screen = 2;
  }
  
  rect(width/9*3,height/3*2+100,width/9*3,height/8);
  if(overRect(width/9*3,height/3*2+100,width/9*3,height/8) && mousePressed){
    createBlocks("level5");
  }

}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
