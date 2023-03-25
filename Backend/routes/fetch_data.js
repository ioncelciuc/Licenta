const express = require('express');
const router = express.Router();
const http = require('https');
const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');

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
                YuGiOhDatabaseVersion.deleteMany({}).then(function(oldVersion){
                    YuGiOhDatabaseVersion.create(databaseVersion[0]).then(function(newVersion){
                        res.send({
                            'newVersion': newVersion
                        })
                    })
                });
            });
        } else {
            res.status(500).send({error: 'Internal Server Error'});
        }
    }).end();
});

module.exports = router