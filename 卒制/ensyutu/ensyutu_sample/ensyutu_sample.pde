import netP5.*;
import oscP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

float x;
float y;

void setup(){
  //size(720,640);
  background(0);
  oscP5 = new OscP5(this,10000);//受信用のポートナンバー
  // myRemoteLocation = new NetAddress("127.0.0.1",10000);//送信用のポートナンバー

}

void draw(){
  println();
}

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/x")==true) {//ラベルが/testかチェック
    println(theOscMessage);
    println("connect");

    float x =theOscMessage.get(0).floatValue();
    println("X:"+x);
  }
}
// void oscEvent(OscMessage theOscMessage) {
//   /* print the address pattern and the typetag of the received OscMessage */
//   print("### received an osc message.");
//   print(" addrpattern: "+theOscMessage.addrPattern());
//   println(" typetag: "+theOscMessage.typetag());
//
//   theOscMessage.print();
// }
