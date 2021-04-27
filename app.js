const express = require('express');
const path = require('path');
const helmet = require('helmet');
const logger = require('morgan');

function normalizePort(val) {
  const port = parseInt(val, 10);
  if (Number.isNaN(port)) { return val; }
  if (port >= 0) { return port; }
  return false;
}

const app = express();

app.use(helmet({
    contentSecurityPolicy: false,
}));
app.use(express.static(path.resolve(__dirname, "./build")));
app.use(logger('dev'));

// Serve the React application
app.use(express.static("build"));
app.get('/', (req, res) => {

  res.sendFile(path.resolve(__dirname, './build', 'index.html'));
});

const port = normalizePort(process.env.PORT || 3000);
app.listen(port, () => {
  console.log(`API listening on port: ${port}`);
});