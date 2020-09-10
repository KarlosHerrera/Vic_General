// store.js   

import Vue from 'vue'
import Vuex from 'vuex'
// import axios from 'axios'
import moment from 'moment';
moment.locale('es');

Vue.use(Vuex)

let apis = require('./../assets/json/config_app.json');
let host = apis.host;

let fechaHoy = new Date();
// console.log('store.fechHoy = ', fechaHoy);
// let fechas_Doc = { desde:  moment(fechaHoy).format('YYYY-MM-DD hh:mm:ss'), hasta: moment(fechaHoy).format('YYYY-MM-DD hh:mm:ss') };
// console.log('store.fechasDoc = ', fechas_Doc);
//const store = new Vuex.Store({
export default new Vuex.Store({
  state: {
    User_Name: '',
    User_Role: '',
    record: {},
    fechaHoy: fechaHoy,
    host: host
  },
  mutations: {
    setHost: function(state, data){
      state.host = data;
    },
    setUser: function(state, data){
      state.User_Name = data;
    },
    setRole: function(state, data){
      state.User_Role = data;
    },    
    setUsers: function(state, users){
      console.log('mutations.setUsers()');
      state.users = users;
    },
    setRecord: function(state, record){
      state.record = record;
    },

  },
  actions: {
      // { commit, dispatch } = objetos contexto

    userAll: async function({ commit }){
      console.log('actions.userAll()')
      try {
        let data = await fetch(this.host+'/users/all/');
        let users = await data.json();
        commit('setUsers', users);   
      } catch (error) {
        console.log(error);          
      }
    },
    getUser: async function({ commit }){
      console.log('actions.getUser()')
      const data = { _id: ''};
      const options = { method: 'GET', 
                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                        body: JSON.stringify(data)
                      };
      try {
        let data = await fetch(this.host+'/users/one', options);
        let users = await data.json();
        commit('users', users);        
      } catch (error) {
        console.log(error);
      }

    },
    setUser: function(context, data){
      context.commit('setUser', data);
    },
    setRole: function(context, data){
      context.commit('setRole', data);
    },    
    // Configuracion de App
    config_app: function(context){
      // console.log('store.config_app()');
      let app = require('./../assets/json/config_app.json');
      // console.log('store.host: ', app.host)
      context.commit('setHost', app.host);

    }, 
    // usuarios

  },
  modules: {
  },
  getters: {
    getUsers: function(state){
      // console.log('getUsers');
      return state.users;
    },
    getAuthorized: function(state){
      // console.log('getAuthorized');     
      return ( !state.User_Name )? false : true;

    }

  }
})
