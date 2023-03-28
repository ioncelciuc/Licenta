const AWS = require('aws-sdk');
const http = require('http');

router.get('/image', function (req, res, next) {
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
        var s3 = new AWS.S3();
        var params = {
          Bucket: 'your-bucket-name',
          Key: 'image.jpg',
          Body: buffer,
          ContentType: 'image/jpeg'
        };
        s3.upload(params, function (err, data) {
          if (err) {
            console.error(err);
            res.status(500).send({ error: 'Internal Server Error' });
          } else {
            console.log(data);
            res.setHeader('Content-Type', 'text/plain');
            res.send('Image uploaded to S3.');
          }
        });
      });
    } else {
      res.status(500).send({ error: 'Internal Server Error' });
    }
  }).end();
});
