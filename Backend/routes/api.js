const express = require('express');
const router = express.Router();
const ApiController = require('../controllers/api_controller');
const checkAuth = require('../middleware/check_auth');

router.get('/db_version', ApiController.get_db_version);

router.get('/card_sets', ApiController.get_card_sets);

router.get('/archetypes', ApiController.get_archetypes);

router.get('/cards', ApiController.get_cards);

router.get('/images/:id', ApiController.get_all_images_by_id);

router.get('/image/:id', ApiController.get_image_by_id);

router.get('/image_small/:id', ApiController.get_image_small_by_id);

router.get('/image_cropped/:id', ApiController.get_image_cropped_by_id);

router.post('/create_deck', checkAuth, ApiController.create_deck);

router.delete('/delete_deck/:id', checkAuth, ApiController.delete_deck);

router.post('/save_deck_content', checkAuth, ApiController.save_deck_content);

module.exports = router;