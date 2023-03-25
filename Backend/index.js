const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const app = express();

app.use(bodyParser.json());

app.use('/api', require('./routes/api'));

app.use(function(req, res){
    res.status(404).send({error: "Endpoint does not exist"});
});

app.use(function(err, req, res, next){
    console.log(err);
    res.status(422).send({error: err});
});

app.listen(process.env.port || 4000, function(){
    console.log('Server started!');
})