const express = require('express');
const router = express.Router();

const build_info_router = require('../build_info.js');

router.get('/', (req, res, next) => {
    res.end(JSON.stringify(build_info_router));
});

module.exports = router;
