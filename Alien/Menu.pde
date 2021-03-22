PImage menuBack;

void menu(){
  background(20);
  imageMode(CENTER);  //<>//
  menuBack = loadImage("menuBack.jpg");
  buttonPressed = true;
  image(menuBack, width/2, height/2, width, height);

  //fill(0, 0, 0, 100);
  //stroke(255, 255, 255);
  //rect(width/2-width/15, Math.round(height/2-height/6.55), width/8, Math.round(height/14.4));
  //rect(Math.round(width/2-width/9.48), height/2-height/24, Math.round(width/4.92), Math.round(height/14.4));
  //rect(Math.round(width/2-width/12.8), height/2+height/18 , Math.round(width/6.74), Math.round(height/14.4));
  //rect(Math.round(width/2-width/18.29), Math.round(height/2+height/6.26), Math.round(width/9.85), Math.round(height/14.4));

  if(overRect(width/2-width/15, Math.round(height/2-height/6.55),width/8, Math.round(height/14.4)) && mousePressed){ //Start
    sound[4].play();
    screen = 1;
  }
  if(overRect(Math.round(width/2-width/9.48), height/2-height/24, Math.round(width/4.92), Math.round(height/14.4)) && mousePressed){ //Tutorial
    createBlocks("tutLVL");
    currentLvlID = -1;
    sound[4].play();
    screen = 2;
  }
  if(overRect(Math.round(width/2-width/12.8), height/2+height/18 , Math.round(width/6.74), Math.round(height/14.4)) && mousePressed){ //Option
    sound[4].play();
    screen = 3;
  }
  if(overRect(Math.round(width/2-width/18.29), Math.round(height/2+height/6.26), Math.round(width/9.85), Math.round(height/14.4)) && mousePressed){ //Quit
    sound[4].play();
    System.exit(0);
  }
  imageMode(CORNER);

}
