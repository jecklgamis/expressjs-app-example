const express = require('express');
const router = express.Router();

const build_info = require('../build_info_data.js');

router.get('/', (req, res, next) => {
    res.end(JSON.stringify(build_info));
});

module.exports = router;
