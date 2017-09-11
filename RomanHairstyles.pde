import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
PImage[] hairstyles = new PImage[8];
int[] hairstyleChoice = new int[8];
PImage[] infoPics = new PImage[8];
PImage camBut;
PImage infoBut;
boolean startCheck;
boolean infoView;
int cardHolder;

void setup() {
  size(640, 480, JAVA2D);
  
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  hairstyles[0] = loadImage("male1.png");
  hairstyles[1] = loadImage("male2.png");
  hairstyles[2] = loadImage("male3.png");
  hairstyles[3] = loadImage("male4.png");
  hairstyles[4] = loadImage("female1.png");
  hairstyles[5] = loadImage("female2.png");
  hairstyles[6] = loadImage("female3.png");
  hairstyles[7] = loadImage("female4.png");
  infoPics[0] = loadImage("malehairstyleinfo1.png");
  infoPics[1] = loadImage("malehairstyleinfo2.png");
  infoPics[2] = loadImage("malehairstyleinfo3.png");
  infoPics[3] = loadImage("malehairstyleinfo4.png");
  infoPics[4] = loadImage("femalehairstyleinfo1.png");
  infoPics[5] = loadImage("femalehairstyleinfo2.png");
  infoPics[6] = loadImage("femalehairstyleinfo3.png");
  infoPics[7] = loadImage("femalehairstyleinfo4.png");
  startCheck=false;
  infoView = false;
  cardHolder = 0;
  
  camBut = loadImage("badge2.png");
  infoBut = loadImage("badge1.png");
  
  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  
  image(video, 0, 0 );
  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  
  if (startCheck == false){
    for (int i=0; i<8; i++){
      hairstyleChoice[i]= int(random(0,8));
    }
    startCheck=true;
  }
      
  if (infoView == true){
    image(infoPics[cardHolder],40,30,240,180);
  }
  
  if (infoView == false){    
    for (int i = 0; i < faces.length; i++) {
      image(hairstyles[(hairstyleChoice[i])], faces[i].x-10, faces[i].y-35, faces[i].width+20, faces[i].height);
    }
  }
  
  image(camBut, 253, 208, 30,30);
  image(infoBut, 286, 208, 30,30);
  
}

void mouseClicked() {
  if ((mouseX>(253*2)) && (mouseX<(283*2)) && (mouseY>(208*2))){
    println("here");
    String fileName = (str(day()) + str(month()) + str(year()) + str(hour()) + str(minute()) + str(second()));
    println(str(day()) + str(month()) + str(year()) + str(hour()) + str(minute()) + str(second()));
    save(fileName + ".jpg");
  }
  
  if ((infoView == true) && ((mouseX<80) || (mouseX>560) || (mouseY<60) || (mouseY>420))){
    infoView = false;  
    cardHolder = 0;
  }
  
  if ((infoView == true) && ((mouseX>80) && (mouseX<560) && (mouseY>60) && (mouseY<420))){
    if (cardHolder<7){
      cardHolder++;
    } else {
      cardHolder = 0;
      infoView = false;
    }
  }
  
  if ((mouseX>(286*2)) && (mouseX<(306*2)) && (mouseY>(208*2))){
    infoView = true;
  }
}

void captureEvent(Capture c) {
  c.read();
}

void camInfo(){
  String fileName = (str(day()) + str(month()) + str(year()) + str(hour()) + str(minute()) + str(second()));
  println(str(day()) + str(month()) + str(year()) + str(hour()) + str(minute()) + str(second()));
  save(fileName + ".jpg");
}

void infoView(){
 infoView = true; 
}
