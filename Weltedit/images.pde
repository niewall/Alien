PImage[] blockIm = new PImage[255];
boolean[] solid = new boolean[255];
int blockAmount = 50;
JSONArray blockData;


void loadImages(){
   blockData = loadJSONArray("blocks.json");

  for (int i = 0; i < blockData.size(); i++) {
    
    JSONObject block = blockData.getJSONObject(i); 

    int id = block.getInt("id");
    String image = block.getString("image");
    solid[i] = block.getBoolean("solid");
    blockIm[i] = loadImage(image);

    println(id + ", " + image);
  }
  
  for(int i = blockAmount; i<blockIm.length;i++){
    blockIm[i] = loadImage("blank.png");
  }
  
  loadRest();
}
