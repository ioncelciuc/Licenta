const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/user');
require('dotenv').config();

exports.signup = async function (req, res, next) {
    try {
        const user = await User.find({ username: req.body.username })
        if (user.length >= 1) {
            return res.status(409).send({ message: "User already exists" });
        }
        bcrypt.hash(req.body.password, 10, async (err, hash) => {
            if (err) {
                res.status(500).send({ error: err });
            } else {
                const user = new User({
                    _id: new mongoose.Types.ObjectId(),
                    username: req.body.username,
                    password: hash
                });
                const result = await user.save();
                console.log(result);
                res.status(201).send({ message: "User created" });
            }
        });
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.signin = async function (req, res, next) {
    try {
        const user = await User.find({ username: req.body.username })
        if (user.length < 1) {
            return res.status(401).send({ 'message': 'Sign in failed.' });
        }
        bcrypt.compare(req.body.password, user[0].password, (err, result) => {
            if (err) {
                return res.status(401).send({ 'message': 'Sign in failed.' });
            }
            if (result) {
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
            return res.status(401).send({ 'message': 'Sign in failed.' });
        });
    } catch (e) {
        console.log(e);
        next(e);
    }
}

exports.delete = async function (req, res, next) {
    try{
        console.log(req.userData);
        const result = await User.deleteOne({ username: req.userData.username });
        res.send({ message: result });
    }catch(e){
        console.log(e);
        next(e);
    }
}