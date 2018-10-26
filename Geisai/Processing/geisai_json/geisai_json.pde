import http.requests.*;
import codeanticode.syphon.*;
SyphonServer server;



float x;
float y;
float z;
float gx;
float gy;
float gz;
int hosuu;
String version;
int id;

float screanMode=1;

// String URL = "https://geisai-server-razona.c9users.io"; //rubyサーバー
String URL = "https://node-test-razona.c9users.io/json"; //node.jsサーバー

int test_mode = 0;
String net_status="undeifind";
//
   void settings() {
    size(1920, 1080, P3D);
    PJOGL.profile=1;
  }


void setup() {
  background(0);
  //size(960, 540);
    server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  background(0);
  frameRate(10);

  if (test_mode==1){
    setuzoku_log();
  }else if (test_mode==0){
    sensor_api();
    if (net_status=="conect"){
        byouga_test("x",str(x),"y",str(y),"z",str(z));
    }else if (net_status=="disconect"){
      disconect();
    }
  }
   // server.sendScreen();
}

//ネットワークエラー用画面
void disconect(){
  println("aaaa");
  text("現在、ネットワークのエラーが発生しております。",200*screanMode,200*screanMode);
}

//通常時の描画制御
void byouga(String title1,String val1,String title2,String val2,String title3,String val3){
  noStroke();
  rect(100,100,100,300);
  // println(x);
}


void byouga_test(String title1,String val1,String title2,String val2,String title3,String val3){
  text(title1 + ":"+ val1,450*screanMode,800*screanMode);
  text(title2 + ":"+ val2,450*screanMode,900*screanMode);
  text(title3 + ":"+ val3,450*screanMode,1000*screanMode);
  // text("現在、ネットワークに接続しております。",700*screanMode,700*screanMode);
  text("Now loading",700*screanMode,780*screanMode);
  text("Network error",700*screanMode,800*screanMode);
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
      net_status="disconect";
      println("disconect");
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
                  net_status="conect";
                  println("x:"+x+",y:"+y+",z:"+z);
                  saveJSONArray(result,"data/person.json");
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
