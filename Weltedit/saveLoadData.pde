import static javax.swing.JOptionPane.*;

boolean releaseCurser = true;

void buttonSave(){
  
  fill(255);
  textSize(28);
  if(mouseX > 1860 && mouseX < 1915 & mouseY > 25 && mouseY < 75){
   fill(220);
   if(maus() == 1 && releaseCurser == true){
     saveMap();
     //println("SAVED");
     fill(180);
     releaseCurser = false;
   }
  }
  text("save", 1860, 50);
  
  
}

void buttonLoad(){
  
  fill(255);
  textSize(28);
  if(mouseX > 1860 && mouseX < 1915 & mouseY > 100 && mouseY < 150){
   fill(220);
   if(maus() == 1 && releaseCurser == true){
     loadMap();
     x = 1919;
     y = 1;
     //println("Loaded");
     fill(180);
     releaseCurser = false;
   }
  }
  text("load", 1860, 125);
}

void buttonClear(){
  
  fill(255);
  textSize(28);
  if(mouseX > 1860 && mouseX < 1915 & mouseY > 175 && mouseY < 225){
   fill(220);
   if(maus() == 1){
    for(int i = 0; i < 256; i++){
      for(int ii = 0; ii < 34; ii++){
        block[i][ii] = 0;
      }
    }
     fill(180);
   }
  }
  text("clear", 1860, 200);
}

void displayStats(){
  fill(255);
  text(screenNum, 1860, 275);
  
  text("blo:", 1860, 350);
  text(currentBlock, 1860, 380);
  
  if(currentBlock < blockAmount){
    image(blockIm[currentBlock],1862,420);
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    if(screenNum <15 && screenNum % 2 == 0){
      screenNum++;
    }
  } else 
  if (key == 's' || key == 'S'){
    if(screenNum >0 && screenNum % 2 == 1){
      screenNum--;
    }
  }else 
  if (key == 'd' || key == 'D'){
    if(screenNum <14){
      screenNum = screenNum +2;
    }
  }else 
  if (key == 'a' || key == 'A'){
    if(screenNum > 1){
      screenNum = screenNum -2;
    }
  }else 
  if(keyCode == UP){
    if(currentBlock < 255){
      currentBlock++;
    }
  }else 
  if(keyCode == DOWN){
    if(currentBlock > 0){
      currentBlock--;
    }
  }
    
}

void saveMap(){
  
  String name = showInputDialog("Name der Welt:");
  
  byte[] blockBytes = new byte[8704];  //Format: x1,y1,blockArt1,x2,y2,blockArt2,...
  
  for(int i = 0; i < 8704; i++){
    blockBytes[i] = 0;
  }
  
  int counter = 0;
  for(int i = 0; i < 256; i++){
    for(int ii = 0; ii < 34; ii++){
      blockBytes[counter] = byte(block[i][ii]);
      counter++;
    }
  }

  
  // Writes the bytes to a file
  saveBytes("\\welten\\" + name + ".dat", blockBytes);
  
  
}


void loadMap(){
  
  String path = sketchPath() + "\\welten";
  //print(path);
  String[] filenames = listFileNames(path);
  printArray(filenames);
  
  String name = showInputDialog("Name der Welt:");
  String pName = name +".dat";
  boolean exist = false;
  

  
  for(int i = 0; i< filenames.length; i++){
    if(pName.equals(filenames[i])){
      exist = true;
      break;
    }
  }

  print(exist);
  
  if(exist == true){
    // Open a file and read its binary data 
    byte blockBytes[] = loadBytes("\\welten\\" + pName); 
    int counter = 0;
    for(int i = 0; i < 256; i++){
      for(int ii = 0; ii < 34; ii++){
        block[i][ii] = blockBytes[counter];
        counter++;
      }
    }
  
  }else{
    byte blockBytes[] = loadBytes("\\welten\\error.dat"); 
    int counter = 0;
    for(int i = 0; i < 256; i++){
      for(int ii = 0; ii < 34; ii++){
        block[i][ii] = blockBytes[counter];
        counter++;
      }
    }
  }
  
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
