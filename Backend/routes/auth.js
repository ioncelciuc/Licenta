const express = require('express');
const router = express.Router();
const AuthController = require('../controllers/auth_controller');
const checkAuth = require('../middleware/check_auth');

router.post('/signup', AuthController.signup);

router.post('/signin', AuthController.signin);

router.post('/delete', checkAuth , AuthController.delete);

module.exports = router;