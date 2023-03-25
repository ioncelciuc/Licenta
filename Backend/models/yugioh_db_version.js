const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const YuGiOhDatabaseVersionSchema = new Schema({
    database_version: {
        type: String,
        required: [true, 'database_version is required'],
    },
    last_update: {
        type: String,
        required: [true, 'last_update is required'],
    }
});

const YuGiOhDatabaseVersion = mongoose.model('database_version', YuGiOhDatabaseVersionSchema);
module.exports = YuGiOhDatabaseVersion;