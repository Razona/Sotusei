import netP5.*;
import oscP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

float syukusyaku = 0.8;
float map_x = 600*syukusyaku;
float map_y = 900*syukusyaku;

//体験者の初期位置
float x=30;
float y=900*syukusyaku -30 ;



float mouseX_kako=0;
float mouseY_kako=0;
boolean idou_kyoka = false;


boolean switch_mouse_over = false;
boolean map_ryouiki = false;

//sim_mode:0はマウスで動かすモード,sim_mode:1はoscで受けた値を使って描画するモード
int sim_mode = 1;

void setup(){
  //6m×9mの部屋を表現
  //1cm=1という感じ
  size(700,720);
  background(0);
  map_byouga();

  oscP5 = new OscP5(this,3000);//受信用のポートナンバー
  myRemoteLocation = new NetAddress("127.0.0.1",10000);//送信用のポートナンバー
   oscP5.plug(this,"test","/test");
}



void draw(){
  background(0);

  map_ryouiki();

  if (map_ryouiki == true && sim_mode == 0){
    mouse_iti_jouhou();
    idou_kyoka();
  }

  map_byouga();
  point_byouga();


  jouhou_byouga();

  mode_switch();
  osc_send();
}

//展示部屋の図を描画
void map_byouga(){
  fill(150);
  rect(0,0,map_x,map_y);
}

//現在地を示す点を描画
void point_byouga(){
  fill(255);
  ellipse(x,y,10,10);
}

//各種情報の描画
void jouhou_byouga(){
  fill(0,255,0);
  float tate_soroe = 680;


  text("管理用ツール v0.01",tate_soroe*syukusyaku,50*syukusyaku);


if (sim_mode ==0 ){
  //シミュレーターモード用の情報
  text("現在地",tate_soroe*syukusyaku,170*syukusyaku);
  text("x:"+x,tate_soroe*syukusyaku,200*syukusyaku);
  text("y:"+y,tate_soroe*syukusyaku,230*syukusyaku);

  text("その他情報", tate_soroe*syukusyaku ,270*syukusyaku);
  text("マウスX差分:"+mouseX_kako, tate_soroe*syukusyaku ,300*syukusyaku);
  text("idou_kyoka:"+idou_kyoka, tate_soroe*syukusyaku ,330*syukusyaku);
}else if (sim_mode == 1){
  text("現在地",tate_soroe*syukusyaku,170*syukusyaku);
  text("x:"+x,tate_soroe*syukusyaku,200*syukusyaku);
  text("y:"+y,tate_soroe*syukusyaku,230*syukusyaku);

  text("ネットワーク接続", tate_soroe*syukusyaku ,270*syukusyaku);
  text("いつか実装", tate_soroe*syukusyaku ,290*syukusyaku);
}

}

//現在地の情報を更新
void mouse_iti_jouhou (){
  if (mouseButton == LEFT){
    //_kakoの値のリフレッシュを行う
    if (idou_kyoka == false){
      mouseX_kako = mouseX;
      mouseY_kako = mouseY;
      idou_kyoka = true;
    }

    //sabun_x でmouseXとmousex_kakoを比較
    //この関数の最後にmouseX_kakoに代入
    float  sabun_x = mouseX - mouseX_kako;
    float sabun_y = mouseY - mouseY_kako;
    println("x:"+sabun_x);
    println("過去x:"+mouseX_kako);
    println("結果x"+x);
    x = x + sabun_x;
    y = y + sabun_y;

    mouseX_kako = mouseX;
    mouseY_kako = mouseY;
  }

  if (mouseButton == RIGHT){
    //右クリックの場合、座標がクリックした場所にワープ
    x = mouseX;
    y = mouseY;
  }
}


// iti_jouhouに関連して、移動許可を出す関数
void idou_kyoka(){
  if (mousePressed == false){
    idou_kyoka = false;
    // println("移動許可:"+false);
  }
}

void mouseReleased(){
  idou_kyoka = false;
  // println("移動許可:"+false);
}


//マウスがマップの上にあるかの判定
void map_ryouiki(){
  if (0<mouseX&&mouseX<map_x&&0<mouseY&&mouseY<map_y){
    map_ryouiki = true;
  }else {
    map_ryouiki = false;
  }
}


//モード切り替えのスイッチに関する関数
void mode_switch(){

  //マウスオーバーしてるかの判定
  //してたら、switch_mouse_overがtrueになる
  if (690*syukusyaku<mouseX&&mouseX<810*syukusyaku&&750*syukusyaku<mouseY&&mouseY<780*syukusyaku){
    switch_mouse_over = true;
  } else{
    switch_mouse_over = false;
  }

  //ボタンの描画について。
  stroke(255);
  if (switch_mouse_over == false){
    noFill();
  }else {
    fill(255);
  }
  rect(690*syukusyaku,750*syukusyaku,120*syukusyaku,30*syukusyaku);


  //中のテキストについて
  if (switch_mouse_over == false){
    fill(255);
  }else if (switch_mouse_over == true){
    fill(0);
  }
  if (sim_mode == 0){
      text("シミュレーター",695*syukusyaku,770*syukusyaku);
  }else if(sim_mode == 1){

    text("監視モード",710*syukusyaku,770*syukusyaku);
  }
}

//クリックされたら呼び出される
void mouseClicked(){
  //ボタン機能の実装
  if (switch_mouse_over==true&&sim_mode==0){
    sim_mode=1;
  }else if (switch_mouse_over==true&&sim_mode==1){
    sim_mode = 0;
  }
}



void osc_send(){
  OscMessage send_x = new OscMessage("/x");

    //add()で追加していく。　
    send_x.add(x);

OscMessage send_y = new OscMessage("/y");
    send_y.add(y);

    /* send the message */
    oscP5.send(send_x, myRemoteLocation);//ここで送信をしてる
    oscP5.send(send_y, myRemoteLocation);
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  // theOscMessage.print();
}

// float speed = 5.0;

//
// void keyPressed() {
//
//   if (key == CODED) {      // コード化されているキーが押された
//
//     if ((keyCode == RIGHT)&&(keyCode == UP)){
//       x += speed;
//       y -= speed;
//     }else if ((keyCode == RIGHT)&&(keyCode == DOWN)){
//       x += speed;
//       y += speed;
//     }else if ((keyCode == LEFT)&&(keyCode == UP)){
//       x -= speed;
//       y -= speed;
//     }else if ((keyCode == LEFT)&&(keyCode == DOWN)){
//       x -= speed;
//       y += speed;
//     }else if (keyCode == RIGHT) {    // キーコードを判定
//           x += speed;
//     } else if (keyCode == LEFT) {
//            x -= speed;
//     }else if (keyCode == UP){
//       y -= speed;
//     }else if (keyCode == DOWN){
//       y += speed;
//     }
//   }
// }
