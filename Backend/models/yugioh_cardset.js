const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const YuGiOhCardSetSchema = new Schema({
    set_name: {
        type: String,
        required: [true, 'set_name is required'],
    },
    set_code: {
        type: String,
        required: [true, 'set_code is required'],
    },
    num_of_cards: {
        type: Number,
        required: [true, 'num_of_cards is required'],
    },
    tcg_date: {
        type: String,
    },
});

const YuGiOhCardSet = mongoose.model('card_set', YuGiOhCardSetSchema);
module.exports = YuGiOhCardSet;