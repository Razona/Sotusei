var socketio = io()

var sendEvent = function(){
    msg = $('input#msg-input').val()
    socketio.emit('eventC', {message: msg})
}

socketio.on('eventB', function(data){
    $('div#msg-whole').prepend("<div>"+ data.msg +"</div>")
})