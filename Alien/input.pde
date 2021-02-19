

void isKeyPressed() {
    if (moveKeys[0]) {
      blob.move('j');
    }
    if (moveKeys[2]){
      //blob.move('j');
    }
    if (moveKeys[3]){
      blob.move('r');
    }
    if ((moveKeys[1])){
      blob.move('l');
    }
    if (1 == 2){
      saveFrame(); 
    }
}

boolean[] moveKeys = new boolean[4];


void setMovement(int k, boolean b) {
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

void keyPressed() {
  setMovement(key, true);
}

void keyReleased() {
  setMovement(key, false);
}
