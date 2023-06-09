const http = require('https');
const Buffer = require('buffer').Buffer;

const YuGiOhDatabaseVersion = require('../models/yugioh_db_version');
const YuGiOhCardSet = require('../models/yugioh_cardset');
const YuGiOhArchetype = require('../models/yugioh_archetype');
const YuGiOhCard = require('../models/yugioh_card');
const YuGiOhImage = require('../models/yugioh_image');
const Translation = require('../models/translation');

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

exports.get_translations = async function(req, res, next){
    var translations = [];
    try {
        console.log("Getting de cards");
        var deTranslations = await getTranslationForLanguage('de');
        console.log("Getting fr cards");
        var frTranslations = await getTranslationForLanguage('fr');
        console.log("Getting it cards");
        var itTranslations = await getTranslationForLanguage('it');
        console.log("Getting pt cards");
        var ptTranslations = await getTranslationForLanguage('pt');
        
        translations.push(...deTranslations);
        translations.push(...frTranslations);
        translations.push(...itTranslations);
        translations.push(...ptTranslations);

        Translation.deleteMany({}).then(function (deletedData) {
            console.log("deleted");
            Translation.insertMany(translations).then(function (newTranslations) {
                res.send({
                    'deleted_data': deletedData,
                    'new_version': newTranslations
                })
            }).catch(next);
        }).catch(next);
    } catch (error) {
        console.log(error);
        next(error);
    }
}

function getTranslationForLanguage(languageCode){
    return new Promise((resolve, reject) => {
        var options = {
            host: 'db.ygoprodeck.com',
            path: '/api/v7/cardinfo.php?language=' + languageCode,
            method: 'GET'
        };

        const request = http.request(options, function (response) {
            if (('' + response.statusCode).match(/^2\d\d$/)) {
                var chunks = [];
                response.on('data', function (chunk) {
                    chunks.push(chunk);
                });
                response.on('end', async function () {
                    var data = JSON.parse(Buffer.concat(chunks).toString());
                    var cards = data["data"];
                    var translations = [];
                    for (let index in cards) {
                        var translation = {
                            "id": cards[index]['id'],
                            "name": cards[index]['name'],
                            "language_code": languageCode,
                        };
                        translations.push(translation);
                    }
                    console.log("NUMBER OF CARDS IN " +  languageCode + ": " + translations.length);
                    resolve(translations);
                });
            } else {
                reject(new Error('Error on get translations in language ' + languageCode));
            }
        });

        request.on('error', (error) => {
            reject(error);
        });

        request.end();
    });
    // var options = {
    //     host: 'db.ygoprodeck.com',
    //     path: '/api/v7/cardinfo.php?language=' + languageCode,
    //     method: 'GET'
    // };
    // console.log(options);
    // // var chIndex = 1;
    // http.request(options, function (response) {
    //     if (('' + response.statusCode).match(/^2\d\d$/)) {
    //         var chunks = [];
    //         response.on('data', function (chunk) {
    //             chunks.push(chunk);
    //             // console.log("Chunk number " + chIndex);
    //             // chIndex += 1;
    //         });
    //         response.on('end', async function () {
    //             var data = JSON.parse(Buffer.concat(chunks).toString());
    //             var cards = data["data"];
    //             var translations = [];
    //             for(let index in cards){
    //                 // console.log(cards[index]);
    //                 var translation = {
    //                     "id": cards[index]['id'],
    //                     "name": cards[index]['name'],
    //                     "language_code": languageCode,
    //                 };
    //                 // console.log(translation);
    //                 translations.push(translation);
    //             }
    //             console.log("NUMBER OF CARDS IN " +  languageCode + ": " + translations.length);
    //             return translations;
    //         });
    //     } else {
    //         throw 'Error on get translations in language ' + languageCode;
    //         // res.status(500).send({ error: 'Internal Server Error' });
    //     }
    // }).end();
}

const bucketName = 'ygocompanion';
const userKey = 'AKIA226BUP5UUXWQOBE2';
const iamUserSecret = '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';

const AWS = require('aws-sdk');
const s3 = new AWS.S3({
    accessKeyId: userKey,
    secretAccessKey: iamUserSecret,
    Bucket: bucketName
});
const axios = require('axios');

async function downloadImage(url) {
    const response = await axios.get(url, {
      responseType: 'arraybuffer',
    });
    return response.data;
}

async function uploadToS3(bucketName, key, data) {
    const params = {
      Bucket: bucketName,
      Key: key,
      Body: data,
      ContentType: "image/jpeg"
    };
  
    return s3.upload(params).promise();
}

async function uploadImagesToS3Bucket(cardId){
    const imageUrl = 'https://images.ygoprodeck.com/images/cards/' + cardId + '.jpg';
    const imageUrlSmall = 'https://images.ygoprodeck.com/images/cards_small/' + cardId + '.jpg';
    console.log(imageUrl);
    console.log(imageUrlSmall);

    try{
        const imageFile = await downloadImage(imageUrl);
        const key = 'images/' + cardId + '.jpg';
        const result = await uploadToS3(bucketName, key, imageFile);
        console.log('Image uploaded successfully:', result.Location);
    }catch(e){
        console.log(`Failed to upload image with id: ${cardId}`);
        console.log(e);
    }
    
    try{
        const imageFileSmall = await downloadImage(imageUrlSmall);
        const keySmall = 'images_small/' + cardId + '.jpg';
        const resultSmall = await uploadToS3(bucketName, keySmall, imageFileSmall);
        console.log('Image uploaded successfully:', resultSmall.Location);
    }catch(e){
        console.log(`Failed to upload image small with id: ${cardId}`);
        console.log(e);
    }
}

exports.get_card_images = async function (req, res, next) {
    try {
        const cardList = await YuGiOhCard.find({});
        for (i = 0; i < cardList.length; i++) {
            const listOfImages = await YuGiOhImage.find({id: cardList[i].id});
            if(listOfImages.length > 0){
                console.log(`Card number ${i} with id ${cardList[i].id} already in image db`);
                continue;
            }
            
            //upload image to aws s3
            await uploadImagesToS3Bucket(cardList[i].id);

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
                        '/images/cards_small/' + cardList[i]['card_images'][j]['id'] + '.jpg'
                    );
                } catch (e) {
                    console.log("error on image small with id " + imageId + ' :' + e);
                }

                try {
                    image_cropped = await getImageInBase64(
                        '/images/cards_cropped/' + cardList[i]['card_images'][j]['id'] + '.jpg'
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
        res.send({message: "success"});
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