import http.requests.*;

float x;
float y;
float z;


// String URL = "https://geisai-server-razona.c9users.io"; //rubyサーバー
String URL = "https://node-test-razona.c9users.io/json"; //node.jsサーバー

int test_mode = 0;

void setup() {
  size(720,400);
  background(0);
}

void draw() {
  background(0);

  frameRate(10);

  if (test_mode==1){
    setuzoku_log();
  }else{
    sensor_api();
    byouga("x",str(x),"y",str(y),"z",str(z));
  }

}

void byouga(String title1,String val1,String title2,String val2,String title3,String val3){
  text(title1 + ":"+ val1,350,100);
  text(title2 + ":"+ val2,350,200);
  text(title3 + ":"+ val3,350,300);
  println(x);
}



void sensor_api(){
  GetRequest get = new GetRequest(URL);
  get.send();

  JSONArray result = parseJSONArray(get.getContent());
  JSONObject r0 = result.getJSONObject(0);
  float x = r0.getFloat("x");
  float y = r0.getFloat("y");
  float z = r0.getFloat("z");

  println("x:"+x+",y:"+y+",z:"+z);
}

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
