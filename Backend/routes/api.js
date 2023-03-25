const express = require('express');
const router = express.Router();
const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');

router.get('/db_version', function(req, res, next){
    YuGiOhDatabaseVersion.find({}).then(function(dbVersion){
        res.send(dbVersion);
    }).catch(next);
});

module.exports = router;