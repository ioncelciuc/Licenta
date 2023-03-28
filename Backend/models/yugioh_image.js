const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const YuGiOhImageSchema = new Schema({
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
    }
});

const YuGiOhImage = mongoose.model('image', YuGiOhImageSchema);
module.exports = YuGiOhImage;