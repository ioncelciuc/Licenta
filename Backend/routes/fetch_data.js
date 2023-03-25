const express = require('express');
const router = express.Router();
const http = require('https');

const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');
const YuGiOhCardSet = require('../models/yugioh_cardset');

router.get('/db_version', function(req, res, next){ 
    var options = {
        host: 'db.ygoprodeck.com',
        path: '/api/v7/checkDBVer.php',
        method: 'GET'
    };
    http.request(options, function(response){
        if (('' + response.statusCode).match(/^2\d\d$/)) {
            response.on('data', function (data) {
                var databaseVersion = JSON.parse(data);
                console.log('BODY: ' + data); 
                YuGiOhDatabaseVersion.deleteMany({}).then(function(deletedData){
                    YuGiOhDatabaseVersion.create(databaseVersion[0]).then(function(newVersion){
                        res.send({
                            'deleted_data': deletedData,
                            'new_version': newVersion
                        })
                    })
                });
            });
        } else {
            res.status(500).send({error: 'Internal Server Error'});
        }
    }).end();
});

router.get('/card_sets', function(req, res, next){ 
    var options = {
        host: 'db.ygoprodeck.com',
        path: '/api/v7/cardsets.php',
        method: 'GET'
    };
    http.request(options, function(response){
        if (('' + response.statusCode).match(/^2\d\d$/)) {
            var dataChunks = [];
            response.on('data', function (data) {
                dataChunks.push(data);
            });

            response.on('end', function() {
                var data = Buffer.concat(dataChunks);
                console.log('BODY: ' + data); 
                
                var cardSets = JSON.parse(data);

                YuGiOhCardSet.deleteMany({}).then(function(deletedData){
                    YuGiOhCardSet.insertMany(cardSets).then(function(newCardSets){
                        res.send({
                            'deleted_data': deletedData,
                            'new_version': newCardSets
                        })
                    }).catch(next);
                }).catch(next);
            });
        } else {
            res.status(500).send({error: 'Internal Server Error'});
        }
    }).end();
});

module.exports = router