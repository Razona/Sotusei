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

      client.send('/socket/all', val, function () {
      });
      client.send('/socket/x', msg['x'], function () {
      });
      client.send('/socket/y', msg['y'], function () {
      });
      client.send('/socket/z', msg['z'], function () {
      });
      client.send('/socket/gx', msg['gx'], function () {
      });
      client.send('/socket/gy', msg['gy'], function () {
      });
      client.send('/socket/gz', msg['gz'], function () {
      });
      client.send('/socket/a', msg['a'], function () {
      });
      client.send('/socket/b', msg['b'], function () {
      });
      client.send('/socket/g', msg['g'], function () {
      });
      client.send('/socket/hosuu', msg['hosuu'], function () {
      });

      client2.send('/test',"接続成功", function () {
      });
      client2.send('/socket/all', val, function () {
      });

        // console.log(`message: ${util.inspect(msg)}`);
        // console.log(msg);
        console.log("x:"+msg['x']);
    });

    socket.on('connect_check',(msg)=> {
      val = util.inspect(msg);

      client.send('/connect_check',val,function(){
      });
      client2.send('/connect_check', val, function () {
      });

      // console.log(msg);
      });
});
