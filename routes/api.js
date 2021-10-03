const express = require('express');
const router = express.Router();

router.get('/', function (req, res, next) {
    res.send({name: "expressjs-app-template", "message": "You have reached the /api endpoint"});
});

module.exports = router;
