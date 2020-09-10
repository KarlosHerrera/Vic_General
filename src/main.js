import Vue from 'vue'
import App from './App.vue'
import router from './router/router.js';
import store from './store/store.js';

import filtratabla from '@/components/filtra-tabla.vue';

import moment from 'moment';
moment.locale('es');
Vue.config.productionTip = false


Vue.component('filtra-tabla', filtratabla);

require('@/assets/css/index.css');
require('@/assets/js/index.js');


Vue.filter('frmFecha', function(value){
  return moment(value).format('DD/MM/YYYY');
});
new Vue({
  store,
  router,  
  render: h => h(App),
}).$mount('#app')
