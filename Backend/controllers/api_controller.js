const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');
const YuGiOhCardSet = require('../models/yugioh_cardset');
const YuGiOhArchetype = require('../models/yugioh_archetype');
const YuGiOhCard = require('../models/yugioh_card');
const YuGiOhImage = require('../models/yugioh_image');

exports.get_db_version = function(req, res, next){
    YuGiOhDatabaseVersion.find({}).then(function(dbVersion){
        res.send(dbVersion);
    }).catch(next);
}

exports.get_card_sets = function(req, res, next){
    YuGiOhCardSet.find({}).then(function(cardSets){
        res.send(cardSets);
    }).catch(next);
}

exports.get_archetypes = function(req, res, next){
    YuGiOhArchetype.find({}).then(function(archetypes){
        res.send(archetypes);
    }).catch(next);
}

exports.get_cards = function(req, res, next){
    YuGiOhCard.find({}).then(function(cards){
        res.send(cards);
    });
}

exports.get_all_images_by_id = function(req, res, next){
    YuGiOhImage.find({id: req.params.id}).then(function(image){
        res.send(image);
    });
}

exports.get_image_by_id = function(req, res, next){
    YuGiOhImage.find({id: req.params.id}, {id: 1, image_url: 1}).then(function(image){
        res.send(image);
    });
}

exports.get_image_small_by_id = function(req, res, next){
    YuGiOhImage.find({id: req.params.id}, {id: 1, image_url_small: 1}).then(function(image){
        res.send(image);
    });
}

exports.get_image_cropped_by_id = function(req, res, next){
    YuGiOhImage.find({id: req.params.id}, {id: 1, image_url_cropped: 1}).then(function(image){
        res.send(image);
    });
}