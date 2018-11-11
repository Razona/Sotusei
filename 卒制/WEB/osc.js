var oscport = 8000;

et express = require('express')
let http = require('http')
let app = express()
let server = http.createServer(app)
let io = require('socket.io').listen(server);
let fs = require('fs');
let ejs = require("ejs");
let iconv = require('iconv-lite');


// OSC Senderを立ち上げる
var oscsender = require('omgosc').UdpSender;
var sender = new oscsender(hosturl, oscport);

//WEBサーバー的なところ
app.use(express.static(__dirname))
server.listen(process.env.PORT);
console.log("サーバーたちがった")
