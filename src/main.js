import Vue from 'vue'
import App from './App.vue'
import router from './router/router.js';
import store from './store/store.js';

import "bootstrap/dist/css/bootstrap.min.css"
import filtratabla from '@/components/filtra-tabla.vue';
import inputFecha from '@/components/input-fecha.vue';

import moment from 'moment';
moment.locale('es');
Vue.config.productionTip = false


Vue.component('filtra-tabla', filtratabla);
Vue.component('input-fecha', inputFecha);

require('@/assets/css/index.css');
require('@/assets/js/index.js');


Vue.filter('frmFecha', function(value){
  return moment(value).format('DD/MM/YYYY');
});
Vue.filter('frmLongMaxima', function(value, length){
  if( !value ) value='';
  if( value.trim().length > length ) {
    return value.substring(0, length)+'...';
  }else{
    return value;
  }
});
new Vue({
  store,
  router,  
  render: h => h(App),
}).$mount('#app')
