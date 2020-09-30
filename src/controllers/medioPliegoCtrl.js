// mediopliegoCtrl.js
const express = require('express');
const router = express.Router();
const conn = require('../assets/js/db_mysql.js');

const  moment =require('moment');
moment.locale('es');

// Get all documents
router.get('/all', (req, res) => {
    console.log('mediopliego/all');
    let sql = `SELECT *,
                  LEFT( CONCAT(apellidosNovia,', ',nombresNovia ), 70 ) AS Novia,
                  LEFT( CONCAT(apellidosNovio,', ',nombresNovio ), 70 ) AS Novio
                FROM mediopliego ORDER BY idMedioPliego`;
    conn.query(sql, function(err, rows){
        if(err) throw err;
        res.status(200).json(rows);
        // con.end();
    });

});
router.get('/mediopliego_min', (req, res) => {
    console.log('mediopliego/mediopliego_min');

    const sql = "SELECT numeroExpediente, apellidosNombres FROM mediopliego WHERE activo = 'S' ORDER BY apellidosNombres";
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
    console.log('/mediopliego/create');
    // const {docLegalizacion, fechaDoc, codInstitucion, nombreInstitucion} = req.body;
    let data = req.body;
    let numeroExpediente = data.numeroExpediente;

    conn.query('INSERT INTO mediopliego SET ?', [data], function(err, rows){
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
    console.log('/mediopliego/update');
    const data = req.body;
    const numeroExpediente = data.numeroExpediente;
    const idExpediente = data.idPMedioPliego;
    delete data.idPMedioPliego;
    data.modificado = moment(data.modificado).format('YYYY-MM-DD hh:mm:ss');
    let sql = "UPDATE mediopliego SET ? WHERE idPMedioPliego = ?";
    // console.log('Data =>', data);    
    conn.query(sql, [data, idExpediente], function(err){
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
    console.log('/mediopliego/delete');
    let data = req.body;
    let numeroExpediente= data.idPMedioPliego;
    let eliminado = moment(data.eliminado).format('YYYY-MM-DD hh:mm:ss');
    let eliminiado_usuario = data.eliminado_usuario;
    // let sql = 'DELETE FROM movimientoDocumento WHERE codInstitucion = ?';
    let sql = "UPDATE mediopliego SET activo = ?, eliminado = ?, eliminado_usuario = ? WHERE idPMedioPliego = ?";
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