// db_mysql.js

// let mysql = require('mysql');
// let db = require('./../json/config_db.json');

// let obj = {host: db.host, database: db.database, user: db.user, password: db.password}
// let connection = mysql.createConnection(obj);
// connection.connect(function(err) {
//     if (err) throw err;
// });

// module.exports = connection;

let mysql = require('mysql');
let db = require('./../json/config_db.json');

var pool = mysql.createPool({
    connectionLimit: 100,
    host: db.host,
    user: db.user,
    password: db.password,
    database: db.database,
    dateStrings: true
});

module.exports = pool;

// connection.getConnection(function(error, conn) {
//     if(error) {
//         conn.releae();
//         console.log('Error');
//     } else {
//         console.log('Connected..!');
//         module.exports = conn;
//     }
// });