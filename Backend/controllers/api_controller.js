const mongoose = require('mongoose');

const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');
const YuGiOhCardSet = require('../models/yugioh_cardset');
const YuGiOhArchetype = require('../models/yugioh_archetype');
const YuGiOhCard = require('../models/yugioh_card');
const YuGiOhImage = require('../models/yugioh_image');

const Deck = require('../models/deck');
const DeckContent = require('../models/deck_content');

exports.get_db_version = async function(req, res, next){
    try{
        const dbVersion = await YuGiOhDatabaseVersion.find({})
        res.send(dbVersion);
    }catch(e){
        console.log(e);
        next(e);
    }
}

exports.get_card_sets = async function(req, res, next){
    try{
        const cardSets = await YuGiOhCardSet.find({});   
        res.send(cardSets); 
    }catch(e){
        console.log(e);
        next(e);
    }
}

exports.get_archetypes = async function(req, res, next){
    try {
        const archetypes = await YuGiOhArchetype.find({});
        res.send(archetypes);
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.get_cards = async function(req, res, next){
    try {
        const cards = await YuGiOhCard.find({});
        res.send(cards);
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.get_all_images_by_id = async function(req, res, next){
    try {
        const images = await YuGiOhImage.find({id: req.params.id});
        res.send(images);
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.get_image_by_id = async function(req, res, next){
    try {
        const image = await YuGiOhImage.find({id: req.params.id}, {id: 1, image_url: 1});
        res.send(image);
    } catch (e) {
        console.log(e);
        next(e);        
    }
}

exports.get_image_small_by_id = async function(req, res, next){
    try {
        const image = await YuGiOhImage.find({id: req.params.id}, {id: 1, image_url_small: 1});
        res.send(image);
    } catch (e) {
        console.log(e);
        next(e);        
    }
}

exports.get_image_cropped_by_id = async function(req, res, next){
    try {
        const image = await YuGiOhImage.find({id: req.params.id}, {id: 1, image_url_cropped: 1});
        res.send(image); 
    } catch (e) {
        console.log(e);
        next(e);        
    }
}

exports.create_deck = async function(req, res, next){
    try {
        const deck = new Deck({
            _id: new mongoose.Types.ObjectId(),
            name: req.body.name,
            userId: req.userData.id,
        });
        const result = await deck.save();
        console.log(result);
        res.send({message: "Deck created!"})
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.delete_deck = async function(req, res, next){
    try {
        let userId = req.userData.id;
        const deck = await Deck.findOne({_id: req.params.id});
        if(deck.userId === userId){
            await Deck.deleteOne({_id: req.params.id});
            await DeckContent.deleteMany({deckId: req.params.id});
            res.send({message: "Deck deleted successfully"});
        }else{
            res.status(401).send({message: "Failed to delete deck"});
        }
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.save_deck_content = async function(req, res, next){
    try {
        const deck = await Deck.findOne({_id: req.body.deckId});
        if(deck.userId == req.userData.id){
            const resultAfterDeletion = await DeckContent.deleteMany({deckId: req.body.deckId});
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
                const saveResult = await deckContent.save();
            }
            const resultUpdateDeckCount = await Deck.updateOne(
                {_id: req.body.deckId},
                { $set: { 
                    mainDeckCount: main, 
                    extraDeckCount: extra,
                    sideDeckCount: side
                } },
            );
            res.send({message: "Deck saved"});
        }else{
            res.status(500).send({message: "Failed to save deck"});
        }
    } catch (e) {
        console.log(e);
        next(e);        
    }
}

exports.get_user_decks = async function(req, res, next){
    try {
        let uid = req.userData.id;
        const decks = await Deck.find({userId: uid});
        res.send(decks);
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.get_cards_from_deck = async function(req, res, next){
    try {
        let uid = req.userData.id;
        const deck = await Deck.findOne({_id: req.params.id});
        if(deck.userId === uid){
            const cards = await DeckContent.find({deckId: req.params.id});
            res.send(cards);
        }else{
            res.send({error: "No deck found with this ID"});
        }
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.empty_deck = async function(req, res, next){
    try {
        let uid = req.userData.id;
        const deck = await Deck.findOne({_id: req.params.id});
        if(deck.userId === uid){
            const result = await DeckContent.deleteMany({deckId: req.params.id});
            res.send({message: result});
        }else{
            res.send({error: "No deck found with this ID"});
        }
    } catch (e) {
        console.log(e);
        next(e);
    }
}