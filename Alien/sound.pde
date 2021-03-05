import processing.sound.*;
boolean soundPlaying = false;
SoundFile[] sound = new SoundFile[10];

void soundSetup(){
  sound[0] = new SoundFile(this, "titel.wav");
  sound[1] = new SoundFile(this, "hit.mp3");
  sound[2] = new SoundFile(this, "jump.wav");
  sound[3] = new SoundFile(this, "jump2.wav");
  sound[4] = new SoundFile(this, "click.wav");
  sound[5] = new SoundFile(this, "gameover.wav");
  sound[6] = new SoundFile(this, "start.ogg");
  sound[7] = new SoundFile(this, "sword.wav");
  sound[8] = new SoundFile(this, "coin.wav");

  sound[1].amp(0.2);
  sound[3].amp(0.4);
  sound[0].amp(0.2);
}

void sound(boolean switchS) {
  
  soundPlaying = switchS;
  if (soundPlaying) {
    // Load a soundfile from the /data folder of the sketch and play it back
    sound[0].loop();
  } else {

    sound[0].loop();
  }
}
