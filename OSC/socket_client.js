var util = require('util');

var osc = require('node-osc');
var client = new osc.Client('127.0.0.1', 10000);
var client2 = new osc.Client('127.0.0.1', 3000);


var io = require('socket.io-client');
var socket = io('https://node-test-razona.c9users.io');

socket.on('connect', () => {
  console.log('接続成功');
    socket.emit("message", 'send message.');

    socket.on('sensor_val', (msg) => {

      //msgの中身をobjからstringに変換
      val = util.inspect(msg);

      client.send('/socket', val, function () {
      });

      client2.send('/socket', val, function () {
      });


        console.log(`message: ${util.inspect(msg)}`);
    });

    socket.on('connect_check',(msg)=> {
      val = util.inspect(msg);

      client.send('/connect_check',val,function(){
      });
      client2.send('/connect_check', val, function () {
      });

      console.log(msg);
      });
});
