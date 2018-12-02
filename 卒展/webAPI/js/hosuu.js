var socketio = io();
var version = window.navigator.userAgent.toLowerCase();
console.log(version); 
socketio.emit('version1', {message: version});
  

// 重力加速度のしきい値
var GRAVITY_MIN = 9.8;
var GRAVITY_MAX = 12.00;
// 歩数
var _step = 0;
// 現在歩いているかどうか
var _isStep = false;

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
        var acc = Math.sqrt(ag.x*ag.x + ag.y*ag.y + ag.z*ag.z);
        // 
        if (_isStep) {
            // 歩行中にしきい値よりも低ければ一歩とみなす
            if (acc < GRAVITY_MIN) {
                _step++;
                _isStep = false;
            }
        } else {
            // しきい値よりも大きければ歩いているとみなす
            if (acc > GRAVITY_MAX) {
                _isStep = true;
                var hosuu = document.getElementById('hosuu')
                hosuu.innerHTML = _step + "歩";
                socketio.emit('hosuuA', {message: _step + "歩"})
            }
        }
        // console.log(_step + "歩");
        });
      })();
