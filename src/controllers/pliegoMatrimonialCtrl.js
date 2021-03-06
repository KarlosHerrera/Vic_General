// pliegomatrimonialCtrl.js
const express = require('express');
const router = express.Router();
const conn = require('../assets/js/db_mysql.js');

const  moment =require('moment');
moment.locale('es');

router.get('/', (req, res) => {
    let sql = 'SELECT apellidosNombres, codcargo FROM pliegomatrimonial';
    conn.query(sql, function(err, rows){
        if(err) throw err;
        // console.log('Type =', typeof(rows));
        // let filas = res.json(rows);
        // console.log('filas ===================================> ', filas);
        for( let i =0; i < rows.length ; i++ ){
            // console.log(i, rows[i].apellidosNombres);
        }
        res.status(500).json(rows);
        // con.end();
        //res.status(500).json([]);
        // res.status(200).json({ status: true, msg: 'Successfull'});
    });    
    // res.json({
    //     status: 'ok',
    //     crud: 'read all'
    // });
});
// Get all documents
router.get('/all', (req, res) => {
    console.log('pliegomatrimonial/all');
    let sql = `SELECT *,
                  LEFT( CONCAT(apellidosNovia,', ',nombresNovia ), 70 ) AS Novia,
                  LEFT( CONCAT(apellidosNovio,', ',nombresNovio ), 70 ) AS Novio
                FROM pliegomatrimonial ORDER BY idPMatrimonial`;
    conn.query(sql, function(err, rows){
        if(err) throw err;
        res.status(200).json(rows);
        // con.end();
    });

});
router.get('/pliegomatrimonial_min', (req, res) => {
    console.log('pliegomatrimonial/pliegomatrimonial_min');

    const sql = "SELECT numeroExpediente, apellidosNombres FROM pliegomatrimonial WHERE activo = 'S' ORDER BY apellidosNombres";
    conn.query(sql, function(err, rows){
        if(err) throw err;
        res.status(200).json(rows);
        // res.send(rows);
        // conn.end();
    });
});
// User verify 
router.post('/id', async (req, res) => {
    // let existUser = true;
    // console.log("router.post('/user)------>");
    // console.log('body = ', req.body);
    // let user = req.body.username;
    // user='user02';
    // console.log('users/user =>');
    // console.log('user = ', user);
 
    res.json({
        status: 'ok',
        crud: 'read one'
    });

});

// Create document
router.post('/create', async (req, res) => {
    console.log('/pliegomatrimonial/create');
    // const {docLegalizacion, fechaDoc, codInstitucion, nombreInstitucion} = req.body;
    let data = req.body;
    let numeroExpediente = data.numeroExpediente;

    conn.query('INSERT INTO pliegomatrimonial SET ?', [data], function(err, rows){
        if(err){
            console.log('sqlMessage: ', err.sqlMessage);
            console.log('sql: ', err.sql);
            res.json({status: false, msg: 'Unsucessfull', numeroExpediente: numeroExpediente, crud: 'create'});
        }else{
            console.log(rows);
            res.json({status: true, msg: 'Sucessfull', numeroExpediente: numeroExpediente, crud: 'create'});
        }
    })

});
// Update document
router.put('/update', (req, res) => {
    console.log('/pliegomatrimonial/update');
    const data = req.body;
    const numeroExpediente = data.idPMatrimonial;
    delete data.idPMatrimonial;
    data.modificado = moment(data.modificado).format('YYYY-MM-DD hh:mm:ss');
    let sql = "UPDATE pliegomatrimonial SET ? WHERE idPMatrimonial = ?";
    // console.log('Data =>', data);    
    conn.query(sql, [data, numeroExpediente], function(err){
        if(err){
            console.log('sqlMessage: ', err.sqlMessage);
            console.log('sql: ', err.sql);
            res.json({status: false, msg: 'Unsucessfull', numeroExpediente: numeroExpediente, crud: 'update'});
        }else{
            res.json({status: true, msg: 'Sucessfull', numeroExpediente: numeroExpediente, crud: 'update'});
        }
    }); 
});

// Delete one document
router.delete('/delete', async (req, res) => {
    console.log('/pliegomatrimonial/delete');
    let data = req.body;
    let numeroExpediente= data.idPMatrimonial;
    let eliminado = moment(data.eliminado).format('YYYY-MM-DD hh:mm:ss');
    let eliminiado_usuario = data.eliminado_usuario;
    // let sql = 'DELETE FROM movimientoDocumento WHERE codInstitucion = ?';
    let sql = "UPDATE pliegomatrimonial SET activo = ?, eliminado = ?, eliminado_usuario = ? WHERE idPMatrimonial = ?";
    conn.query(sql, ['N',eliminado,eliminiado_usuario,numeroExpediente], function(err){
        if(err){ 
            console.log('sqlMessage: ', err.sqlMessage);
            console.log('sql: ', err.sql);
            res.json({status: false, msg: 'Unsucessfull', numeroExpediente: numeroExpediente, crud: 'delete'});
        }else{
            res.json({status: true, msg: 'Sucessfull', numeroExpediente: numeroExpediente, crud: 'delete'});
        }
    }); 

});

module.exports = router;