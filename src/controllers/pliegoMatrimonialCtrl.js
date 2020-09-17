// religiososRouter.js
const express = require('express');
const router = express.Router();
const conn = require('../assets/js/db_mysql.js');

const  moment =require('moment');
moment.locale('es');

// const currentUser = state.User_Name;
router.get('/lastCode',  (req, res) => {
    console.log('religiosos/lastCode');
 
    let sql = "SELECT CAST(codReligioso AS UNSIGNED) AS codigo FROM religiosos ORDER BY codigo DESC LIMIT 1";
    conn.query(sql, function(err, rows){
        if(err){
            console.log('sqlMessage: ', err.sqlMessage);
            console.log('sql: ', err.sql);
            res.status(200).json({ status: false, msg: 'Insuccessfull', code:  '-1' });            
        }
        res.status(200).json({ status: true, msg: 'Successfull', code: rows[0].codigo+'' });
    });    
});
router.get('/', (req, res) => {
    let sql = 'SELECT apellidosNombres, codcargo FROM religiosos';
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
    let sql = `SELECT * FROM pliegomatrimonial WHERE activo='S' ORDER BY numeroExpediente`;
    conn.query(sql, function(err, rows){
        if(err) throw err;
        res.status(200).json(rows);
        // con.end();
    });

});
router.get('/Religiosos_min', (req, res) => {
    console.log('Religiosos/Religiosos_min');

    const sql = "SELECT codReligioso, apellidosNombres FROM religiosos WHERE activo = 'S' ORDER BY apellidosNombres";
    conn.query(sql, function(err, rows){
        if(err) throw err;
        res.status(200).json(rows);
        // res.send(rows);
        // conn.end();
    });
});
router.get('/all_rel', async (req, res) => {
    console.log('religiosos/all_rel');

    let sql ='CALL Religiosos_all_rel()';
    conn.query(sql, function(err, rows){
        if(err) console.log('err => ', err);
        res.status(200).json(rows)[0];
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
    console.log('/religiosos/create');
    // const {docLegalizacion, fechaDoc, codInstitucion, nombreInstitucion} = req.body;
    let data = req.body;
    let codReligioso = data.codReligioso;

    conn.query('INSERT INTO religiosos SET ?', [data], function(err, rows){
        if(err){
            console.log('sqlMessage: ', err.sqlMessage);
            console.log('sql: ', err.sql);
            res.json({status: false, msg: 'Unsucessfull', codReligioso: codReligioso, crud: 'create'});
        }else{
            console.log(rows);
            res.json({status: true, msg: 'Sucessfull', codReligioso: codReligioso, crud: 'create'});
        }
    })

});
// Update document
router.put('/update', (req, res) => {
    console.log('/religiosos/update');
    const data = req.body;
    const codReligioso = data.codReligioso;
    delete data.codReligioso;
    data.modificado = moment(data.modificado).format('YYYY-MM-DD hh:mm:ss');
    let sql = "UPDATE religiosos SET ? WHERE codReligioso = ?";
    // console.log('Data =>', data);    
    conn.query(sql, [data, codReligioso], function(err){
        if(err){
            console.log('sqlMessage: ', err.sqlMessage);
            console.log('sql: ', err.sql);
            res.json({status: false, msg: 'Unsucessfull', codReligioso: codReligioso, crud: 'update'});
        }else{
            res.json({status: true, msg: 'Sucessfull', codReligioso: codReligioso, crud: 'update'});
        }
    }); 
});

// Delete one document
// router.delete('/:id', (req, res) => {
router.delete('/delete', async (req, res) => {
    console.log('/religiosos/delete');
    const data = req.body;
    const codReligioso= data.codReligioso;
    data.activo = 'N'
    data.eliminado = moment(data.eliminado).format('YYYY-MM-DD hh:mm:ss');
    // let sql = 'DELETE FROM movimientoDocumento WHERE codInstitucion = ?';
    let sql = "UPDATE religiosos SET ? WHERE codReligioso = ?";
    conn.query(sql, [data, codReligioso], function(err){
        if(err){
            console.log('sqlMessage: ', err.sqlMessage);
            console.log('sql: ', err.sql);
            res.json({status: false, msg: 'Unsucessfull', codReligioso: codReligioso, crud: 'delete'});
        }else{
            res.json({status: true, msg: 'Sucessfull', codReligioso: codReligioso, crud: 'delete'});
        }
    }); 

});

module.exports = router;