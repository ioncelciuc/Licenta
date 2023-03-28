const express = require('express');
const router = express.Router();

const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');
const YuGiOhCardSet = require('../models/yugioh_cardset');
const YuGiOhArchetype = require('../models/yugioh_archetype');
const YuGiOhCard = require('../models/yugioh_card');
const YuGiOhImage = require('../models/yugioh_image');

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

router.get('/archetypes', function(req, res, next){
    YuGiOhArchetype.find({}).then(function(archetypes){
        res.send(archetypes);
    }).catch(next);
});

router.get('/cards', function(req, res, next){
    YuGiOhCard.find({}).then(function(cards){
        res.send(cards);
    });
});

router.get('/images/:id', function(req, res, next){
    YuGiOhImage.find({id: req.params.id}).then(function(image){
        res.send(image);
    });
});

router.get('/image/:id', function(req, res, next){
    YuGiOhImage.find({id: req.params.id}, {id: 1, image_url: 1}).then(function(image){
        res.send(image);
    });
});

router.get('/image_small/:id', function(req, res, next){
    YuGiOhImage.find({id: req.params.id}, {id: 1, image_url_small: 1}).then(function(image){
        res.send(image);
    });
});

router.get('/image_cropped/:id', function(req, res, next){
    YuGiOhImage.find({id: req.params.id}, {id: 1, image_url_cropped: 1}).then(function(image){
        res.send(image);
    });
});

module.exports = router;