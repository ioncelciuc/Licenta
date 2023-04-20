const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const DeckContentSchema = new Schema({
    _id: mongoose.Schema.Types.ObjectId,
    deckId: {
        type: String,
        required: [true, "Deck ID is required"],
    },
    cardId: {
        type: String,
        required: [true, "Card ID is required"],
    },
    place: {
        type: Number,
        required: [true, "Card place is required. 0 - MAIN, 1 - EXTRA, 2 - SIDE"],
        min: 0,
        max: 2
    }
});

const DeckContent = mongoose.model('deck_content', DeckContentSchema);
module.exports = DeckContent;