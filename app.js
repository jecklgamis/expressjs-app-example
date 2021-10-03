const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');

const indexRouter = require('./routes/index');
const buildInfoRouter = require('./routes/build_info.js');
const apiRouter = require('./routes/api.js');
const liveProbeRouter = require('./routes/live_probe.js');
const readyProbeRouter = require('./routes/ready_probe.js');

const fs = require('fs');
const privateKey = fs.readFileSync('server.key', 'utf8');
const certificate = fs.readFileSync('server.crt', 'utf8');
const credentials = {key: privateKey, cert: certificate};
const app = express();

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('combined'));
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/build-info', buildInfoRouter);
app.use('/probe/live', liveProbeRouter);
app.use('/probe/ready', readyProbeRouter);
app.use('/api', apiRouter);

app.use((req, res, next) => {
    next(createError(404));
});

app.use((err, req, res, next) => {
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};
    res.status(err.status || 500);
    res.render('error');
});

const http = require('http');
const https = require('https');
const httpServer = http.createServer(app);
const httpsServer = https.createServer(credentials, app);

const printServerIsUp = server => {
    const addr = server.address();
    const bind = typeof addr === 'string' ? 'pipe ' + addr : 'port ' + addr.port;
    console.log(`App ready on ${bind}`);
};

httpServer.listen(8080);
httpServer.on('listening', () => {
    printServerIsUp(httpServer)
});

httpsServer.listen(8443);
httpServer.on('listening', () => {
    printServerIsUp(httpsServer)
});


module.exports = app;
