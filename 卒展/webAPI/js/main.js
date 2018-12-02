var socketio = io();

var version = window.navigator.userAgent.toLowerCase();
socketio.emit('version1', {message: version});

// 重力加速度のしきい値
var GRAVITY_MIN = 9.8;
var GRAVITY_MAX = 12.00;
// 歩数
var _step = 0;
// 現在歩いているかどうか
var _isStep = false;

var id;

var msg;

msg = true;
socketio.emit('connect', {message: msg});

socketio.on('id', function(data){
   id = data.message;
})

console.log(id);

function initialize() {
    // デバイスの加速度センサーの情報を取得します
    window.addEventListener('devicemotion', onDeviceMotion);
}



      (function() {
        window.addEventListener("devicemotion", function(e){
                    e.preventDefault();
        // 重力加速度を取得
        var ag = e.accelerationIncludingGravity;
        // 重力加速度ベクトルの大きさを取得
        var accc = Math.sqrt(ag.x*ag.x + ag.y*ag.y + ag.z*ag.z);




        if (_isStep) {
            // 歩行中にしきい値よりも低ければ一歩とみなす
            if (accc < GRAVITY_MIN) {
                _step++;
                _isStep = false;
            }
        } else {
            // しきい値よりも大きければ歩いているとみなす
            if (accc > GRAVITY_MAX) {
                _isStep = true;
                var hosuu = document.getElementById('hosuu')
                hosuu.innerHTML = _step + "歩";
                // socketio.emit('hosuuA', {message: _step + "歩"})
            }
        }
          //加速度
          var acc = e.acceleration;
          var x = obj2NumberFix(acc.x, 5);
          var y = obj2NumberFix(acc.y, 5);
          var z = obj2NumberFix(acc.z, 5);
          //傾き(重力加速度)
          var acc_g = e.accelerationIncludingGravity;
          var gx = obj2NumberFix(acc_g.x, 5);
          var gy = obj2NumberFix(acc_g.y, 5);
          var gz = obj2NumberFix(acc_g.z, 5);
          //回転値
          var rota_r = e.rotationRate;
          var a = obj2NumberFix(rota_r.alpha, 5); //z方向
          var b = obj2NumberFix(rota_r.beta, 5); //x方向
          var g = obj2NumberFix(rota_r.gamma, 5); // y方向
          //表示
          print3('acc-x', x, 'acc-y', y, 'acc-z', z); //加速度
          print3('acc-gx', gx, 'acc-gy', gy, 'acc-gz', gz); //傾き
          print3('rr-a', a, 'rr-b', b, 'rr-g', g); //回転値

          //socket.ioでの送信部分
          var msg = a;
          // var json_data = [{"acc":acc,"x":x,"y":y,"z":z,"acc_g":acc_g,"gx":gx,"gy":gy,"gz":gz,"rota_r":rota_r,"a":a,"b":b,"g":g}];
          // var json_data = [{"acc":acc,"acc_g":acc_g,"rota_r":rota_r}];
          var json_data =[{"x":x,"y":y,"z":z,"gx":gx,"gy":gy,"gz":gz,"a":a,"b":b,"g":g,"hosuu":_step,"version":version,"id":id}];
          socketio.emit('sensor1', {message: json_data});

          // function
          function obj2NumberFix(obj, fix_deg){
            return Number(obj).toFixed(fix_deg);
          }
          function print3(id1, value1, id2, value2, id3, value3){
            print1(id1, value1);
            print1(id2, value2);
            print1(id3, value3);
          }
          function print1(id, value){
            var id_obj = document.getElementById(id);
            id_obj.innerHTML = value;
          }
        });
      });
