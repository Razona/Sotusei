var util = require('util');

var osc = require('node-osc');
var client = new osc.Client('127.0.0.1', 10000);


var io = require('socket.io-client');
var socket = io('https://node-test-razona.c9users.io');

socket.on('connect', () => {
  console.log('接続成功');
    socket.emit("message", 'send message.');

    socket.on('sensor_val', (msg) => {

      //msgの中身をobjからstringに変換
      val = util.inspect(msg);

      client.send('/oscAddress', val, function () {
      });

        console.log(`message: ${util.inspect(msg)}`);
    });

    socket.on('conect_check',(msg)=> {
      console.log(msg);
      });
});
