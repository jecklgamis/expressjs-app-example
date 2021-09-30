const express = require('express');
const router = express.Router();

router.get('/', function (req, res, next) {
    res.send({name: "expressjs-app-template", "message": "It works on my machine!"});
});

module.exports = router;
