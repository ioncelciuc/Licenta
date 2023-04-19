const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();
const checkAuth = require('../middleware/check_auth');

const User = require('../models/user');

router.post('/signup', function(req, res, next){
    User.find({username: req.body.username})
    .exec()
    .then(user => {
        if(user.length >= 1){
            res.status(409).send({message: "User already exists"});
        }else{
            bcrypt.hash(req.body.password, 10, (err, hash) => {
                if(err){
                    res.status(500).send({error: err});
                }else{
                    const user = new User({
                        _id: new mongoose.Types.ObjectId(),
                        username: req.body.username,
                        password: hash
                    });
                    user
                    .save()
                    .then(result => {
                        console.log(result);
                        res.status(201).send({message: "User created"});
                    })
                    .catch(err => {
                        console.log(err);
                        res.status(500).send({error: err});
                    });
                }
            });
        }
    });
});

router.post('/signin', function(req, res, next){
    User.find({username: req.body.username})
    .exec()
    .then(user => {
        if(user.length < 1){
            return res.status(401).send({'message': 'Sign in failed.'});
        }
        bcrypt.compare(req.body.password, user[0].password, (err, result) => {
            if(err){
                return res.status(401).send({'message': 'Sign in failed.'});
            }
            if(result){
                const token = jwt.sign({
                    'username': user[0].username,
                    'id': user[0]._id
                    },
                    process.env.JWT_KEY,
                    {
                        expiresIn: "1h"
                    }
                );
                return res.status(200).send({
                    'message': 'Sign in successfull',
                    'id': user[0]._id,
                    'username': user[0].username,
                    'token': token
                });
            }
            return res.status(401).send({'message': 'Sign in failed.'});
        });
    })
    .catch(next);
});

router.post('/delete', checkAuth , function(req, res, next){
    console.log(req.userData);
    User.deleteOne({username: req.body.username})
    .exec()
    .then(result => {
        res.send({message: result});
    })
    .catch(next);
});

module.exports = router;