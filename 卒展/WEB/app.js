var foo = require('./foo.js');
console.log(foo. printFoo());

var http = require("http");
var server = http.createServer(function(req,res) {
    res.write("Hello World!!");
    res.end();
});

var io = require('socket.io').listen(8080);

io.sockets.on('connection', function(socket) {
  socket.on('don', function(data) {
    console.log(data);
  });
});
