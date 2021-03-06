import netP5.*;
import oscP5.*;

//OSCP5クラスのインスタンス
OscP5 oscP5;
//OSC送出先のネットアドレス
NetAddress myRemoteLocation;

import processing.video.*;

import http.requests.*;
import codeanticode.syphon.*;
SyphonServer server;
Movie movie; //Movieインスタンス


float x;
float y;
float z;
float gx;
float gy;
float gz;
int hosuu;
String version;
int id;

//socketのconnect判定
boolean connect=false;
//connect=falseからtrueに変わった瞬間に発火する
boolean start = false;

float screanMode=1;
// float screanMode=0.5;

// String URL = "https://geisai-server-razona.c9users.io"; //rubyサーバー
String URL = "https://node-test-razona.c9users.io/json"; //node.jsサーバー
String URL0 = "https://node-test-razona.c9users.io/check"; //connectチェックAPI

int test_mode = 0;
String net_status="undeifind";
//
   void settings() {
    size(1920, 1080, P3D);
    PJOGL.profile=1;
  }


void setup() {
  background(0);
  // size(960, 540);
  //受信用の変数。右の数字はポート番号。送信側のポート番号とあわせる。
  oscP5 = new OscP5(this,12000);

  //送信用オブジェクト。左側の数字が相手のIPアドレス、右側が相手のポート番号。
  myRemoteLocation = new NetAddress("127.0.0.1", 10000);

  oscP5.plug(this,"getData","/sensor");
    server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  background(0);

  connect_check();
  if (connect == false){
    byouga_disconnect();
    println("失敗");
  } else if (connect == true){
    sensor_api();
    println("成功");
    //connectなら描画関数を呼び出し、disconnectならdisconnect関数を呼び出す
    if (net_status=="connect"){
        byouga_connect();
        byouga_test("x",str(x),"y",str(y),"z",str(z));
        osc_send();
    }else if (net_status=="disconnect"){
      disconnect();
    }
  }

  //test_modeかどうかの判定。
  //sensor_apiでconnectかの判定&jsonからpurseした値の代入を行う
  // if (test_mode==1){
  //   setuzoku_log();
  // }else if (test_mode==0){
    // sensor_api();
    // //connectなら描画関数を呼び出し、disconnectならdisconnect関数を呼び出す
    // if (net_status=="connect"){
    //     byouga_test("x",str(x),"y",str(y),"z",str(z));
    // }else if (net_status=="disconnect"){
    //   disconnect();
    // }
  // }

  //syphonに送る
    server.sendScreen();
}  //新規にメッセージ作成


void osc_send(){
  OscMessage msgx = new OscMessage("/x");
  msgx.add(x); //X
  //OSCメッセージ送信
  //新規にメッセージ作成
OscMessage msgy = new OscMessage("/y");
msgy.add(y); //X座標の位置を追加

  oscP5.send(msgx, myRemoteLocation);
  oscP5.send(msgy, myRemoteLocation);
}

//映像フレーム毎に自動呼び出しされるイベント
void movieEvent( Movie m ) {
 //カレント位置の画像を取得
 m.read();
}

//ネットワークエラー用画面
void disconnect(){
  println("aaaa");
  text("現在、ネットワークのエラーが発生しております。",200*screanMode,200*screanMode);
}

//socketの状態を判定する関数
void connect_check(){
  GetRequest get = new GetRequest(URL0);
  get.send();

  String get_r = get.getContent();
  // println(get_r);
  connect = boolean(get_r);
  // println(connect);
}

//通常時の描画制御
void byouga_connect(){
  noStroke();
  rect(1000*screanMode,600*screanMode,(260+x *200)*screanMode,20*screanMode);
  rect(1000*screanMode,650*screanMode,(260+y *200)*screanMode,20*screanMode);
  rect(1000*screanMode,700*screanMode,(260+z *200)*screanMode,20*screanMode);

  // println(x);
}

void byouga_disconnect(){
  //image( movie, 1000*screanMode, 700*screanMode, 920*screanMode, 380*screanMode);
  //movie.loop();
  textSize(100);
  text("Please connect",740*screanMode,780*screanMode);

}


void byouga_test(String title1,String val1,String title2,String val2,String title3,String val3){
  textSize(30);
  text(title1 + ":"+ val1,450*screanMode,800*screanMode);
  text(title2 + ":"+ val2,450*screanMode,900*screanMode);
  text(title3 + ":"+ val3,450*screanMode,1000*screanMode);
  // text("現在、ネットワークに接続しております。",700*screanMode,700*screanMode);
  text("Now loading",740*screanMode,780*screanMode);
  text("Network error",740*screanMode,800*screanMode);
  // println(x);
}



//センサーAPIへ接続、jsonのパースを行う
void sensor_api(){
    GetRequest get = new GetRequest(URL);
    get.send();

    String get_r = get.getContent();
    // println(get_r.length());
    // println(get_r.substring(0,1));

    println(get_r);

    if (get_r==null||get_r=="undeifind"){
      net_status="disconnect";
      println("disconnect");
          }else {
            String kasiramozi = get_r.substring(0,1);

            if (get_r.length()==0){
                println("a");
              }else {
                  JSONArray result = parseJSONArray(get.getContent());
                  JSONObject r0 = result.getJSONObject(0);
                  x = r0.getFloat("x");
                  y = r0.getFloat("y");
                  z = r0.getFloat("z");
                  gx = r0.getFloat("gx");
                  gy = r0.getFloat("gy");
                  gz = r0.getFloat("gz");
                  //hosuu = r0.getInt("hosuu");
                  version = r0.getString("version");
                  //id = r0.getInt("id");
                  net_status="connect";
                  println("x:"+x+",y:"+y+",z:"+z);
            }
      }
}

//接続テスト用の関数
void setuzoku_log(){
  GetRequest get = new GetRequest(URL);
  get.send();

  JSONArray result = parseJSONArray(get.getContent());
  println(result);
  JSONObject r0 = result.getJSONObject(0);
  int id = r0.getInt("num");
  String time = r0.getString("time");
  String device = r0.getString("device");
  String OS = r0.getString("OS");
  println("id"+id+"time"+time);
  println("device"+device+"OS"+OS);
}





//使ってないけど、jsonかどうかの判定に関する関数
void json_hantei(){
  GetRequest get = new GetRequest(URL);
  get.send();

  String get_r = get.getContent();
  // println(get_r.length());
  println(get_r.substring(0,1));

  if (get_r!=null){
    String kasiramozi = get_r.substring(0,1);

    if (get_r.length()==0){
        println("a");
      }else if (kasiramozi=="["){
        println("b");
    }
  }
}
