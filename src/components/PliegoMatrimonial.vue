// PliegoMatrimonial.vue
<template>
<div class="content">
  <div class="content-title">
        <div class='titulo_2 align_center' v-if='view_content'>Pliego Matrimonial</div>   
        <div class='titulo_2 align_center' v-if='!view_content'>{{title_detail}} - Pliego Matrimonial</div>
    <div class="headerTitle d-flex justify-content-between">
        <div class='d-flex justify-content-start align-items-center' v-if='view_content' >
            <button class='btn btn-sm btn_1 btn_new' @click='createItem'>Nuevo</button>
        </div>         

        <div class='d-flex justify-content-end' >  
            <filtra-tabla v-if='view_content' :recordList="ListRec" :colsSearch='searchReligioso' @filter_Process="filterProcess" ></filtra-tabla>
        </div>
    </div>    
  </div>
  <!-- List -->
  <div class='content-body table_overflow_y scroll_1 d-flex' v-if='view_content'>
    <table class='table table-sm table-bordered table-hover table_1'>
      <thead class='rounded-top'>
        <tr>
           <th>Cod.<span></span></th>
          <th>Religioso<span></span></th>
          <th>Jerarquia<span></span></th>
          <th>Direccion<span></span></th>
          <th class='text-center'>Opciones</th>
        </tr>
      </thead>
      <tbody id='bodyTable' class='' >
        <tr v-for="(doc, index) in tmpListRec" :key='index' @dblclick='detalleItem(index)' @mouseover='itemFocus(index)' @blur='itemBlur'>
          <td> {{ doc.codReligioso}} </td>
          <td> {{ doc.apellidosNombres | frmLongMaxima(40) }} </td>
          <td> {{ doc.nombreJerarquia | frmLongMaxima(15) }} </td>
          <td> {{ doc.direccion | frmLongMaxima(30) }} </td>
          <td class=' d-flex justify-content-center align-items-center'>
            <button class='btn btn-sm btn_actions btn_1' @click='updateItem(index)' :disabled="doc.activo=='N'" :class="{void_Btn: doc.activo=='N'}">Editar</button>
            <button class='btn btn-sm btn_actions btn_1' @click='deleteItem(index)' :disabled="doc.activo=='N'" :class="{void_Btn: doc.activo=='N'}">Anular</button>
            <button class='btn btn-sm btn_actions btn_1' @click='firmasItem(index)' :disabled="doc.activo=='N'" :class="{void_Btn: doc.activo=='N'}">Firmas <span class="badge badge-light num-firmas"> {{ doc.num_firmas }} </span></button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  <!-- Detail -->
  <div class='detailRecord d-flex' v-else>
    <div class='col-12 content-form d-flex flex-column table_overflow_y scroll_1'>
      <form id='formReligioso' class='formBase' onsubmit="return false;" novalidate autocomplete="nope" data-btnEnable='btnSave'>
          <div class="form-row">
              <div class="col-2 form-group">
                  <label for="expediente" class="formControlLabel">Expediente*</label>
                    <input type="text" name='expediente' v-model="rec.expediente" class="form-control form-control-sm" 
                      ref='expediente' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ -.\/]{1,59}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>  
              <div class="col-2 form-group">
                  <label for="fechaExpediente" class="formControlLabel">Fecha*</label>
                    <input type="text" name='fechaExpediente' v-model="rec.fechaExpediente" class="form-control form-control-sm" 
                      ref='fechaExpediente' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ -.\/]{1,59}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>
              <div class="col-8 form-group">
                  <label for="diocesisOrigen" class="formControlLabel">Diocesis-Origen*</label>
                    <input type="text" name='diocesisOrigen' v-model="rec.diocesisOrigen" class="form-control form-control-sm" 
                      ref='diocesisOrigen' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
          </div>             
 
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="parroquiaCelebracion" class="formControlLabel">Parroquia-Celebracion*</label>
                    <input type="text" name='parroquiaCelebracion' v-model="rec.parroquiaCelebracion" class="form-control form-control-sm" 
                      ref='parroquiaCelebracion' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>          
          </div>  
          <div class="form-row">
              <div class="col-6 form-group">
                  <label for="apellidosNovia" class="formControlLabel">Apellidos-Novia*</label>
                    <input type="text" name='apellidosNovia' v-model="rec.apellidosNovia" class="form-control form-control-sm" 
                      ref='apellidosNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-6 form-group">
                  <label for="nombresNovia" class="formControlLabel">Nombres-Novia*</label>
                    <input type="text" name='nombresNovia' v-model="rec.nombresNovia" class="form-control form-control-sm" 
                      ref='nombresNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div>     
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="direccionNovia" class="formControlLabel">Direccion-Novia*</label>
                    <input type="text" name='direccionNovia' v-model="rec.direccionNovia" class="form-control form-control-sm" 
                      ref='direccionNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>          
          </div>  
          <div class="form-row">
              <div class="col-6 form-group">
                  <label for="padreNovia" class="formControlLabel">Padre-Novia*</label>
                    <input type="text" name='padreNovia' v-model="rec.padreNovia" class="form-control form-control-sm" 
                      ref='padreNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-6 form-group">
                  <label for="madreNovia" class="formControlLabel">Madre-Novia*</label>
                    <input type="text" name='madreNovia' v-model="rec.madreNovia" class="form-control form-control-sm" 
                      ref='madreNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div> 
          <div class="form-row">
              <div class="col-2 form-group">
                  <label for="bautizoNovia" class="formControlLabel">Bautizo-Novia*</label>
                    <input type="text" name='bautizoNovia' v-model="rec.bautizoNovia" class="form-control form-control-sm" 
                      ref='bautizoNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-10 form-group">
                  <label for="parroquiaBautizoNovia" class="formControlLabel">Parroquia Bautizo-Novia*</label>
                    <input type="text" name='parroquiaBautizoNovia' v-model="rec.parroquiaBautizoNovia" class="form-control form-control-sm" 
                      ref='parroquiaBautizoNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div> 
          <div class="form-row">
              <div class="col-6 form-group">
                  <label for="apellidosNovio" class="formControlLabel">Apellidos-Novio*</label>
                    <input type="text" name='apellidosNovia' v-model="rec.apellidosNovio" class="form-control form-control-sm" 
                      ref='apellidosNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-6 form-group">
                  <label for="nombresNovio" class="formControlLabel">Nombres-Novio*</label>
                    <input type="text" name='nombresNovia' v-model="rec.nombresNovio" class="form-control form-control-sm" 
                      ref='nombresNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div>   
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="direccionNovio" class="formControlLabel">Direccion-Novio*</label>
                    <input type="text" name='direccionNovio' v-model="rec.direccionNovio" class="form-control form-control-sm" 
                      ref='direccionNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>          
          </div> 
          <div class="form-row">
              <div class="col-6 form-group">
                  <label for="padreNovio" class="formControlLabel">Padre-Novio*</label>
                    <input type="text" name='padreNovia' v-model="rec.padreNovio" class="form-control form-control-sm" 
                      ref='padreNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-6 form-group">
                  <label for="madreNovio" class="formControlLabel">Madre-Novio*</label>
                    <input type="text" name='madreNovia' v-model="rec.madreNovio" class="form-control form-control-sm" 
                      ref='madreNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div> 
          <div class="form-row">
              <div class="col-2 form-group">
                  <label for="matrimonioCivil" class="formControlLabel">Matrimonio-Civil*</label>
                    <input type="date" name='matrimonioCivil' v-model="rec.matrimonioCivil" class="form-control form-control-sm" 
                      ref='matrimonioCivil' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-2 form-group">
                  <label for="matrimonioReligioso" class="formControlLabel">Matrimonio-Religioso*</label>
                    <input type="date" name='matrimonioReligioso' v-model="rec.matrimonioReligioso" class="form-control form-control-sm" 
                      ref='matrimonioReligioso' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>
              <div class="col-2 form-group">
                  <label for="fechaAutorizacion" class="formControlLabel">Fecha-Autorizacion*</label>
                    <input type="date" name='fechaAutorizacion' v-model="rec.fechaAutorizacion" class="form-control form-control-sm" 
                      ref='fechaAutorizacion' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                                    
          </div> 
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="vicario" class="formControlLabel">Vicario*</label>
                    <input type="text" name='vicario' v-model="rec.vicario" class="form-control form-control-sm" 
                      ref='vicario' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>    
          </div>  
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="cabecera1" class="formControlLabel">Cabecera 1</label>
                  <input type="text" name='cabecera1' v-model="rec.cabecera1" class="form-control form-control-sm"
                      ref='cabecera1' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Za-z0-9%+-]+@[A-Za-z0-9-]+.+.[A-Za-z]{2,4}$" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
          </div> 
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="cabecera2" class="formControlLabel">Cabecera 2</label>
                  <input type="text" name='cabecera2' v-model="rec.cabecera2" class="form-control form-control-sm"
                      ref='cabecera2' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Za-z0-9%+-]+@[A-Za-z0-9-]+.+.[A-Za-z]{2,4}$" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
          </div> 

          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="observaciones" class="formControlLabel">Observaciones</label>
                  <input type="text" name='observaciones' v-model="rec.observaciones" class="form-control form-control-sm"
                      ref='observaciones' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Za-z0-9%+-]+@[A-Za-z0-9-]+.+.[A-Za-z]{2,4}$" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
          </div> 
      </form> 
    </div>
  </div>
  <opciones-crud v-if='!view_content' class='row crud' :crud="crud" @confirm_Create="confirmCreate" @confirm_Update="confirmUpdate" @confirm_Delete="confirmDelete" @exit_Form="exitForm" @reset_Form='resetForm'></opciones-crud>
  <div class="content-footer align-items-end"  v-if='view_content'>
    <div class='itemCurrent '>Items: {{ itemCurrent}}/{{tmpListRec.length}} </div>
  </div>
</div>
</template>

<script>
console.log('<< PliegoMatrimonial.vue >>');

const idForm = 'formExpediente';

import opcionesCrud from '@/components/opciones-crud.vue'

import axios from 'axios';
// import { disabledForm, disabledElementId } from '@/assets/js/lib';
import { evalInput, evalString, evalValue } from '@/assets/js/form';

import moment from 'moment';
moment.locale('es');

import Swal from 'sweetalert2';
let optAlert = require('@/assets/json/opt_swal2.json');
const swal2 = Swal.mixin(optAlert);

import { mapState } from 'vuex';

export default {
  name: 'PliegoMatrimonial',
  components: {
    opcionesCrud,
  },  
  data(){
    return {
      ListRec: [],
      tmpListRec: [],
      rec: {},
      crud: '',
      title_detail: '',
      // lenguaje: es,
      fechaHoy: new Date(),   // UTCs     
      searchReligioso: ['codReligioso','apellidosNombres','nombreJerarquia','direccion'],
      view_content: true,
      itemCurrent: 0,
      observacionesCrud: '',
      disabledForm: true
    }
  },  
  computed: { // Expone state al template
     ...mapState(['host']), 
  },
  methods: {
    setComponent(){
    //   let ruta = require('./../assets/json/config_img.json');
    //   this.pathImg = ruta.pathFirmas;
    //   if( !this.datosReligioso.crud ) { this.verAddImg= false, this.verDelImg = false }      
    },
    list_view(){
       
      if( this.crud == 'C' ) {
        this.title_detail = 'Nuevo'; 
        // this.resetForm();
        this.disabledForm = false;
        this.generaCodigo();
      }
      if( this.crud == 'R' ) this.title_detail = 'Datos';           
      if( this.crud == 'U' ) this.title_detail = 'Edita';
      if( this.crud == 'D' ) this.title_detail = 'Anula' ;
      if( this.crud == 'R' ) {
        // disabledElementId('btnSellos', false);
        this.disabledForm = true;
        this.load_relation();
      }
      if( this.crud == 'U') {
        // disabledElementId('codReligioso', true);
        this.disabledForm = false;
        // disabledForm(idForm, true, ['codReligioso']); // atributo 'name'
        this.load_relation();
      }
      if( this.crud == 'D' ) {
        // disabledForm(idForm, true); // atributo 'name'
        this.disabledForm = true;
        this.load_relation();
      }
        this.view_content = false;

    },
    load_relation(){
      // this.selDepartamento(this.rec.codDepartamento);
      // this.selProvincia(this.rec.codProvincia);
    },
    resetForm: function(){
      this.$refs[idForm].reset();
    },
    evaluaItem(){
      // let objForm = document.getElementById(idForm);
      // console.dir(objForm);
      let obs='';
      let evaluacion = true;
      // if( !evalValue('codReligioso') ) { obs+='*Codigo '; evaluacion = false}
      if( !evalValue('apellidosNombres') ) { obs+=' *Nombre '; evaluacion = false}
      if( !evalString(this.rec.codJerarquia) ) {obs+=' *Jerarquia'; evaluacion = false}
      if( !evalString(this.rec.codDepartamento) ) {obs+=' *Departamento'; evaluacion = false}
      if( !evalString(this.rec.codProvincia) ) {obs+=' *Provincia'; evaluacion = false}
      if( !evalString(this.rec.codDistrito) ) {obs+=' *Distrito'; evaluacion = false}
      if( !evalValue('telefono1') ) {obs+=' *Telefono 1'; evaluacion = false}
      if( !evalValue('telefono2') ) {obs+=' *Telefono 2'; evaluacion = false}
      if( !evalValue('movil') ) {obs+=' *Movil'; evaluacion = false;}
      if( !evalValue('email') ) {obs+=' *Correo'; evaluacion = false;}
      this.observacionesCrud = obs;
      return evaluacion;
    },
    detalleItem(index){
      console.log(`detalleItem(${index})`);
      this.crud = 'R';
      this.rec = this.tmpListRec[index];
      this.list_view();
    },
    createItem(){
      // console.log('createItem()');
      this.crud = 'C';
      this.rec = {}
      this.list_view();
    },
    confirmCreate: async function(){
      // console.log('confirmCreate()');
      let title = 'Nuevo Religioso';

      if ( !this.evaluaItem() ) { 
        swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        this.rec.creado_usuario = this.$store.state.User_Name;
        let url = this.host+'/ListRec/create';
        // console.log('url = ', url);
        let options = {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.rec)
        };
        try {
          let data = await fetch(url, options);
          let res = await data.json();
          let text = (res.status)? 'Creado Satisfactoriamente!': 'Fallo Creacion!'; 
          if( res.status ) this.loadListRec();
          await swal2.fire({ title: 'Nuevo Religioso: ', text: text });
          this.exitForm();    // Componente padre
        } catch (error) {
            console.log('Error:', error);
        }    
      }    
    },
    updateItem(index){
      // console.log('updateItem()');
      this.crud = 'U';
      this.rec = this.tmpListRec[index];
      this.list_view();
    },
    confirmUpdate: async function(){
      // console.log('confirmUpdate()');
      let title = 'Edita Religioso';
      if ( !this.evaluaItem() ) { 
        await swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        // swal2.fire({title: title, text: 'Datos OK.'});
        let data = {  
          codReligioso: this.rec.codReligioso, 
          apellidosNombres: this.rec.apellidosNombres,
          direccion: this.rec.direccion,
          codJerarquia: this.rec.codJerarquia,
          codDepartamento: this.rec.codDepartamento,
          codProvincia: this.rec.codProvincia,          
          codDistrito: this.rec.codDistrito,
          telefono1: this.rec.telefono1,
          telefono2: this.rec.telefono2,
          movil: this.rec.movil,
          email: this.rec.email,
          modificado: new Date(),
          modificado_usuario: this.$store.state.User_Name
        };  
        // console.log('data: ', data)
        let url = this.host+'/ListRec/update';
        let options = {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data)
        };
        try {
          let text = '';
          let data = await fetch(url, options);
          let res = await data.json();
          if( res.status ) this.loadListRec();
          text = (res.status)? 'Modificado Satisfactoriamente.': 'Fallo modificacion!';
            await swal2.fire({title: title, text: text});
          this.exitForm();
        } catch (error) {
          console.log('Error:', error);
        }
      }

    },
    deleteItem(index){
      // console.log('deleteItem()');
      this.crud = 'D';
      this.rec = this.tmpListRec[index];
      this.list_view();
    },
    confirmDelete: async function(){
      // console.log('confirmDelete()');
      let title = 'Anula Religioso';
      
      this.rec.eliminado = new Date();
      this.rec.eliminado_usuario =  this.$store.state.User_Name;
      let url = this.host+'/ListRec/delete';
      let options = {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(this.rec)
      };
      try {
        let text = '';
        let data = await fetch(url, options);
        let res = await data.json();
        if( res.status ) this.loadListRec();          
        text = (res.status)? 'Anulado Satisfactoriamente!': 'Fallo la anulacion!';
        await swal2.fire({title: title, text: text});
        // disabledForm(idForm, false);
        this.exitForm();
      } catch (error) {
        console.log('Error:', error);
      }

    },
    cierraFirmasCrud(value){
      console.log(`cierraFirmasCrud(${value})`);
      this.verFirmasCrud=false;
      if( value ) this.loadListRec();

    },    
    async loadListRec(){
      // console.log('loadInstituciones()');
      let url = this.host+'/pliegomatrimonial/all';
      let options = {
          method: 'GET',
          headers: { 'Content-Type': 'application/json' },
      };
      try {
          let data = await fetch(url, options);
          let res = await data.json();
          console.log(res)
          this.ListRec = res;
          this.tmpListRec = res;
      } catch (error) {
          console.log('Error:', error);
      }      

    },
    input: function(self){
      evalInput(self);
    },
    exitForm: function(){
        this.view_content = true;
    }, 
    generaCodigo: async function(){
      console.log('generaCodigo()');
      let self = this;
      let url = this.host+'/ListRec/lastCode';
      await axios.get(url)
      .then(function(response){ 
        let code = parseInt(response.data.code, 10) + 1;
        self.rec.codReligioso =  code+'';
        console.log('code=>', self.rec.codReligioso);
      })
      .catch(function(error) {
        console.log(error);
        return '-1';
      })
    },       
    itemFocus(index){
      this.itemCurrent = index+1;
    },
    itemBlur(){
      this.itemCurrent = 0;
    },    
    filterProcess: function(value){
      // console.log('value = ', value);
      this.tmpListRec = value;
    }    
  },
   // Hooks
  created: function(){
    this.loadListRec();
  },
  mounted: function(){
    this.setComponent();
  }   
}
</script>

<style scoped src='@/assets/css/table.css'></style>
<style scoped src='@/assets/css/form.css'></style>
<style scoped src='@/assets/css/scroll_bar.css'></style>
<style scoped src="@/assets/css/crudTables.css"></style>

<style scoped>
.content-form {
  height: 550px;
  /* height: 20%; */
  
}
.crud {
 margin-top: 3px;
}
</style>
