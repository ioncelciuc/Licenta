const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CardSetSchema = new Schema({
    set_name: {
        type: String
    },
    set_code: {
        type: String
    },
    set_rarity: {
        type: String
    },
    set_rarity_code: {
        type: String
    },
    set_price: {
        type: String
    },
});

const CardPrice = new Schema({
    cardmarket_price: {
        type: String
    },
    tcgplayer_price: {
        type: String
    },
    ebay_price: {
        type: String
    },
    amazon_price: {
        type: String
    },
    coolstuffinc_price: {
        type: String
    },
});

const BanlistInfoSchema = new Schema({
    ban_tcg: {
        type: String
    },
    ban_ocg: {
        type: String
    },
    ban_goat: {
        type: String
    },
});

const ImageSchema = new Schema({
    id: {
        type: String
    },
    image_url: {
        type: String
    },
    image_url_small: {
        type: String
    },
    image_url_cropped: {
        type: String
    },
});

const YuGiOhCardSchema = new Schema({
    //mandatory for all cards
    id: {
        type: Number,
        required: [true, 'id is required'],
    },
    name: {
        type: String,
        required: [true, 'name is required'],
    },
    type: {
        type: String,
        required: [true, 'type is required'],
    },
    frameType: {
        type: String,
        required: [true, 'frame type is required'],
    },
    desc: {
        type: String,
        required: [true, 'description is required'],
    },
    //monster-specific
    atk: {
        type: Number
    },
    def: {
        type: Number
    },
    level: {
        type: Number
    },
    attribute: {
        type: String
    },
    //spell & trap specific AND monster specific. Oficially called type
    race: {
        type: String
    },
    archetype: {
        type: String
    },
    //additional field for pendulum monsters
    scale: {
        type: Number
    },
    //additional fields for link monsters
    linkval: {
        type: Number
    },
    linkmarkers: [{
        type: String
    }],
    //rest of info
    card_sets:[{
        type: CardSetSchema
    }],
    card_prices:[{
        type: CardPrice
    }],
    banlist_info:{
        type: BanlistInfoSchema
    },
    card_images:[{
        type: ImageSchema
    }]
});

const YuGiOhCard = mongoose.model('card', YuGiOhCardSchema);
module.exports = YuGiOhCard;