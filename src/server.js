// server.js
const express = require('express');
const mysql = require('mysql');
const serveStatic = require('serve-static')
const morgan = require('morgan');
const bodyparser = require("body-parser");
const path = require('path');
const cors = require('cors');
const moment = require('moment');
// var generator = require('generate-password'); // https://www.npmjs.com/package/generate-password
const app = express();


// Controladores
const pliegomatrimonialCtrl = require('./controllers/pliegoMatrimonialCtrl');
const licenciatrasladoCtrl = require('./controllers/licenciaTrasladoCtrl');
const dispensabautismalCtrl = require('./controllers/dispensaBautismalCtrl');

app.set('port', process.env.PORT || 3001);  // Configuracion de puerto (variables globales)

app.use('/', serveStatic(path.join(__dirname,'./../dist')));  // Carga 
// --- MIDDLEWARE ---
app.use(express.json());
app.use(morgan('dev'));
app.use(cors());
app.use(bodyparser.urlencoded({ extended: true }));
app.use(bodyparser.json());     // application/json
app.use(express.static(path.join(__dirname, './public')));


// Server routers-controllers
app.use('/pliegomatrimonial', pliegomatrimonialCtrl);
app.use('/licenciatraslado', licenciatrasladoCtrl);
app.use('/dispensabautismal', dispensabautismalCtrl);


// Settings


// 
const dbase = require('./assets/json/config_db.json');
const db = mysql.createConnection(dbase);
db.connect((err) => {
    if(err){
        console.log(err);
        console.log('Error connecting to DataBase');
    }else{
        console.log('host:', dbase.host);
        console.log('Connection mySQL successfull!');
        console.log('-----------------------------');
        db.end();
    }
});    

// let aplication = app.listen(app.get('port'), function(){
app.listen(app.get('port'), function(){
    console.log('->', moment().format('LLL') );
    // let host = aplication.address().address
    // let port = aplication.address().port
    console.log(`Server running at port: ${ app.get('port') } `);
    console.log('----------------------------');
}); // Listen on port defined in environment
