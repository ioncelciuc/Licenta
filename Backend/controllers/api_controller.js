const mongoose = require('mongoose');

const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');
const YuGiOhCardSet = require('../models/yugioh_cardset');
const YuGiOhArchetype = require('../models/yugioh_archetype');
const YuGiOhCard = require('../models/yugioh_card');
const YuGiOhImage = require('../models/yugioh_image');

const Deck = require('../models/deck');
const DeckContent = require('../models/deck_content');

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

exports.create_deck = function(req, res, next){
    const deck = new Deck({
        _id: new mongoose.Types.ObjectId(),
        name: req.body.name,
        userId: req.userData.id,
    });
    deck
    .save()
    .then(result => {
        console.log(result);
        res.send({message: "Deck created!"})
    })
    .catch(next);
}

exports.delete_deck = function(req, res, next){
    Deck.findOne({_id: req.params.id})
    .exec()
    .then(result => {
        if(result.userId === req.userData.id){
            Deck.deleteOne({_id: req.params.id})
            .exec()
            .then(result => {
                res.send({message: result});
            })
            .catch(next);
        }else{
            res.status(401).send({message: "Failed to delete deck"});
        }
    })
    .catch(next);
}

exports.save_deck_content = function(req, res, next){
    Deck.findOne({_id: req.body.deckId})
    .exec()
    .then(result => {
        if(result.userId == req.userData.id){
            DeckContent.deleteMany({deckId: req.body.deckId})
            .exec()
            .then(resultAfterDeletion => {
                let body = req.body;
                let cards = body['cards'];
                let main = 0;
                let extra = 0;
                let side = 0;
                for(let card in cards){
                    if(cards[card]['place'] == 0){
                        main+=1;
                    }else if(cards[card]['place'] == 1){
                        extra+=1;
                    }else{
                        side+=1;
                    }
                    const deckContent = new DeckContent({
                        _id: new mongoose.Types.ObjectId(),
                        cardId: cards[card]['id'],
                        place: cards[card]['place'],
                        deckId: body['deckId']
                    });
                    deckContent.save().catch(next); //maybe await?
                }
                Deck.updateOne(
                    {_id: req.body.deckId},
                    { $set: { 
                        mainDeckCount: main, 
                        extraDeckCount: extra,
                        sideDeckCount: side
                    } },
                ).exec()
                .then(result => {
                    res.send({message: "Deck saved"});
                })
                .catch(next);
            })
            .catch(next);
        }else{
            res.status(500).send({message: "Failed to save deck"});
        }
    })
    .catch(next);
}