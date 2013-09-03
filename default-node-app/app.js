var http = require('http')
  , sys  = require('sys');

var header = { "Content-Type": "text/html" };

var app = http.createServer( function( request, response ) {
	sys.puts("Incoming request! ");
	response.writeHeader(200, header);
	response.write("<h2>Hello, From your Vagrant Box!</h2>");
	response.end();
});

app.listen(80); // Listen for incoming requests on port 80

