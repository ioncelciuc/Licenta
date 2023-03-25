const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const YuGiOhArchetypeSchema = new Schema({
    archetype_name: {
        type: String,
        required: [true, 'database_version is required'],
    }
});

const YuGiOhArchetype = mongoose.model('archetype', YuGiOhArchetypeSchema);
module.exports = YuGiOhArchetype;