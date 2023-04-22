const express = require('express');
const router = express.Router();

router.get('/', function (req, res, next) {
    res.send({name: "expressjs-app-example", "message": "Relax, express it."});
});

module.exports = router;
