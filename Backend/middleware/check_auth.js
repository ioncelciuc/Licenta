const jwt = require('jsonwebtoken');
require('dotenv').config();

module.exports = (req, res, next) => {
    try{
        const token = req.headers.authorization.split(' ')[1];
        const decodedToken = jwt.decode(token);
        console.log(decodedToken);
        const expirationDate = new Date(decodedToken.exp * 1000);
        console.log('Token expiration date:', expirationDate.toLocaleString());
        const decoded = jwt.verify(token, process.env.JWT_KEY);
        console.log(decoded);
        req.userData  = decoded;
        next();
    }catch(err){
        console.log(err);
        return res.status(401).send({'message': 'Auth Failed'});
    }

}