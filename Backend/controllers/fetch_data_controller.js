const http = require('https');
const Buffer = require('buffer').Buffer;

const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');
const YuGiOhCardSet = require('../models/yugioh_cardset');
const YuGiOhArchetype = require('../models/yugioh_archetype');
const YuGiOhCard = require('../models/yugioh_card');
const YuGiOhImage = require('../models/yugioh_image');

exports.get_db_version = function (req, res, next) {
    var options = {
        host: 'db.ygoprodeck.com',
        path: '/api/v7/checkDBVer.php',
        method: 'GET'
    };
    http.request(options, function (response) {
        if (('' + response.statusCode).match(/^2\d\d$/)) {
            response.on('data', function (data) {
                var databaseVersion = JSON.parse(data);
                console.log('BODY: ' + data);
                YuGiOhDatabaseVersion.deleteMany({}).then(function (deletedData) {
                    YuGiOhDatabaseVersion.create(databaseVersion[0]).then(function (newVersion) {
                        res.send({
                            'deleted_data': deletedData,
                            'new_version': newVersion
                        })
                    })
                });
            });
        } else {
            res.status(500).send({ error: 'Internal Server Error' });
        }
    }).end();
}

exports.get_card_sets = function (req, res, next) {
    var options = {
        host: 'db.ygoprodeck.com',
        path: '/api/v7/cardsets.php',
        method: 'GET'
    };
    http.request(options, function (response) {
        if (('' + response.statusCode).match(/^2\d\d$/)) {
            var dataChunks = [];
            response.on('data', function (data) {
                dataChunks.push(data);
            });

            response.on('end', function () {
                var data = Buffer.concat(dataChunks);
                console.log('BODY: ' + data);

                var cardSets = JSON.parse(data);

                YuGiOhCardSet.deleteMany({}).then(function (deletedData) {
                    YuGiOhCardSet.insertMany(cardSets).then(function (newCardSets) {
                        res.send({
                            'deleted_data': deletedData,
                            'new_version': newCardSets
                        })
                    }).catch(next);
                }).catch(next);
            });
        } else {
            res.status(500).send({ error: 'Internal Server Error' });
        }
    }).end();
}

exports.get_archetypes = function (req, res, next) {
    var options = {
        host: 'db.ygoprodeck.com',
        path: '/api/v7/archetypes.php',
        method: 'GET'
    };
    http.request(options, function (response) {
        if (('' + response.statusCode).match(/^2\d\d$/)) {
            var dataChunks = [];
            response.on('data', function (data) {
                dataChunks.push(data);
            });

            response.on('end', function () {
                var data = Buffer.concat(dataChunks);
                console.log('BODY: ' + data);

                var archetypes = JSON.parse(data);

                YuGiOhArchetype.deleteMany({}).then(function (deletedData) {
                    YuGiOhArchetype.insertMany(archetypes).then(function (newArchetypes) {
                        res.send({
                            'deleted_data': deletedData,
                            'new_version': archetypes
                        })
                    }).catch(next);
                }).catch(next);
            });
        } else {
            res.status(500).send({ error: 'Internal Server Error' });
        }
    }).end();
}

exports.get_cards = function (req, res, next) {
    var options = {
        host: 'db.ygoprodeck.com',
        path: '/api/v7/cardinfo.php',
        method: 'GET'
    };
    console.log(options);
    var chIndex = 1;
    http.request(options, function (response) {
        if (('' + response.statusCode).match(/^2\d\d$/)) {
            var chunks = [];
            response.on('data', function (chunk) {
                chunks.push(chunk);
                console.log("Chunk number " + chIndex);
                chIndex += 1;
            });
            response.on('end', async function () {
                var data = JSON.parse(Buffer.concat(chunks).toString());
                var cardList = data["data"];
                console.log("NUMBER OF CARDS: " + cardList.length);
                console.log("READY FOR DB");
                YuGiOhCard.deleteMany({}).then(function (deletedData) {
                    console.log("deleted");
                    YuGiOhCard.insertMany(cardList).then(function (newCards) {
                        res.send({
                            'deleted_data': deletedData,
                            'new_version': newCards
                        })
                    }).catch(next);
                }).catch(next);
            });
        } else {
            res.status(500).send({ error: 'Internal Server Error' });
        }
    }).end();
}

exports.get_card_images = async function (req, res, next) {
    try {
        const resultDeletion = await YuGiOhImage.deleteMany({});
        const cardList = await YuGiOhCard.find({});
        for (i = 0; i < cardList.length; i++) {
            for (j = 0; j < cardList[i]['card_images'].length; j++) {
                console.log("Card number " + i + " image " + j);
                var imageId = cardList[i]['card_images'][j]['id'];
                console.log(imageId);
                var image = '';
                var image_small = '';
                var image_cropped = '';
                try {
                    image = await getImageInBase64(
                        '/images/cards/' + cardList[i]['card_images'][j]['id'] + '.jpg'
                    );
                } catch (e) {
                    console.log("error on image with id " + imageId + ' :' + e);
                }

                try {
                    image_small = await getImageInBase64(
                        '/images/cards/' + cardList[i]['card_images'][j]['id'] + '.jpg'
                    );
                } catch (e) {
                    console.log("error on image small with id " + imageId + ' :' + e);
                }

                try {
                    image_cropped = await getImageInBase64(
                        '/images/cards/' + cardList[i]['card_images'][j]['id'] + '.jpg'
                    );
                } catch (e) {
                    console.log("error on image cropped with id " + imageId + ' :' + e);
                }

                var img = {
                    id: imageId,
                    image_url: image,
                    image_url_small: image_small,
                    image_url_cropped: image_cropped,
                };
                
                try{
                    await YuGiOhImage.create(img);
                }catch(e){
                    console.log('error inserting into db: ' + e);
                }

                console.log("Inserted image with id: " + imageId);

            }
        }

        //ADDED THIS LINE
        res.send({message: "Images inserted in DB!"});
    } catch (e) {
        console.log(e);
        next(e);
    }
}

function getImageInBase64(imagePath) {
    return new Promise(function (resolve, reject) {
        var options = {
            host: 'images.ygoprodeck.com',
            path: imagePath,
            method: 'GET'
        };
        var req = http.request(options, function (response) {
            if (('' + response.statusCode).match(/^2\d\d$/)) {
                var chunks = [];
                response.on('data', function (chunk) {
                    chunks.push(chunk);
                });
                response.on('end', function () {
                    var buffer = Buffer.concat(chunks);
                    var base64Img = buffer.toString('base64');
                    resolve(base64Img);
                });
            } else {
                reject('Unable to get image');
            }
        });
        req.end();
    });
}

exports.get_image = function (req, res, next) {
    var options = {
        host: 'images.ygoprodeck.com',
        path: '/images/cards/6983839.jpg',
        method: 'GET'
    };
    http.request(options, function (response) {
        if (('' + response.statusCode).match(/^2\d\d$/)) {
            var chunks = [];
            response.on('data', function (chunk) {
                chunks.push(chunk);
            });
            response.on('end', function () {
                var buffer = Buffer.concat(chunks);
                var base64Img = buffer.toString('base64');
                res.setHeader('Content-Type', 'text/plain');
                res.send(buffer);
            });
        } else {
            res.status(500).send({ error: 'Internal Server Error' });
        }
    }).end();
}