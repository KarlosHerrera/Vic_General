// DiaspensaBautismal.vue
<template>
<div class="content">
  <div class="content-title">
        <div class='titulo_2 align_center'>Dispensa de Partida Bautismal</div>   
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
          <th>Dispensa<span></span></th>
          <th class="align_center">Fecha<span></span></th>          
          <th>Dispensado(a)<span></span></th>
          <th>Contrayente<span></span></th>
          <th class="align_center">Autorizacion<span></span></th>
          <th>Parroquia<span></span></th>
          <th class='text-center'>Opciones</th>
        </tr>
      </thead>
      <tbody id='bodyTable' class='' >
        <tr v-for="(doc, index) in tmpListRec" :key='index' @dblclick='detalleItem(index)' @mouseover='itemFocus(index)' @blur='itemBlur'>
          <td> {{ doc.idDispensaPartidaB }} </td>
          <td> {{ doc.numeroExpediente}} </td>
          <td class='align_center'> {{ doc.fechaExpediente | frmFecha }} </td>
          <td> {{ doc.Dispensado }} </td>
          <td> {{ doc.Contrayente }} </td>
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
              <label for="apellidosDispensado" class="formControlLabel">Apellidos-Dispensado*</label>
                <input type="text" name='apellidosDispensado' v-model="rec.apellidosDispensado" class="form-control form-control-sm" 
                  ref='apellidosDispensado' id='apellidosDispensado' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="nombresDispensado" class="formControlLabel">Nombres-Dispensado*</label>
                <input type="text" name='nombresDispensado' v-model="rec.nombresDispensado" class="form-control form-control-sm" 
                  ref='nombresdDispensado'  id='nombresDispensado' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div>  
          <div class="form-row">
            <div class="col-2 form-group">
              <label for="sexo" class="formControlLabel">Sexo*</label>
              <v-select v-model="rec.sexo" label="nombreSexo" :disabled="disabledForm"
              :options="listSexos" :reduce="ele => ele.codigo" placeholder=''
              :clearable="false" class='miClase'
              >
              <div slot="no-options">No existen opciones!</div>
              </v-select>
            </div>            
          </div>
          <div class="form-row">
            <div class="col-2 form-group">
              <label for="fechaBauDispensado" class="formControlLabel">Bautizo-Dispensado*</label>
              <input-fecha v-model="rec.fechaBauDispensado" :habilita='disabledForm'></input-fecha>
            </div>            
            <div class="col-5 form-group">
              <label for="parroquiaBauDispensado" class="formControlLabel">Parroquia Bautizo-Dispensado*</label>
                <input type="text" name='parroquiaBauDispensado' v-model="rec.parroquiaBauDispensado" class="form-control form-control-sm" 
                  ref='parroquiaBauDispensado' id='parroquiaBauDispensado' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>    
            <div class="col-5 form-group">
              <label for="diocesisDispensado" class="formControlLabel">Diocesis Bautizo-Dispensado*</label>
                <input type="text" name='diocesisDispensado' v-model="rec.diocesisDispensado" class="form-control form-control-sm" 
                  ref='diocesisDispensado' id='diocesisDispensado' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>    
          </div>       
          <hr class='separacion'>
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="apellidosContrayente" class="formControlLabel">Apellidos-Contrayente*</label>
                <input type="text" name='apellidosContrayente' v-model="rec.apellidosContrayente" class="form-control form-control-sm" 
                  ref='apellidosContrayente' id='apellidosContrayente' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div> 
            <div class="col-6 form-group">
              <label for="nombrescontrayente" class="formControlLabel">Nombres-Contrayente*</label>
                <input type="text" name='nombresContrayente' v-model="rec.nombresContrayente" class="form-control form-control-sm" 
                  ref='nombresContrayente'  id='nombresContrayente' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_apellidosNombres" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>                        
          </div>  
          <div class="form-row">
            <div class="col-2 form-group">
              <label for="fechabaucontrayente" class="formControlLabel">Bautizo*</label>
              <input-fecha v-model="rec.fechaBauContrayente" :habilita='disabledForm'></input-fecha>
            </div>            
            <div class="col-5 form-group">
              <label for="parroquiaBauContrayente" class="formControlLabel">Parroquia Bautizo-Contrayente*</label>
                <input type="text" name='parroquiaBauContrayente' v-model="rec.parroquiaBauContrayente" class="form-control form-control-sm" 
                  ref='parroquiaBauContrayente' id='parroquiaBauContrayente' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>    
            <div class="col-5 form-group">
              <label for="diocesiscontrayente" class="formControlLabel">Diocesis Bautizo-Contrayente*</label>
                <input type="text" name='diocesisContrayente' v-model="rec.diocesisContrayente" class="form-control form-control-sm" 
                  ref='diocesisContrayente' id='diocesisContrayente' required :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_parroquia" autocomplete='off' data-upper='1c'>
              <small id="" class="form-text text-muted"></small>
            </div>    
          </div> 
          <hr class='separacion'>  
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="diligencia1" class="formControlLabel">Diligencia 1</label>
              <input type="text" name='diligencia1' v-model="rec.diligencia1" class="form-control form-control-sm"
                  ref='diligencia1' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
            <div class="col-6 form-group">
              <label for="diligencia2" class="formControlLabel">Diligencia 2</label>
              <input type="text" name='cabecera2' v-model="rec.diligencia2" class="form-control form-control-sm"
                  ref='diligencia2' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
          </div>
          <div class="form-row">
            <div class="col-6 form-group">
              <label for="razones1" class="formControlLabel">Razones 1</label>
              <input type="text" name='razones1' v-model="rec.razones1" class="form-control form-control-sm"
                  ref='razones1' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
            <div class="col-6 form-group">
              <label for="razones2" class="formControlLabel">Razones 2</label>
              <input type="text" name='razones2' v-model="rec.razones2" class="form-control form-control-sm"
                  ref='razones2' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
          </div> 
         <div class="form-row">
            <div class="col-6 form-group">
              <label for="procedimiento1" class="formControlLabel">Procedimientos 1</label>
              <input type="text" name='procedimiento1' v-model="rec.procedimiento1" class="form-control form-control-sm"
                  ref='procedimiento1' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
              <small id="" class="form-text text-muted"></small>
            </div>
            <div class="col-6 form-group">
              <label for="procedimiento2" class="formControlLabel">Procedimientos 2</label>
              <input type="text" name='procedimiento2' v-model="rec.procedimiento2" class="form-control form-control-sm"
                  ref='procedimiento2' :disabled="disabledForm"
                  @input="input($event.target)" :pattern="er_cabecera" autocomplete='off'>
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
console.log('<< dispensabautismal.vue >>');

const idForm = 'formExpediente';

import opcionesCrud from '@/components/opciones-crud.vue'

import { evalInput, evalValue, evalString, evalDate } from '@/assets/js/form';
// import { evalInput } from '@/assets/js/form';

import moment from 'moment';
moment.locale('es');

import Swal from 'sweetalert2';
let optAlert = require('@/assets/json/opt_swal2.json');
const swal2 = Swal.mixin(optAlert);

import { mapState } from 'vuex';

export default {
  name: 'dispensabautismal',
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
      searchExpediente: ['numeroExpediente','fechaExpediente','Dispensado','Contrayente','fechaAutorizacion','parroquia'],
      view_content: true,
      itemCurrent: 0,
      observacionesCrud: '',
      disabledForm: true,
      listSexos: [{'codigo': 'M', 'nombreSexo': 'Masculino'}, {'codigo': 'F', 'nombreSexo': 'Femenino'}]

    }
  },  
  computed: { // Expone state al template
     ...mapState(['host','User_Name','Vicario','dev','er_numeroExpediente','er_diocesis','er_parroquia','er_apellidosNombres','er_Direccion','er_vicario','er_cabecera' ]), 
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
        this.rec.vicario = this.Vicario;
        if(this.dev=='dev'){
          this.rec.numeroExpediente = '6001';
          this.rec.fechaExpediente = moment(this.fechaHoy).format('YYYY-MM-DD');
          this.rec.parroquia = 'Parroquia origen' 

          this.rec.apellidosDispensado = 'Apelldisos Novia 1'
          this.rec.nombresDispensado = 'Nombres Novia 1'
          this.rec.fechaBauDispensado =  moment(this.fechaHoy).format('YYYY-MM-DD');
          this.rec.parroquiaBauDispensado ='Parroquia Novia'
          this.rec.diocesisDispensado = 'Diocesis Origen'

          this.rec.Diligencia1= 'Diligencia 1'
          this.rec.Diligencia2= 'Diligencia 2'
          this.rec.Razones1= 'Razones 1'
          this.rec.Razones2= 'Razones 2'        
          this.rec.Procedimiento1= 'Procedimientos1 1'
          this.rec.Procedimiento2= 'Procedimientos1 2'   

          this.rec.apellidosContrayente = 'Apellidos Contrayente'
          this.rec.nombresContrayente = 'Nombres Contrayente'
          this.rec.fechaBauContrayente =  moment(this.fechaHoy).format('YYYY-MM-DD');   
          this.rec.parroquiaBauContrayente ='Parroquia Novio' 
          this.rec.diocesisContrayente = 'Diocesis Origen'            

          this.rec.fechaAutorizacion =  moment(this.fechaHoy).format('YYYY-MM-DD');
          // this.rec.vicario = 'Vicario ----------------'
        }
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

      if( !evalValue('numeroExpediente') ) { obs+='*Dispensado '; evaluacion = false}
      if( !evalDate(this.rec.fechaExpediente) ) { obs+='*Fecha '; evaluacion = false}
      if( !evalValue('parroquia') ) { obs+=' *Parroquia'; evaluacion = false}

      if( !evalValue('apellidosDispensado') ) {obs+=' *Apellidos-Dispensado'; evaluacion = false}
      if( !evalValue('nombresDispensado') ) {obs+=' *Nombres-Dispensado'; evaluacion = false}
      if( !evalString( this.rec.sexo ) ) {obs+=' *Sexo'; evaluacion = false}  
      if( !evalDate(this.rec.fechaBauDispensado) ) { obs+='*Fecha-Bautiso-Dispensado'; evaluacion = false}
      if( !evalValue('parroquiaBauDispensado') ) {obs+=' *Parr-Bautiso-Dispensado'; evaluacion = false}
      if( !evalValue('diocesisDispensado') ) { obs+=' *Diócesis-Dispensado '; evaluacion = false}

      if( !evalValue('apellidosContrayente') ) {obs+=' *Apellidos-Contrayente'; evaluacion = false}
      if( !evalValue('nombresContrayente') ) {obs+=' *Nombres-Contrayente'; evaluacion = false}
      if( !evalDate(this.rec.fechaBauContrayente) ) { obs+='*Fecha-Bautiso-Contrayente'; evaluacion = false}
      if( !evalValue('parroquiaBauContrayente') ) {obs+=' *Parr-Bautiso-Contrayente'; evaluacion = false}
      if( !evalValue('diocesisContrayente') ) { obs+=' *Diócesis-Contrayente '; evaluacion = false}

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
      let title = 'Nueva Dispensa Bautismal';

      if ( !this.evaluaItem() ) { 
        swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        this.rec.creado_usuario = this.User_Name;
        let url = this.host+'/dispensabautismal/create';
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
      let title = 'Edita Dispensa Bautismal';
      if ( !this.evaluaItem() ) { 
        await swal2.fire({title: title, text: 'Verique los datos ingresados: '+this.observacionesCrud });
      }else{
        delete this.rec.Dispensado;
        delete this.rec.Contrayente;
        this.rec.modificado = new Date();
        this.rec.modificado_usuario = this.User_Name

        let url = this.host+'/dispensabautismal/update';
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
      let title = 'Anula Dispensa Bautismal';
      
      this.rec.eliminado = new Date();
      this.rec.eliminado_usuario = this.User_Name;
      let url = this.host+'/dispensabautismal/delete';
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
      let url = this.host+'/dispensabautismal/all';
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
<style src="@/assets/css/vue-select.css"></style>


<style scoped>
.detailRecord {
  height: 75%;
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
.v-select {
  background-color: white;
  border: none;

}
.vs__dropdown-toggle{
  /* line-height: 13px !important; */
  padding: 0 !important;
}
</style>
