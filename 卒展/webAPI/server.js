let express = require('express')
let http = require('http')
let app = express()
let server = http.createServer(app)
let io = require('socket.io').listen(server);
let fs = require('fs');
let ejs = require("ejs");
let iconv = require('iconv-lite');
var check = false;
var id =0;
const PORT = process.env.PORT || 3000;



var json;
let counter=0;

app.use(express.static(__dirname))

// server.listen(process.env.PORT);
server.listen(PORT, () => console.log(`listening on *:${PORT}`));

console.log("サーバーたちがった")


app.get('/', (req, res)=> {
    counter= counter+1;
    res.sendFile(__dirname + '/views/index.html');
});

app.get('/2',(req, res)=> {
    res.sendFile(__dirname + '/views/index2.html');
});

app.get('/sensor',(req, res)=> {
    res.sendFile(__dirname + '/views/sensor.html');
    console.log("sensor");
});

app.get('/hosuu',(req, res)=> {
    res.sendFile(__dirname + '/views/hosuu.html');
});

// app.get('/json.json',(req, res)=> {
//     res.sendFile(__dirname + '/views/json.html');
// });

//ejsゾーン
app.engine('ejs',ejs.renderFile);

app.get('/json', function(req, res){

    var util = require('util');

  res.send(json);
});

app.get('/check',function(req, res) {
    var util = require('util');
    res.send(check);
});

app.get('/cali,'function(req, res) {
  res.sendFile(__dirname + '/views/sensor.html');
});

//socketゾーン

io.sockets.on('connection', (socket)=>{
    socket.on('eventA', (eventData)=>{
        io.sockets.emit('eventB', {msg: eventData.message})
    })
})

io.sockets.on('connection', (socket)=>{
    socket.on('eventC', (eventData)=>{
        io.sockets.emit('eventD', {msg: eventData.message})
         console.log(eventData.message)
    })
})

io.sockets.on('connection', (socket)=>{
    socket.on('sensor1', (eventData)=>{
        check = true;
        io.sockets.emit('sensor2', {msg: eventData.message});
        console.log(eventData.message);
        json = eventData.message;
        console.log(check);
        id = id +1;
        console.log("id"+id);

          //切断したときに送信
    socket.on("disconnect", function (){
        check = false;
        console.log(check);
     });

    })
})

io.sockets.on('connection', (socket)=>{
    socket.on('hosuuA', (eventData)=>{
        console.log(eventData.message);
        io.sockets.emit('hosuuB', {msg: eventData.message})
    })
})


io.sockets.on('connection', (socket)=>{
    socket.on('version1', (eventData)=>{
        io.sockets.emit('version2', {msg: eventData.message});
        console.log(eventData.message);
    })
})

io.sockets.on('connection', (socket)=>{
    socket.on('connect', (eventData)=>{
        console.log(counter);
        io.sockets.emit('id', {msg: counter});

    })
})
