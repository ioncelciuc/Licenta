const express = require('express');
const router = express.Router();

const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');
const YuGiOhCardSet = require('../models/yugioh_cardset');

router.get('/db_version', function(req, res, next){
    YuGiOhDatabaseVersion.find({}).then(function(dbVersion){
        res.send(dbVersion);
    }).catch(next);
});

router.get('/card_sets', function(req, res, next){
    YuGiOhCardSet.find({}).then(function(cardSets){
        res.send(cardSets);
    }).catch(next);
});

module.exports = router;