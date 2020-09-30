// DiaspensaProclamas.vue
<template>
<div class="content">
  <div class="content-title">
        <div class='titulo_2 align_center'>Dispensa de Lectura de Proclamas</div>   
        <div class='titulo_2 align_center' v-if='!view_content'>{{title_detail}}</div>
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
          <th>Dispensa<span></span></th>
          <th class="align_center">Fecha<span></span></th>          
          <th>Novio<span></span></th>
          <th>Novia<span></span></th>
          <th class="align_center">Autorizacion<span></span></th>
          <th>Parroquia<span></span></th>
          <th class='text-center'>Opciones</th>
        </tr>
      </thead>
      <tbody id='bodyTable' class='' >
        <tr v-for="(doc, index) in tmpListRec" :key='index' @dblclick='detalleItem(index)' @mouseover='itemFocus(index)' @blur='itemBlur'>
          <td> {{ doc.idDispensaProclamas }} </td>
          <td> {{ doc.numeroExpediente}} </td>
          <td class='align_center'> {{ doc.fechaExpediente | frmFecha }} </td>
          <td> {{ doc.Novio }} </td>
          <td> {{ doc.Novia }} </td>
          <td class='align_center'> {{ doc.fechaAutorizacion | frmFecha }} </td>
          <td> {{ doc.parroquia }} </td>
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
                <label for="numeroExpediente" class="formControlLabel">Dispensa*</label>
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
                <label for="parroquia" class="formControlLabel">Parroquia*</label>
                <input type="text" name='parroquia' v-model="rec.parroquia" class="form-control form-control-sm" 
                  ref='parroquia' id='parroquia' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
                <small id="" class="form-text text-muted"></small>
              </div>               
          </div>
          <hr class='separacion'>
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="apellidosNovio" class="formControlLabel">Apellidos-Novio*</label>
                <input type="text" name='apellidosNovio' v-model="rec.apellidosNovio" class="form-control form-control-sm" 
                  ref='apellidosNovio' id='apellidosNovio' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="nombresNovio" class="formControlLabel">Nombres-Novio*</label>
                <input type="text" name='nombresNovio' v-model="rec.nombresNovio" class="form-control form-control-sm" 
                  ref='nombresNovio' id='nombresNovio' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div>      
          <hr class='separacion'>
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="apellidosContapellidosNoviarayente" class="formControlLabel">Apellidos-Novia*</label>
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
          <hr class='separacion'>  
          <div class="form-row">
            <div class="col-2 form-group">
              <label for="numeroDispensa" class="formControlLabel">Numero-Dispensa</label>
              <input type="text" name='numeroDispensa' v-model="rec.numeroDispensa" class="form-control form-control-sm"
                  id='numeroDispensa' ref='numeroDispensa' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_impedimento" autocomplete='off'>
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
              <label for="observacion1" class="formControlLabel">Observacion 1</label>
              <input type="text" name='observacion1' v-model="rec.observacion1" class="form-control form-control-sm"
                  ref='observacion1' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_observaciones" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
          </div> 
          <div class="form-row">
            <div class="col-12 form-group">
              <label for="observacion2" class="formControlLabel">Observacion 2</label>
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
console.log('<< dispensaproclamas.vue >>');

const idForm = 'formExpediente';

import opcionesCrud from '@/components/opciones-crud.vue'

import { evalInput, evalValue, evalDate } from '@/assets/js/form';
// import { evalInput } from '@/assets/js/form';

import moment from 'moment';
moment.locale('es');

import Swal from 'sweetalert2';
let optAlert = require('@/assets/json/opt_swal2.json');
const swal2 = Swal.mixin(optAlert);

import { mapState } from 'vuex';

export default {
  name: 'dispensaproclamas',
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
      searchExpediente: ['numeroExpediente','fechaExpediente','Novio','Novia','fechaAutorizacion','parroquia'],
      view_content: true,
      itemCurrent: 0,
      observacionesCrud: '',
      disabledForm: true

    }
  },  
  computed: { // Expone state al template
     ...mapState(['host','User_Name','dev','er_numeroExpediente','er_parroquia','er_apellidosNombres','er_impedimento','er_causal','er_vicario','er_observaciones' ]), 
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
        this.title_detail = 'Nueva'; 
        this.disabledForm = false;

        if(this.dev=='dev'){        
          this.rec.numeroExpediente = '7000';
          this.rec.fechaExpediente = moment(this.fechaHoy).format('YYYY-MM-DD');
          this.rec.parroquia = 'Parroquia' 

          this.rec.apellidosNovio = 'Apellidos Novio'
          this.rec.nombresNovio = 'Nombres Novio'
          this.rec.apellidosNovia = 'Apellidos Novia'
          this.rec.nombresNovia = 'Nombres Novia'

          this.rec.numeroDispensa='Cuatro'

          this.rec.fechaAutorizacion =  moment(this.fechaHoy).format('YYYY-MM-DD');
          this.rec.vicario = 'Vicario ----------------'
          this.rec.observacion1= 'Procedimientos1 1'     
          this.rec.observacion2= 'Procedimientos1 2'     
        }
      }
      if( this.crud == 'R' ) this.title_detail = 'Datos';           
      if( this.crud == 'U' ) this.title_detail = 'Editar';
      if( this.crud == 'D' ) this.title_detail = 'Anular' ;
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

      if( !evalValue('numeroExpediente') ) { obs+='*Dispensado '; evaluacion = false}
      if( !evalDate(this.rec.fechaExpediente) ) { obs+='*Fecha '; evaluacion = false}
      if( !evalValue('parroquia') ) { obs+=' *Parroquia'; evaluacion = false}

      if( !evalValue('apellidosNovio') ) {obs+=' *Apellidos-Novio'; evaluacion = false}
      if( !evalValue('nombresNovio') ) {obs+=' *Nombres-Novio'; evaluacion = false}

      if( !evalValue('apellidosNovia') ) {obs+=' *Apellidos-Novia'; evaluacion = false}
      if( !evalValue('nombresNovia') ) {obs+=' *Nombres-Novia'; evaluacion = false}

      if( !evalDate(this.rec.fechaAutorizacion) ) { obs+='*Fecha-Autorizacion'; evaluacion = false}
      if( !evalValue('vicario') ) {obs+=' *Vicario'; evaluacion = false}


      // if( !evalString(this.rec.nombresNovio) ) {obs+=' *Nombres-Novio'; evaluacion = false}
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
      let title = 'Nueva Dispensa de Proclamas';

      if ( !this.evaluaItem() ) { 
        swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        this.rec.creado_usuario = this.User_Name;
        let url = this.host+'/dispensaproclamas/create';
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
          await swal2.fire({ title: `Nueva Dispensa: ${res.numeroExpediente}`, text: text });
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
      let title = 'Edita Dispensa de Proclamas';
      if ( !this.evaluaItem() ) { 
        await swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        delete this.rec.Novio;
        delete this.rec.Novia;
        this.rec.modificado = new Date();
        this.rec.modificado_usuario = this.User_Name

        let url = this.host+'/dispensaproclamas/update';
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
      let title = 'Anula Dispensa de Proclamas';
      
      this.rec.eliminado = new Date();
      this.rec.eliminado_usuario = this.User_Name;
      let url = this.host+'/dispensaproclamas/delete';
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
      let url = this.host+'/dispensaproclamas/all';
      let options = {
          method: 'GET',
          headers: { 'Content-Type': 'application/json' },
      };
      try {
          let data = await fetch(url, options);
          let res = await data.json();
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
  height: 55%;
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
/* ----------- */

</style>
