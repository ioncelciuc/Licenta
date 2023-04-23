const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const RawImageSchema = new Schema({
    id: {
        type: String
    },
    image: {
        data: Buffer,
        contentType: String
    }
});

const RawImage = mongoose.model('raw_image', RawImageSchema);
module.exports = RawImage;