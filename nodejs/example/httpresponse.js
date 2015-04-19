var http = require('http');

var req = http.get({host: 'deltax.me'});

req.on('response', function(req) {
	res.setEncoding('utf8');
	res.on('data', function(data) {
		console.log(data);
	});
});
