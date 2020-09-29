// MedioPliego.vue
<template>
<div class="content">
  <div class="content-title">
        <div class='titulo_2 align_center' >Medio Pliego Matrimonial</div>   
        <div class='titulo_2 align_center' v-if='!view_content'>{{ title_detail }}</div>
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
          <th>Consec.<span></span></th>
          <th>Pliego<span></span></th>
          <th class="align_center">Fecha<span></span></th>          
          <th>Novio<span></span></th>
          <th>Novia<span></span></th>
          <th class="align_center">Autorizacion<span></span></th>
          <th>Parroquia-Matrimonio<span></span></th>
          <th class='text-center'>Opciones</th>
        </tr>
      </thead>
      <tbody id='bodyTable' class='' >
        <tr v-for="(doc, index) in tmpListRec" :key='index' @dblclick='detalleItem(index)' @mouseover='itemFocus(index)' @blur='itemBlur'>
          <td> {{ doc.idMedioPliego}} </td>
          <td> {{ doc.numeroExpediente}} </td>
          <td class='align_center'> {{ doc.fechaExpediente | frmFecha }} </td>
          <td> {{ doc.Novio }} </td>
          <td> {{ doc.Novia }} </td>
          <td class='align_center'> {{ doc.fechaAutorizacion | frmFecha }} </td>
          <td> {{ doc.parroquiaMatrimonio }} </td>
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
                <label for="numeroExpediente" class="formControlLabel">Pliego*</label>
                <input type="text" name='numeroExpediente' v-model="rec.numeroExpediente" class="form-control form-control-sm" 
                  ref='numeroExpediente' id='numeroExpediente' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_numeroExpediente" autocomplete='off' data-upper='1c'>
                <small id="" class="form-text text-muted"></small>
              </div>  
              <div class="col-2 form-group">
                <label for="fechaExpediente" class="formControlLabel">Fecha*</label>
                <input-fecha v-model="rec.fechaExpediente" :habilita='disabledForm' :disabled='disabledForm' ></input-fecha>
              </div>              
              <div class="col-8 form-group">
                <label for="diocesisOrigen" class="formControlLabel">Diócesis-Origen*</label>
                  <input type="text" name='diocesisOrigen' v-model="rec.diocesisOrigen" class="form-control form-control-sm" 
                    ref='diocesisOrigen' id='diocesisOrigen' required :disabled="disabledForm"
                    @input="input($event.target)" :pattern="er_diocesis" autocomplete='off' data-upper='1c'>
                <small id="" class="form-text text-muted"></small>
              </div> 
          </div> 
          <div class="form-row">  
            <div class="col-6 form-group">
              <label for="parroquiaOrigen" class="formControlLabel">Parroquia-Origen*</label>
                <input type="text" name='parroquiaOrigen' v-model="rec.parroquiaOrigen" class="form-control form-control-sm" 
                  ref='parroquiaOrigen' id='parroquiaOrigen' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>    
            <div class="col-6 form-group">
              <label for="diocesisDestino" class="formControlLabel">Diócesis-Destino*</label>
                <input type="text" name='diocesisDestino' v-model="rec.diocesisDestino" class="form-control form-control-sm" 
                  ref='diocesisDestino' id='diocesisDestino' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>  
          </div>
          <div class="form-row">
              <div class="col-8 form-group">
                  <label for="parroquiaMatrimonio" class="formControlLabel">Parroquia-Matrimonio*</label>
                    <input type="text" name='parroquiaMatrimonio' v-model="rec.parroquiaMatrimonio" class="form-control form-control-sm" 
                       ref='parroquiaMatrimonio' id='parroquiaMatrimonio' required :disabled="disabledForm"
                      @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>  
              <div class="col-2 form-group">
                <label for="fechaMatCivil" class="formControlLabel">Matrimonio-Civil</label>
                <input-fecha v-model="rec.fechaMatCivil" :habilita='disabledForm'></input-fecha>
              </div>                 
              <div class="col-2 form-group">
                <label for="fechaMatReligioso" class="formControlLabel">Matrimonio-Religioso</label>
                <input-fecha v-model="rec.fechaMatReligioso" :habilita='disabledForm'></input-fecha>
              </div>                
          </div>  
          <hr class='separacion'>
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="apellidosNovio" class="formControlLabel">Apellidos-Novio*</label>
                <input type="text" name='apellidosNovia' v-model="rec.apellidosNovio" class="form-control form-control-sm" 
                  ref='apellidosNovio' id='apellidosNovio' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="nombresNovio" class="formControlLabel">Nombres-Novio*</label>
                <input type="text" name='nombresNovia' v-model="rec.nombresNovio" class="form-control form-control-sm" 
                  ref='nombresNovio'  id='nombresNovio' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div>  
          <div class="form-row">
            <div class="col-2 form-group">
              <label for="fechaBauNovio" class="formControlLabel">Bautizo-Novio*</label>
              <input-fecha v-model="rec.fechaBauNovio" :habilita='disabledForm'></input-fecha>
            </div>            
            <div class="col-10 form-group">
              <label for="parroquiaBauNovio" class="formControlLabel">Parroquia Bautizo-Novio*</label>
                <input type="text" name='parroquiaBauNovio' v-model="rec.parroquiaBauNovio" class="form-control form-control-sm" 
                  ref='parroquiaBauNovio' id='parroquiaBauNovio' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                                     
          </div>       
          <div class="form-row">
            <div class="col-12 form-group">
              <label for="direccionNovio" class="formControlLabel">Dirección-Novio</label>
                <input type="text" name='direccionNovio' v-model="rec.direccionNovio" class="form-control form-control-sm" 
                  ref='direccionNovio' id='direccionNovio' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_direccion" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>          
          </div> 
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="padreNovio" class="formControlLabel">Padre-Novio*</label>
                <input type="text" name='padreNovia' v-model="rec.padreNovio" class="form-control form-control-sm" 
                  ref='padreNovio' id='padreNovio' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="madreNovio" class="formControlLabel">Madre-Novio*</label>
                <input type="text" name='madreNovia' v-model="rec.madreNovio" class="form-control form-control-sm" 
                  ref='madreNovio' id='madreNovio' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div>
          <hr class='separacion'>
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="apellidosNovia" class="formControlLabel">Apellidos-Novia*</label>
                <input type="text" name='apellidosNovia' v-model="rec.apellidosNovia" class="form-control form-control-sm" 
                  ref='apellidosNovia' id='apellidosNovia' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="nombresNovia" class="formControlLabel">Nombres-Novia*</label>
                <input type="text" name='nombresNovia' v-model="rec.nombresNovia" class="form-control form-control-sm" 
                  ref='nombresNovia' id='nombresNovia' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div>   
          <div class="form-row">
            <div class="col-2 form-group">
              <label for="fechaBauNovia" class="formControlLabel">Bautizo-Novia*</label>
              <input-fecha v-model="rec.fechaBauNovia" :habilita='disabledForm'></input-fecha>                
            </div> 
            <div class="col-10 form-group">
              <label for="parroquiaBauNovia" class="formControlLabel">Parroquia Bautizo-Novia*</label>
                <input type="text" name='parroquiaBauNovia' v-model="rec.parroquiaBauNovia" class="form-control form-control-sm" 
                  ref='parroquiaBauNovia' id='parroquiaBauNovia' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div> 
          <div class="form-row">
            <div class="col-12 form-group">
              <label for="direccionNovia" class="formControlLabel">Dirección-Novia</label>
                <input type="text" name='direccionNovia' v-model="rec.direccionNovia" class="form-control form-control-sm" 
                  ref='direccionNovia' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_direccion" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>          
          </div>  
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="padreNovia" class="formControlLabel">Padre-Novia*</label>
                <input type="text" name='padreNovia' v-model="rec.padreNovia" class="form-control form-control-sm" 
                  ref='padreNovia' id='padreNovia' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="madreNovia" class="formControlLabel">Madre-Novia*</label>
                <input type="text" name='madreNovia' v-model="rec.madreNovia" class="form-control form-control-sm" 
                  ref='madreNovia' id='madreNovia' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div> 
          <hr class='separacion'>   
          <div class="form-row">
            <div class="col-2 form-group">
              <label for="fechaAutorizacion" class="formControlLabel">Fecha-Autorizacion*</label>
              <input-fecha v-model="rec.fechaAutorizacion" :habilita='disabledForm'></input-fecha>
            </div>   
            <div class="col-10 form-group">
              <label for="vicario" class="formControlLabel">Vicario*</label>
                <input type="text" name='vicario' v-model="rec.vicario" class="form-control form-control-sm" 
                  ref='vicario' id='vicario' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_vicario" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>    
          </div>  
          <div class="form-row">
            <div class="col-12 form-group">
              <label for="cabecera" class="formControlLabel">Cabecera 1</label>
              <input type="text" name='cabecera' v-model="rec.cabecera" class="form-control form-control-sm"
                  ref='cabecera' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
          </div> 
          <div class="form-row">
            <div class="col-12 form-group">
              <label for="observacion1" class="formControlLabel">Observaciones 1</label>
              <input type="text" name='observacion1' v-model="rec.observacion1" class="form-control form-control-sm"
                  ref='observacion1' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_observaciones" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
          </div> 
          <div class="form-row">
            <div class="col-12 form-group">
              <label for="observacion2" class="formControlLabel">Observaciones 2</label>
              <input type="text" name='observacion2' v-model="rec.observacion2" class="form-control form-control-sm"
                  ref='observacion2' :disabled="disabledForm"
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
console.log('<< mediopliego.vue >>');

const idForm = 'formExpediente';

import opcionesCrud from '@/components/opciones-crud.vue'

import { evalInput, evalValue, evalDate } from '@/assets/js/form';

import moment from 'moment';
moment.locale('es');

import Swal from 'sweetalert2';
let optAlert = require('@/assets/json/opt_swal2.json');
const swal2 = Swal.mixin(optAlert);

import { mapState } from 'vuex';

export default {
  name: 'mediopliego',
  components: {
    opcionesCrud
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
      searchExpediente: ['numeroExpediente','fechaExpediente','Novio','Novia','fechaAutorizacion','parroquiaMatrimonio'],
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
        this.disabledForm = false;
        // console.log('fechaHoy = ', this.fechaHoy);
        // this.rec.fecha =  moment(this.fechaHoy).format('YYYY-MM-DD');

        this.rec.numeroExpediente = '9000';
        this.rec.fechaExpediente = moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.diocesisOrigen = 'Diocesis origen'
        this.rec.parroquiaOrigen = 'Parroquia origen'        
        this.rec.diocesisDestino = 'Diocesis 1destino'        
        this.rec.parroquiaMatrimonio = 'Parroquia 1'
        this.rec.apellidosNovia = 'Apellidos Novia 1'
        this.rec.nombresNovia = 'Nombres Novia 1'
        this.rec.fechaBauNovia =  moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.parroquiaBauNovia ='Parroquia Novia'
        this.rec.direccionNovia = 'Dirección novia'
        this.rec.padreNovia = 'Padre Novia 1'
        this.rec.madreNovia = 'Madre Novia 1'
        this.rec.apellidosNovio = 'Apellidos Novio 1'
        this.rec.nombresNovio = 'Nombres Novio 1'
        this.rec.fechaBauNovio =  moment(this.fechaHoy).format('YYYY-MM-DD');   
         this.rec.parroquiaBauNovio ='Parroquia Novio'     
        this.rec.direccionNovio = 'Dirección novio'
        this.rec.padreNovio = 'Padre Novia'
        this.rec.madreNovio = 'Madre Novia'
        this.rec.vicario = 'Vicario General'
        // this.rec.fechaMatCivil =  moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.fechaMatReligioso =  moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.fechaAutorizacion =  moment(this.fechaHoy).format('YYYY-MM-DD');

      }
      if( this.crud == 'R' ) this.title_detail = 'Datos';           
      if( this.crud == 'U' ) this.title_detail = 'Edita';
      if( this.crud == 'D' ) this.title_detail = 'Anula' ;
      
      if( this.crud == 'R' ) this.disabledForm = true;
      if( this.crud == 'U') this.disabledForm = false;
      if( this.crud == 'D' )  this.disabledForm = true;
      this.view_content = false;

    },
    resetForm: function(){
      this.$refs[idForm].reset();
      this.rec = {};
    },
    evaluaItem(){
      // console.log('evaluaItem()');
      let obs='';
      let evaluacion = true;

      if( !evalValue('numeroExpediente') ) { obs+='*Expediente '; evaluacion = false}
      if( !evalDate(this.rec.fechaExpediente) ) { obs+='*Fecha '; evaluacion = false}
      if( !evalValue('diocesisOrigen') ) { obs+=' *Diocesis '; evaluacion = false}
      if( !evalValue('parroquiaOrigen') ) { obs+=' *Parroquia-Origen '; evaluacion = false}
      if( !evalValue('diocesisDestino') ) { obs+=' *Diócesis-Destino '; evaluacion = false}
      if( !evalValue('parroquiaMatrimonio') ) { obs+=' *Parroquia-Matrimonio '; evaluacion = false}

      if( !evalValue('apellidosNovio') ) {obs+=' *Apellidos-Novio'; evaluacion = false}
      if( !evalValue('nombresNovio') ) {obs+=' *Nombres-Novio'; evaluacion = false}
      if( !evalDate(this.rec.fechaBauNovio) ) { obs+='*Fecha-Bautizo-Novio'; evaluacion = false}
      if( !evalValue('parroquiaBauNovio') ) {obs+=' *Parr-Bautizo-Novio'; evaluacion = false}
      if( !evalValue('padreNovio') ) {obs+=' *Padre-Novio'; evaluacion = false}
      if( !evalValue('madreNovio') ) {obs+=' *Madre-Novio'; evaluacion = false}

      // if( !evalString(this.rec.nombresNovio) ) {obs+=' *Nombres-Novio'; evaluacion = false}
      if( !evalValue('apellidosNovia') ) {obs+=' *Apellidos-Novia'; evaluacion = false}
      if( !evalValue('nombresNovia') ) {obs+=' *Nombres-Novia'; evaluacion = false}
      if( !evalDate(this.rec.fechaBauNovia) ) { obs+='*Fecha-Bautizo-Novia'; evaluacion = false}
      if( !evalValue('parroquiaBauNovia') ) {obs+=' *Parr-Bautizo-Novia'; evaluacion = false}
      if( !evalValue('padreNovia') ) {obs+=' *Padre-Novia'; evaluacion = false}
      if( !evalValue('madreNovia') ) {obs+=' *Madre-Novia'; evaluacion = false}      

      if( !evalDate(this.rec.fechaAutorizacion) ) { obs+='*Fecha-Autorizacion'; evaluacion = false}
      if( !evalValue('vicario') ) {obs+=' *Vicario'; evaluacion = false}

// this.rec.fechaMatCivil = '2020-02-28'
// if( !evalDate(this.rec.fechaMatCivil) ) { obs+='*Fecha-Civil'; evaluacion = false}     
      this.observacionesCrud = obs;
      return evaluacion;
    },
    detalleItem(index){
      // console.log(`detalleItem(${index})`);
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
      let title = 'Nuevo Medio Pliego Matrimonial';

      if ( !this.evaluaItem() ) { 
        swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        this.rec.creado_usuario = this.User_Name;
        let url = this.host+'/mediopliego/create';
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
          await swal2.fire({ title: `Nuevo Pliego Matrimonial: ${res.numeroExpediente}`, text: text });
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
      let title = 'Edita Medio Pliego Matrimonial';
      if ( !this.evaluaItem() ) { 
        await swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        delete this.rec.Novio;
        delete this.rec.Novia;
        this.rec.modificado = new Date();
        this.rec.modificado_usuario = this.User_Name

        let url = this.host+'/mediopliego/update';
        let options = {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          // body: JSON.stringify(data)
          body: JSON.stringify(this.rec)
        };
        try {
          let data = await fetch(url, options);
          let res = await data.json();
          if( res.status ) this.loadListRec();
          let text = (res.status)? 'Modificado Satisfactoriamente.': 'Fallo modificacion!';
          await swal2.fire({title: title+` (${res.numeroExpediente})`, text: text});
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
      let title = 'Anula Medio Pliego Matrimonial';
      
      this.rec.eliminado = new Date();
      this.rec.eliminado_usuario = this.User_Name;
      let url = this.host+'/mediopliego/delete';
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
        this.exitForm();
      } catch (error) {
        console.log('Error:', error);
      }

    },  
    async loadListRec(){
      // console.log('loadInstituciones()');
      let url = this.host+'/mediopliego/all';
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
    itemFocus(index){
      this.itemCurrent = index+1;
    },
    itemBlur(){
      this.itemCurrent = 0;
    },    
    filterProcess: function(value){
      // console.log('value = ', value);
      this.tmpListRec = value;
    },
    confirmaFecha(value, self){
      console.log(`confirmaFecha(${value},${self})`);
      // this.rec.fecha = value;
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
  height: 87%;
  
}
.crud {
 margin-top: 3px;
}
.form-control-sm {
  height: 1.70rem !important;
  padding: 2px 5px !important;


}
.separacion {
  margin: 3px 0;
  border-top-color: darkgray;
  border-bottom: 2px; 
}
</style>
