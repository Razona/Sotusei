var osc = require('node-osc');

var client = new osc.Client('127.0.0.1', 10000);

client.send('/oscAddress', 200, function () {
  client.kill();
});
