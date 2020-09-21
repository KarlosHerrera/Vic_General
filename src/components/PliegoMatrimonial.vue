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
            <filtra-tabla v-if='view_content' :recordList="ListRec" :colsSearch='searchExpediente' @filter_Process="filterProcess" ></filtra-tabla>
        </div>
    </div>    
  </div>
  <!-- List -->
  <div class='content-body table_overflow_y scroll_1 d-flex' v-if='view_content'>
    <table class='table table-sm table-bordered table-hover table_1'>
      <thead class='rounded-top'>
        <tr>
          <th>Expediente<span></span></th>
          <th class="align_center">Fecha<span></span></th>          
          <th>Novia<span></span></th>
          <th>Novio<span></span></th>
          <th>Parroquia-Celebracion<span></span></th>
          <th class='text-center'>Opciones</th>
        </tr>
      </thead>
      <tbody id='bodyTable' class='' >
        <tr v-for="(doc, index) in tmpListRec" :key='index' @dblclick='detalleItem(index)' @mouseover='itemFocus(index)' @blur='itemBlur'>
          <td> {{ doc.numeroExpediente}} </td>
          <td class='align_center'> {{ doc.fechaExpediente | frmFecha }} </td>
          <td> {{ doc.Novia }} </td>
          <td> {{ doc.Novio }} </td>
          <td> {{ doc.parroquiaCelebracion }} </td>
          <td class=' d-flex justify-content-center align-items-center'>
            <button class='btn btn-sm btn_actions btn_1' @click='updateItem(index)' :disabled="doc.activo=='N'" :class="{void_Btn: doc.activo=='N'}">Editar</button>
            <button class='btn btn-sm btn_actions btn_1' @click='deleteItem(index)' :disabled="doc.activo=='N'" :class="{void_Btn: doc.activo=='N'}">Anular</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  <!-- Detail -->
  <div class='detailRecord d-flex' v-else>
    <div class='col-12 content-form d-flex flex-column table_overflow_y scroll_1'>
      <form id='formExpediente' ref='formExpediente' class='formBase' onsubmit="return false;" novalidate autocomplete="nope" data-btnEnable='btnSave'>
          <div class="form-row">
              <div class="col-2 form-group">
                  <label for="numeroExpediente" class="formControlLabel">Expediente*</label>
                    <input type="text" name='numeroExpediente' v-model="rec.numeroExpediente" class="form-control form-control-sm" 
                      ref='numeroExpediente' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_numeroExpediente" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>  
              <div class="col-2 form-group">
                  <label for="fechaExpediente" class="formControlLabel">Fecha*</label>
                    <input type="date" name='fechaExpediente' v-model="rec.fechaExpediente" class="form-control form-control-sm" 
                      ref='fechaExpediente' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
              <div class="col-8 form-group">
                  <label for="diocesisOrigen" class="formControlLabel">Diocesis-Origen*</label>
                    <input type="text" name='diocesisOrigen' v-model="rec.diocesisOrigen" class="form-control form-control-sm" 
                      ref='diocesisOrigen' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_diocesis" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
          </div>  

          <div class="form-row">
              <div class="col-2 form-group">
                <inputFecha></inputFecha>
              </div>          
          </div>           

          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="parroquiaCelebracion" class="formControlLabel">Parroquia-Celebracion*</label>
                    <input type="text" name='parroquiaCelebracion' v-model="rec.parroquiaCelebracion" class="form-control form-control-sm" 
                      ref='parroquiaCelebracion' :pattern="er_parroquia" required :disabled="disabledForm"
                      @input="input($event.target)" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>          
          </div>  
          <div class="form-row">
              <div class="col-6 form-group">
                  <label for="apellidosNovia" class="formControlLabel">Apellidos-Novia*</label>
                    <input type="text" name='apellidosNovia' v-model="rec.apellidosNovia" class="form-control form-control-sm" 
                      ref='apellidosNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-6 form-group">
                  <label for="nombresNovia" class="formControlLabel">Nombres-Novia*</label>
                    <input type="text" name='nombresNovia' v-model="rec.nombresNovia" class="form-control form-control-sm" 
                      ref='nombresNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div>     
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="direccionNovia" class="formControlLabel">Direccion-Novia*</label>
                    <input type="text" name='direccionNovia' v-model="rec.direccionNovia" class="form-control form-control-sm" 
                      ref='direccionNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_direccion" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>          
          </div>  
          <div class="form-row">
              <div class="col-6 form-group">
                  <label for="padreNovia" class="formControlLabel">Padre-Novia*</label>
                    <input type="text" name='padreNovia' v-model="rec.padreNovia" class="form-control form-control-sm" 
                      ref='padreNovia' placeholder="" required1 :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-6 form-group">
                  <label for="madreNovia" class="formControlLabel">Madre-Novia*</label>
                    <input type="text" name='madreNovia' v-model="rec.madreNovia" class="form-control form-control-sm" 
                      ref='madreNovia' :pattern="er_apellidosNombres" required1 :disabled="disabledForm"
                      @input="input($event.target)" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div> 
          <div class="form-row">
              <div class="col-2 form-group">
                  <label for="rec.fechaBauNovia" class="formControlLabel">Bautizo-Novia*</label>
                    <input type="date" name='rec.fechaBauNovia' v-model="rec.fechaBauNovia" class="form-control form-control-sm" 
                      ref='fechaBauNovia' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-10 form-group">
                  <label for="parroquiaBautizoNovia" class="formControlLabel">Parroquia Bautizo-Novia*</label>
                    <input type="text" name='parroquiaBautizoNovia' v-model="rec.parroquiaBautizoNovia" class="form-control form-control-sm" 
                      ref='parroquiaBautizoNovia' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div> 
          <div class="form-row">
              <div class="col-6 form-group">
                  <label for="apellidosNovio" class="formControlLabel">Apellidos-Novio*</label>
                    <input type="text" name='apellidosNovia' v-model="rec.apellidosNovio" class="form-control form-control-sm" 
                      ref='apellidosNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-6 form-group">
                  <label for="nombresNovio" class="formControlLabel">Nombres-Novio*</label>
                    <input type="text" name='nombresNovia' v-model="rec.nombresNovio" class="form-control form-control-sm" 
                      ref='nombresNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div>   
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="direccionNovio" class="formControlLabel">Direccion-Novio*</label>
                    <input type="text" name='direccionNovio' v-model="rec.direccionNovio" class="form-control form-control-sm" 
                      ref='direccionNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_direccion" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>          
          </div> 
          <div class="form-row">
              <div class="col-6 form-group">
                  <label for="padreNovio" class="formControlLabel">Padre-Novio*</label>
                    <input type="text" name='padreNovia' v-model="rec.padreNovio" class="form-control form-control-sm" 
                      ref='padreNovio' placeholder="" required1 :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-6 form-group">
                  <label for="madreNovio" class="formControlLabel">Madre-Novio*</label>
                    <input type="text" name='madreNovia' v-model="rec.madreNovio" class="form-control form-control-sm" 
                      ref='madreNovio' placeholder="" required1 :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                        
          </div> 
          <div class="form-row">
              <div class="col-2 form-group">
                  <label for="rec.fechaBauNovio" class="formControlLabel">Bautizo-Novio*</label>
                    <input type="date" name='rec.fechaBauNovio' v-model="rec.fechaBauNovio" class="form-control form-control-sm" 
                      ref='fechaBauNovio' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>
              <div class="col-10 form-group">
                  <label for="parroquiaBautizoNovio" class="formControlLabel">Parroquia Bautizo-Novio*</label>
                    <input type="text" name='parroquiaBautizoNovio' v-model="rec.parroquiaBautizoNovio" class="form-control form-control-sm" 
                      ref='parroquiaBautizoNovio' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>                                     
          </div>           
          <div class="form-row">
              <div class="col-2 form-group">
                  <label for="matrimonioCivil" class="formControlLabel">Matrimonio-Civil*</label>
                    <input type="date" name='fechaMatCivil' v-model="rec.fechaMatCivil" class="form-control form-control-sm" 
                      ref='fechaMatCivil' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div> 
              <div class="col-2 form-group">
                  <label for="fechaMatReligioso" class="formControlLabel">Matrimonio-Religioso*</label>
                    <input type="date" name='fechaMatReligioso' v-model="rec.fechaMatReligioso" class="form-control form-control-sm" 
                      ref='fechaMatReligioso' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
              <div class="col-2 form-group">
                  <label for="fechaAutorizacion" class="formControlLabel">Fecha-Autorizacion*</label>
                    <input type="date" name='fechaAutorizacion' v-model="rec.fechaAutorizacion" class="form-control form-control-sm" 
                      ref='fechaAutorizacion' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>                                    
          </div> 
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="vicario" class="formControlLabel">Vicario*</label>
                    <input type="text" name='vicario' v-model="rec.vicario" class="form-control form-control-sm" 
                      ref='vicario' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_vicario" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>    
          </div>  
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="cabecera1" class="formControlLabel">Cabecera 1</label>
                  <input type="text" name='cabecera1' v-model="rec.cabecera1" class="form-control form-control-sm"
                      ref='cabecera1' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
          </div> 
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="cabecera2" class="formControlLabel">Cabecera 2</label>
                  <input type="text" name='cabecera2' v-model="rec.cabecera2" class="form-control form-control-sm"
                      ref='cabecera2' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
          </div> 

          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="observaciones" class="formControlLabel">Observaciones</label>
                  <input type="text" name='observaciones' v-model="rec.observaciones" class="form-control form-control-sm"
                      ref='observaciones' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_observaciones" autocomplete='off'>
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
import inputFecha from '@/components/input-fecha.vue';

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
    inputFecha
  },  
  data(){
    return {
      ListRec: [],
      tmpListRec: [],
      rec: {},
      crud: '',
      title_detail: '',
      // lenguaje: es,
      fechaHoy: moment().format('MM/DD/YYYY'),   // UTCs     
      searchExpediente: ['numeroExpediente','fechaExpediente','Novio','Novia','parroquiaCelebracion'],
      view_content: true,
      itemCurrent: 0,
      observacionesCrud: '',
      disabledForm: true,

    }
  },  
  computed: { // Expone state al template
     ...mapState(['host','User_Name','er_numeroExpediente','er_diocesis','er_parroquia','er_apellidosNombres','er_direccion','er_vicario','er_cabecera','er_observaciones' ]), 
  },
  methods: {
    setComponent(){
    //   let ruta = require('./../assets/json/config_img.json');
    //   this.pathImg = ruta.pathFirmas;
    //   if( !this.datosExpediente.crud ) { this.verAddImg= false, this.verDelImg = false }      

    },
    list_view(){
      console.log('list_view()'); 
      if( this.crud == 'C' ) {
        this.title_detail = 'Nuevo'; 
        // this.resetForm();
        this.disabledForm = false;
        // this.generaCodigo();
        console.log('fechaHoy = ', this.fechaHoy);
        this.rec.numeroExpediente = '00002';
        this.rec.diocesisOrigen = 'Diocesis 1'
        this.rec.parroquiaCelebracion = 'Parroquia 1'
        this.rec.apellidosNovia = 'Apelldisos Novia 1'
        this.rec.nombresNovia = 'Nombres Novia 1'
        this.rec.direccionNovia = 'Direccion 2'
        this.rec.apellidosNovio = 'Apellidos Novio 1'
        this.rec.nombresNovio = 'Nombres Novio 1'
        this.rec.direccionNovio = 'Direccion 1'
        this.rec.vicario = 'Vicario ----------------'
        this.rec.fechaExpediente = moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.fechaBauNovia =  moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.fechaMatCivil =  moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.fechaMatReligioso =  moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.fechaAutorizacion =  moment(this.fechaHoy).format('YYYY-MM-DD');


      }
      if( this.crud == 'R' ) this.title_detail = 'Datos';           
      if( this.crud == 'U' ) this.title_detail = 'Edita';
      if( this.crud == 'D' ) this.title_detail = 'Anula' ;
      if( this.crud == 'R' ) {
        // disabledElementId('btnSellos', false);
        this.disabledForm = true;
        // this.load_relation();
      }
      if( this.crud == 'U') {
        // disabledElementId('codExpediente', true);
        this.disabledForm = false;
        // disabledForm(idForm, true, ['codExpediente']); // atributo 'name'
        // this.load_relation();
      }
      if( this.crud == 'D' ) {
        // disabledForm(idForm, true); // atributo 'name'
        this.disabledForm = true;
        // this.load_relation();
      }
        this.view_content = false;

    },
    load_relation(){
      // this.selDepartamento(this.rec.codDepartamento);
      // this.selProvincia(this.rec.codProvincia);
    },
    resetForm: function(){
      this.$refs[idForm].reset();
      this.rec = {};
    },
    evaluaItem(){
      // let objForm = document.getElementById(idForm);
      // console.dir(objForm);
      let obs='';
      let evaluacion = true;
      // if( !evalValue('codExpediente') ) { obs+='*Codigo '; evaluacion = false}
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
      this.rec.fechaExpediente = moment(this.rec.fechaExpediente).format('YYYY-MM-DD');

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
      let title = 'Nuevo Expediente';

      let condicion = false;
      // if ( !this.evaluaItem() ) { 
      if ( condicion ) { 
        swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        this.rec.creado_usuario = this.User_Name;
        let url = this.host+'/pliegomatrimonial/create';
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
          await swal2.fire({ title: 'Nuevo Expediente: ', text: text });
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
      let title = 'Edita Expediente';
      if ( !this.evaluaItem() ) { 
        await swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        // swal2.fire({title: title, text: 'Datos OK.'});
        let data = {  
          codExpediente: this.rec.codExpediente, 
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
          modificado_usuario: this.User_Name
        };  
        // console.log('data: ', data)
        let url = this.host+'/pliegomatrimonial/update';
        let options = {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data)
        };
        try {
          let data = await fetch(url, options);
          let res = await data.json();
          if( res.status ) this.loadListRec();
          let text = (res.status)? 'Modificado Satisfactoriamente.': 'Fallo modificacion!';
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
      let title = 'Anula Expediente';
      
      this.rec.eliminado = new Date();
      this.rec.eliminado_usuario =  this.User_Name;
      let url = this.host+'/pliegomatrimonial/delete';
      let options = {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(this.rec)
      };
      try {
        let data = await fetch(url, options);
        let res = await data.json();
        if( res.status ) this.loadListRec();          
        let text = (res.status)? 'Anulado Satisfactoriamente!': 'Fallo la anulacion!';
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
          // console.log(res)
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
      let url = this.host+'/pliegomatrimonial/lastCode';
      await axios.get(url)
      .then(function(response){ 
        let code = parseInt(response.data.code, 10) + 1;
        self.rec.codExpediente =  code+'';
        console.log('code=>', self.rec.codExpediente);
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
.detailRecord {
  /* height: 550px; */
  height: 90%;
  
}
.crud {
 margin-top: 3px;
}
.form-control-sm {
  height: 1.70rem !important;
  padding: 2px 5px !important;


}
</style>
