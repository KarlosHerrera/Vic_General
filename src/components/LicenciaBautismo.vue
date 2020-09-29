// LicenciaBautismo.vue
<template>
<div class="content">
  <div class="content-title">
        <div class='titulo_2 align_center'>Licencia de Bautismo de Adulto</div>   
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
          <th>Licencia<span></span></th>
          <th class="align_center">Fecha<span></span></th>          
          <th>Bautizado<span></span></th>
          <th class="align_center">Autorizacion<span></span></th>
          <th>Parroquia-Bautizo<span></span></th>
          <th class='text-center'>Opciones</th>
        </tr>
      </thead>
      <tbody id='bodyTable' class='' >
        <tr v-for="(doc, index) in tmpListRec" :key='index' @dblclick='detalleItem(index)' @mouseover='itemFocus(index)' @blur='itemBlur'>
          <td> {{ doc.idLicenciaBautismo }} </td>
          <td> {{ doc.numeroExpediente}} </td>
          <td class='align_center'> {{ doc.fechaExpediente | frmFecha }} </td>
          <td> {{ doc.Bautizado }} </td>
          <td class='align_center'> {{ doc.fechaAutorizacion | frmFecha }} </td>
          <td> {{ doc.parroquiaBautizo }} </td>
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
                <label for="numeroExpediente" class="formControlLabel">Licencia*</label>
                <input type="text" name='numeroExpediente' v-model="rec.numeroExpediente" class="form-control form-control-sm" 
                  ref='numeroExpediente' id='numeroExpediente' :disabled="disabledForm" required
                  @input="input($event.target)" :pattern="er_numeroExpediente" autocomplete='off' data-upper='1c'>
                <small id="" class="form-text text-muted"></small>
              </div>  
              <div class="col-2 form-group">
                <label for="fechaExpediente" class="formControlLabel">Fecha*</label>
                <input-fecha v-model="rec.fechaExpediente" :habilita='disabledForm' :disabled='disabledForm' ></input-fecha>
              </div>              
          </div> 
          <div class="form-row">  
            <div class="col-12 form-group">
              <label for="parroquiaBautizo" class="formControlLabel">Parroquia-Bautizo*</label>
                <input type="text" name='parroquiaOrigen' v-model="rec.parroquiaBautizo" class="form-control form-control-sm" 
                  ref='parroquiabautizo' id='parroquiabautizo' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>    
          </div>
          <hr class='separacion'>
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="apellidos" class="formControlLabel">Apellidos*</label>
                <input type="text" name='apellidos' v-model="rec.apellidos" class="form-control form-control-sm" 
                  ref='apellidos' id='apellidos' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="nombres" class="formControlLabel">Nombres*</label>
                <input type="text" name='nombres' v-model="rec.nombres" class="form-control form-control-sm" 
                  ref='nombres'  id='nombres' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div>  
          <div class="form-row">
            <div class="col-1 form-group">
              <label for="edad" class="formControlLabel">Edad*</label>
              <input type="text" name='edad' v-model.number="rec.edad" class="form-control form-control-sm align_right" 
                ref='edad' id='edad' :disabled="disabledForm"
                @input="input($event.target)" pattern="^[0-9]{1,2}$" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
            <div class="col-11 form-group">
              <label for="lugarnacimiento" class="formControlLabel">Lugar-Nacimiento*</label>
              <input type="text" name='lugarnacimiento' v-model="rec.lugarNacimiento" class="form-control form-control-sm" 
                ref='lugarnacimiento' id='lugarnacimiento' :disabled="disabledForm"
                @input="input($event.target)" :pattern="er_lugar" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                                     
          </div>       
          <div class="form-row">
            <div class="col-12 form-group">
              <label for="direccion" class="formControlLabel">Dirección</label>
                <input type="text" name='direccion' v-model="rec.direccion" class="form-control form-control-sm" 
                  ref='direccion' id='direccion' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_direccion" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>          
          </div> 
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="documentoacredita" class="formControlLabel">Documento-Acreditacion</label>
              <input type="text" name='documentoacredita' v-model="rec.documentoAcredita" class="form-control form-control-sm" 
                ref='documentoacredita' id='documentoacredita' :disabled="disabledForm"
                @input="input($event.target)" :pattern="er_lugar" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="tiempoIns" class="formControlLabel">Tiempo-Instruccion</label>
              <input type="text" name='tiempoIns' v-model="rec.tiempoIns" class="form-control form-control-sm" 
                ref='tiempoIns' id='tiempoIns' required :disabled="disabledForm"
                @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div>
          <hr class='separacion'>
          <div class="form-row">
            <div class="col-7 form-group">
              <label for="testigo1" class="formControlLabel">Testigo 1</label>
              <input type="text" name='testigo1' v-model="rec.testigo1" class="form-control form-control-sm"
                  ref='testigo1' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_testigo" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
            <div class="col-5 form-group">
              <label for="parestesco1" class="formControlLabel">Parentesco 1</label>
              <input type="text" name='parentesco1' v-model="rec.parentesco1" class="form-control form-control-sm"
                  ref='parentesco2' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parentesco" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>            
          </div>
          <div class="form-row">
            <div class="col-7 form-group">
              <label for="testigo2" class="formControlLabel">Testigo 2</label>
              <input type="text" name='testigo2' v-model="rec.testigo2" class="form-control form-control-sm"
                  ref='testigo2' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_testigo" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
            <div class="col-5 form-group">
              <label for="parestesco2" class="formControlLabel">Parentesco 2</label>
              <input type="text" name='parentesco2' v-model="rec.parentesco2" class="form-control form-control-sm"
                  ref='parentesco2' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parentesco" autocomplete='off'>
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
                  @input="input($event.target)" :pattern="er_observacion" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
          </div> 
          <div class="form-row">
            <div class="col-12 form-group">
              <label for="observacion2" class="formControlLabel">Observacion 2</label>
              <input type="text" name='observacion2' v-model="rec.observacion2" class="form-control form-control-sm"
                  ref='observacion2' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_observacion" autocomplete='off'>
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
console.log('<< licenciabautismo.vue >>');

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
  name: 'licenciabautismo',
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
      searchExpediente: ['numeroExpediente','fechaExpediente','Bautizado','fechaAutorizacion','parroquiaBautizo'],
      view_content: true,
      itemCurrent: 0,
      observacionesCrud: '',
      disabledForm: true,

    }
  },  
  computed: { // Expone state al template
     ...mapState(['host','User_Name','er_numeroExpediente','er_parroquia','er_apellidosNombres','er_direccion','er_vicario','er_observacion','er_testigo','er_parentesco','er_lugar']), 
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

        this.rec.numeroExpediente = '4001';
        this.rec.fechaExpediente = moment(this.fechaHoy).format('YYYY-MM-DD');
        this.rec.parroquiaBautizo = 'Parroquia bautizo' 
        this.rec.apellidos = 'Apellidos'
        this.rec.nombres = 'Nombres'

        // this.rec.edad = '07'
        this.rec.lugarNacimiento = 'Lugar de Nacimiento'
        this.rec.direccion = 'Dirección bautizado'

        this.rec.documentoAcredita ='Parroquia Novio'     
        this.rec.tiempoIns = 'T[iempo'

        this.rec.fechaAutorizacion = ''
        this.rec.vicario = 'Vicario ----------------'

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
      if( !evalValue('parroquiabautizo') ) { obs+=' *Parroquia-Bautizo '; evaluacion = false}

      if( !evalValue('apellidos') ) {obs+=' *Apellidos'; evaluacion = false}
      if( !evalValue('nombres') ) {obs+=' *Nombres'; evaluacion = false}

      if( !evalValue('edad') ) {obs+=' *Edad '; evaluacion = false}
      if( !evalValue('lugarnacimiento') ) {obs+=' *Lugar-Nacimiento '; evaluacion = false}

      if( !evalDate(this.rec.fechaAutorizacion) ) { obs+='*Fecha-Autorizacion '; evaluacion = false}
      if( !evalValue('vicario') ) {obs+=' *Vicario'; evaluacion = false}
   
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
      let title = 'Nueva Licencia de Bautismo';

      if ( !this.evaluaItem() ) { 
        swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        this.rec.creado_usuario = this.User_Name;
        let url = this.host+'/licenciabautismo/create';
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
          await swal2.fire({ title: `Nuevo Expediente: ${res.numeroExpediente}`, text: text });
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
      let title = 'Edita Licencia de Bautismo';
      if ( !this.evaluaItem() ) { 
        await swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        delete this.rec.Bautizado;
        this.rec.modificado = new Date();
        this.rec.modificado_usuario = this.User_Name

        let url = this.host+'/licenciabautismo/update';
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
      let title = 'Anula Licencia de Bautismo';
      
      this.rec.eliminado = new Date();
      this.rec.eliminado_usuario = this.User_Name;
      let url = this.host+'/licenciabautismo/delete';
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
      let url = this.host+'/licenciabautismo/all';
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
      console.log('Valor = ', self.value, '->',typeof(self.value));
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
  /* height: 550px; */
  height: 82%;
  
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
