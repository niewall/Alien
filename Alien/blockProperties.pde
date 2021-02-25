int[] notSolid = {
  0,9
};

boolean getBlockSolid(int bNum){
  
   for(int i = 0; i < notSolid.length; i++){
      if(bNum == notSolid[i]){
        return false; 
      }
   }
   return true;
}
