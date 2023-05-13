const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const TranslationSchema = new Schema({
    id: {
        type: Number,
        required: [true, 'id is required'],
    },
    name: {
        type: String,
        required: [true, 'name is required'],
    },
    language_code: {
        type: String,
        required: [true, 'language code is required'],
    }
});

const Translation = mongoose.model('translation', TranslationSchema);
module.exports = Translation;