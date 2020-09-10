// PliegoMatrimonial.vue
<template>
<div class="content d-flex flex-column">
  <div class="content-title">
        <div class='titulo_2 align_center' v-if='view_content'>Pliego Matrimonial</div>   
        <div class='titulo_2 align_center' v-if='!view_content'>{{title_detail}} Religioso</div>
    <div class="headerTitle d-flex justify-content-between">
        <div class='d-flex justify-content-start align-items-center' v-if='view_content' >
            <button class='btn btn-sm btn_1 btn_new' @click='createItem'>Nuevo</button>
        </div>         

        <div class='d-flex justify-content-end' >  
            <filtra-tabla v-if='view_content' :recordList="Religiosos" :colsSearch='searchReligioso' @filter_Process="filterProcess" ></filtra-tabla>
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
        <tr v-for="(doc, index) in tmpReligiosos" :key='index' @dblclick='detalleItem(index)' @mouseover='itemFocus(index)' @blur='itemBlur'>
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
    <div class='col-12 content-form d-flex flex-column'>
      <form id='formReligioso' class='formBase' onsubmit="return false;" novalidate autocomplete="nope" data-btnEnable='btnSave'>
          <div class="form-row justify-content-between">
            <div class="col-2 form-group">
              <label for="codReligioso" class="formControlLabel">Codigo*</label>
              <input  type="text" name="codReligioso" v-model="rec.codReligioso" class="form-control form-control-sm" 
                      id="codReligioso" placeholder="" disabled
                      @input="input($event.target)" pattern="^[1-9]{1}[0-9]{1,2}$" autocomplete='off' required>
              <small id="" class="form-text text-muted"></small>
            </div>
            <div class="col-6 form-group">
              <label for="" class="formControlLabel">Jerarquia*</label>
              <v-select v-model="rec.codJerarquia" label="nombreJerarquia" id='codJerarquia'
              :options="Jerarquias" :reduce="ele => ele.codJerarquia" placeholder=''
              :clearable="false" class='miClase' :disabled="disabledForm"
              >
              <div slot="no-options">No existen opciones!</div>
              </v-select> 
            </div>
          </div> 

          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="nombreReligioso" class="formControlLabel">Nombre*</label>
                    <input type="text" name='nombreInstitucion' v-model="rec.apellidosNombres" class="form-control form-control-sm" 
                      id='apellidosNombres' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ -.\/]{1,59}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>          
          </div>             
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="direccion" class="formControlLabel">Direccion*</label>
                    <input type="text" name='direccion' v-model="rec.direccion" class="form-control form-control-sm" 
                      id='direccion' placeholder="" required :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Z]{1}[a-zA-Z0-9 áéíóúñÑ #-.()\/]{1,99}$" autocomplete='off' data-upper='1c'>
                  <small id="" class="form-text text-muted"></small>
              </div>          
          </div>  
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="departamento" class="formControlLabel">Departamento*</label>
                  <v-select v-model="rec.codDepartamento" label="nombreDepartamento" required
                  :options="Departamentos" :reduce="ele => ele.codDepartamento" placeholder=''
                  :clearable="false" @input="selDepartamento" class='miClase' :disabled="disabledForm"
                  >
                  <div slot="no-options">No existen opciones!</div>
                  </v-select>
              </div>

          </div>
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="provincia" class="formControlLabel">Provincia*</label>
                  <v-select v-model="rec.codProvincia" label="nombreProvincia" required
                  :options="tmpProvincias" :reduce="ele => ele.codProvincia" placeholder=''
                  :clearable="false" @input="selProvincia" class='miClase' :disabled="disabledForm"
                  >
                  <div slot="no-options">No existen opciones!</div>
                  </v-select>
              </div>
          </div>       
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="distrito" class="formControlLabel">Distrito*</label>
                  <v-select v-model="rec.codDistrito" label="nombreDistrito" required
                  :options="tmpDistritos" :reduce="ele => ele.codDistrito" placeholder=''
                  :clearable="false" class='miClase' :disabled="disabledForm"
                  >
                  <div slot="no-options">No existen opciones!</div>
                  </v-select>
              </div>
          </div>   
          <div class="form-row justify-content-between">
              <div class="col-3 form-group">
                  <label for="telefono1" class="formControlLabel">Telefono 1</label>
                  <input type="text" name='telefono1' v-model="rec.telefono1" class="form-control form-control-sm"
                      id='telefono1' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[1-9]{1}[0-9]{5,9}$" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
              <div class="col-3 form-group">
                  <label for="telefono2" class="formControlLabel">Telefono 2</label>
                  <input type="text" name='telefono2' v-model="rec.telefono2" class="form-control form-control-sm" 
                    id='telefono2' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[1-9]{1}[0-9]{5,9}$" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
              <div class="col-3 form-group">
                  <label for="movil" class="formControlLabel">Movil</label>
                  <input type="text" name='fax' v-model="rec.movil" class="form-control form-control-sm"
                        id='movil' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[1-9]{1}[0-9-]{5,9}$" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
          </div>
          <div class="form-row">
              <div class="col-12 form-group">
                  <label for="email" class="formControlLabel">Correo</label>
                  <input type="text" name='email' v-model="rec.email" class="form-control form-control-sm"
                      id='email' placeholder="" :disabled="disabledForm"
                      @input="input($event.target)" pattern="^[A-Za-z0-9%+-]+@[A-Za-z0-9-]+.+.[A-Za-z]{2,4}$" autocomplete='off'>
                  <small id="" class="form-text text-muted"></small>
              </div>
          </div> 
      </form> 
      <opciones-crud class='row' :crud="crud" @confirm_Create="confirmCreate" @confirm_Update="confirmUpdate" @confirm_Delete="confirmDelete" @exit_Form="exitForm" @reset_Form='resetForm'></opciones-crud>
    </div>
  </div>
  <!-- <button class='btn btn-sm btn_1 btn_new' @click='evalua'>Evalua</button>  -->
  <div class="content-footer align-items-end"  v-if='view_content'>
    <div class='itemCurrent '>Items: {{ itemCurrent}}/{{tmpReligiosos.length}} </div>
  </div>
  <!-- <firmas-crud :datosReligioso="datosReligioso" v-if="verFirmasCrud" @close='cierraFirmasCrud'></firmas-crud> -->
  <!-- <modal-firmas :datosReligioso="datosReligioso" v-if="verFirmas" @close='verFirmas=false'></modal-firmas>   -->
</div>
</template>

<script>
console.log('<< PliegoMatrimonial.vue >>');

const idForm = 'formPliegoMatrimonial';
import axios from 'axios';
import { disabledForm, disabledElementId } from '@/assets/js/lib';
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

  },  
  data(){
    return {
      Religiosos: [],
      tmpReligiosos: [],
      Jerarquias: [],
      Departamentos: [],
      Provincias: [],
      tmpProvincias: [],
      Distritos: [],
      tmpDistritos: [],
      rec: {},
      crud: '',
      title_detail: '',
      // lenguaje: es,
      fechaHoy: new Date(),   // UTCs
      verFirmas: false,
      verFirmasCrud: false,
      codReligioso: '',
      apellidosNombres: '',
      datosReligioso: {},      
      searchReligioso: ['codReligioso','apellidosNombres','nombreJerarquia','direccion'],
      view_content: true,
      itemCurrent: 0,
      observacionesCrud: '',
      disabledForm: true
    }
  },  
  computed: { // Expone state al template
     ...mapState(['host', 'record']), 
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
        // this.rec.codInstitucion='1002';
        // this.rec.nombreInstitucion='AAANombre de Institucion 1002';
        // this.rec.direccion='Direccion';
        // this.rec.tipoInstitucion='03';
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
        disabledElementId('codReligioso', true);
        this.disabledForm = false;
        disabledForm(idForm, true, ['codReligioso']); // atributo 'name'
        this.load_relation();
      }
      if( this.crud == 'D' ) {
        disabledForm(idForm, true); // atributo 'name'
        this.disabledForm = true;
        this.load_relation();
      }
        this.view_content = false;

    },
    load_relation(){
      this.selDepartamento(this.rec.codDepartamento);
      this.selProvincia(this.rec.codProvincia);
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
      this.rec = this.tmpReligiosos[index];
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
        let url = this.host+'/religiosos/create';
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
          if( res.status ) this.loadReligiosos();
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
      this.rec = this.tmpReligiosos[index];
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
        let url = this.host+'/religiosos/update';
        let options = {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data)
        };
        try {
          let text = '';
          let data = await fetch(url, options);
          let res = await data.json();
          if( res.status ) this.loadReligiosos();
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
      this.rec = this.tmpReligiosos[index];
      this.list_view();
    },
    confirmDelete: async function(){
      // console.log('confirmDelete()');
      let title = 'Anula Religioso';
      
      this.rec.eliminado = new Date();
      this.rec.eliminado_usuario =  this.$store.state.User_Name;
      let url = this.host+'/religiosos/delete';
      let options = {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(this.rec)
      };
      try {
        let text = '';
        let data = await fetch(url, options);
        let res = await data.json();
        if( res.status ) this.loadReligiosos();          
        text = (res.status)? 'Anulado Satisfactoriamente!': 'Fallo la anulacion!';
        await swal2.fire({title: title, text: text});
        disabledForm(idForm, false);
        this.exitForm();
      } catch (error) {
        console.log('Error:', error);
      }

    },
    cierraFirmasCrud(value){
      console.log(`cierraFirmasCrud(${value})`);
      this.verFirmasCrud=false;
      if( value ) this.loadReligiosos();

    },    
    async loadReligiosos(){
      // console.log('loadInstituciones()');
      let url = this.host+'/religiosos/all_rel';
      let options = {
          method: 'GET',
          headers: { 'Content-Type': 'application/json' },
      };
      try {
          let data = await fetch(url, options);
          let res = await data.json();
          this.Religiosos = res[0];
          this.tmpReligiosos = res[0];
      } catch (error) {
          console.log('Error:', error);
      }      

    },
    async loadJerarquias(){
      // console.log('loadTipoInstituciones()');
      // let self = this;
      let url = this.host+'/tablas/jerarquias/all';
      try {
        let data = await fetch(url);
        let res = await data.json();
        this.Jerarquias = res;
      } catch (error) { console.log('Error:', error);
      }
    },      
    selDepartamento(value){
      // console.log(`selDepartamento(${value})`);
      // let codInstitucion = value.srcElement.value;
      let codDepartamento = value;
      this.tmpProvincias = this.Provincias.filter( ele => ele.codDepartamento == codDepartamento);
      // console.log('tmpProvinckas => ', this.tmpProvincias.length);
    },
    selProvincia(value){
      // console.log(`selProvincia(${value})`);
      let codProvincia = value;
      this.tmpDistritos = this.Distritos.filter( ele => ele.codProvincia == codProvincia);
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
      let url = this.host+'/religiosos/lastCode';
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
      this.tmpReligiosos = value;
    }    
  },
   // Hooks
  created: function(){
    // this.loadReligiosos();
    // this.loadJerarquias();

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
