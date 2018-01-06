const http = require('http');
let port = 8080;
if (!isNaN(process.env.PORT)) {
  const portParam = parseInt(process.env.PORT, 10);
  const whitelistedPorts = [80, 443, 8080, 8081];
  if (whitelistedPorts.includes(portParam)) {
    port = portParam;
  } else {
    console.error('Invalid port selection, falling back to 8080');
  }
}

const requestHandler = (request, response) => {
  response.end(`Node.js server running on ${port}`);
};

const server = http.createServer(requestHandler);

server.listen(port, (err) => {
  if (err) {
    return console.error('Something bad happened', err);
  }

  console.log(`Server is listening on ${port}`);
});
