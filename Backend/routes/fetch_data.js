const express = require('express');
const router = express.Router();
const FetchDataController = require('../controllers/fetch_data_controller');

router.get('/db_version', FetchDataController.get_db_version);

router.get('/card_sets', FetchDataController.get_card_sets);

router.get('/archetypes', FetchDataController.get_archetypes);

router.get('/cards', FetchDataController.get_cards);

router.get('/card_images', FetchDataController.get_card_images);

router.get('/image', FetchDataController.get_image);

router.get('/translations', FetchDataController.get_translations);

module.exports = router