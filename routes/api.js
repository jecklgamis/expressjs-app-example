const express = require('express');
const router = express.Router();

router.get('/', function (req, res, next) {
    setTimeout((() => {
        res.send({name: "expressjs-app-example", "message": "You have reached the /api endpoint"});
    }), 1500)

});

router.post('/', function (req, res, next) {
    res.send({name: "expressjs-app-example", "message": "Received!"});
});

router.get('/respond3xx', function (req, res, next) {
    res.sendStatus(300)
});

router.get('/respond4xx', function (req, res, next) {
    res.sendStatus(400)
});

router.get('/respond5xx', function (req, res, next) {
    res.sendStatus(500)
});

router.get('/runtimeError', function (req, res, next) {
    throw new Error('Some runtime error')
});


module.exports = router;
