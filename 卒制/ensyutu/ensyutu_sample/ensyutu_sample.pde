import netP5.*;
import oscP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

float x;
float y;

void setup(){
  size(480,240);
  background(0);
  oscP5 = new OscP5(this,10000);//受信用のポートナンバー
  // myRemoteLocation = new NetAddress("127.0.0.1",10000);//送信用のポートナンバー

}

void draw(){
  // background(0);

}

void oscEvent(OscMessage theOscMessage) {
  osc_receive(theOscMessage,"/x",100);
  osc_receive(theOscMessage,"/y",200);
}

void osc_receive(OscMessage theOscMessage, String add,float y){
  if(theOscMessage.checkAddrPattern(add)==true) {//ラベルが/testかチェック
    // println(theOscMessage);
    // println("connect");

    float val =theOscMessage.get(0).floatValue();
    println(add+":"+val);

    fill(0,255,0);
    text_byouga(add+":"+val,y);
  }
}

void text_byouga(String val,float y){
  background(0);
    text(val,100,y);
}

// void oscEvent(OscMessage theOscMessage) {
//   /* print the address pattern and the typetag of the received OscMessage */
//   print("### received an osc message.");
//   print(" addrpattern: "+theOscMessage.addrPattern());
//   println(" typetag: "+theOscMessage.typetag());
//
//   theOscMessage.print();
// }
