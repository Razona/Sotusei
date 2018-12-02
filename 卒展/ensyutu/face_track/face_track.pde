
import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture cam;
OpenCV opencv;
Rectangle[] faces;

void setup(){
  size(640, 480);
  
  String[] cameras = Capture.list();
  
  for(int i=0; i<cameras.length; i++){
    println("[" + i + "] " + cameras[i]);
  }
  
  cam = new Capture(this, cameras[39]);
  cam.start();
}

void draw(){
  if(cam.available() == true){
    cam.read();
    
    tint(100,100, 255);
    scale(-1, 1);
 
    image(cam, -width, 0);
 
    opencv = new OpenCV(this, cam);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    faces = opencv.detect(); 
    
    
    for(int i=0; i<faces.length; i++){
      stroke(#ff0000);
      noFill();
      rect(faces[i].x, faces[i].y,  faces[i].width, faces[i].height);
    }
  }
}
