

void isKeyPressed() {
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


void setMovement(int k, boolean b) {
  if(RENDER.equals(FX2D)){
  switch (k) {
  case 'W':
    moveKeys[0] = b;
    break;
  case 'A':
    moveKeys[1] = b;
    break;
  case 'S':
    moveKeys[2] = b;
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
    moveKeys[2] = b;
    break;
  case 'd':
    moveKeys[3] = b;
    break;
  }
  
  
}
}

void keyPressed() {
  setMovement(key, true);
}

void keyReleased() {
  setMovement(key, false);
}
