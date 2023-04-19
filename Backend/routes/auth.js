const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

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
                        res.status(201).send({message: "user created"});
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

module.exports = router;