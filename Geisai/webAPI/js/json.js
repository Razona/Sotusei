var socketio = io();

socketio.on('sensor2', function(data){
    var json_data = document.getElementById('json_data')
    json_data.innerHTML = data.msg;
})