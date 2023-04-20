const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const DeckSchema = new Schema({
    _id: mongoose.Schema.Types.ObjectId,
    userId: {
        type: String,
        required: [true, 'User ID is required'],
    },
    name: {
        type: String,
        required: [true, "Deck name is required"],
    },
    cardArt: {
        type: String
    },
    mainDeckCount: {
        type: Number,
        default: 0,
        min: 0,
        max: 60
    },
    extraDeckCount: {
        type: Number,
        default: 0,
        min: 0,
        max: 15
    },
    sideDeckCount: {
        type: Number,
        default: 0,
        min: 0,
        max: 15
    },
});

const Deck = mongoose.model('deck', DeckSchema);
module.exports = Deck;