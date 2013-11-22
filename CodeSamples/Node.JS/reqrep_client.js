var zmq = require('zmq')
  , sock = zmq.socket('pull');

sock.connect('tcp://127.0.0.1:3000');
console.log('ReqRep client connected to port 3000');

sock.on('message', function(msg){
  console.log('work: %s', msg.toString());
});