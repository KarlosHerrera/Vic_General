// router.js

import Vue from 'vue';
import VueRouter from 'vue-router';

import Home from '@/components/Home';
import Menu from '@/components/Menu';
import PliegoMatrimonial from '@/components/PliegoMatrimonial';
import LicenciaTraslado from '@/components/LicenciaTraslado';
import DispensaBautismal from '@/components/DispensaBautismal';
import LicenciaBautismo from '@/components/LicenciaBautismo';
import DispensaImpedimentos from '@/components/DispensaImpedimentos';
import DispensaProclamas from '@/components/DispensaProclamas';
import MedioPliego from '@/components/MedioPliego';
// import Tablas from '@/components/Tablas';

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: '/',
    component: Home
    // beforeEnter: function(to, from, next){ // to = donde voy, from = de donde vengo, 
    //   if (to.path != '/login' && existToken()) {
    //     next(); // hacia ruta 'to'
    //   } else {
    //       next('login');  // redirecciona
    //   }      
    // }
  },
  {
    path: '/menu',
    name: 'menu',
    component: Menu
  },
  {
    path: '/pliegomatrimonial',
    name: 'pliegomatrimonial',
    component: PliegoMatrimonial
  },
  {
    path: '/licenciatraslado',
    name: 'licenciatraslado',
    component: LicenciaTraslado
  },
  {
    path: '/dispensabautismal',
    name: 'dispensabautismal',
    component: DispensaBautismal
  },
  {
    path: '/licenciabautismo',
    name: 'licenciabautismo',
    component: LicenciaBautismo
  },     
  {
    path: '/dispensaimpedimentos',
    name: 'dispensaimpedimentos',
    component: DispensaImpedimentos
  }, 
  {
    path: '/dispensaproclamas',
    name: 'dispensaproclamas',
    component: DispensaProclamas
  }, 
  {
    path: '/mediopliego',
    name: 'mediopliego',
    component: MedioPliego
  }
]      


const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// router.beforeEach( async function(to, from, next){
//   console.log('router.beforeEach()');
//   let store = await import('@/store/store.js');
//   let isAuthorized = store.default.getters.getAuthorized;
//   // console.log('getAuthorized: ', isAuthorized);

// console.log('from: ', from.path+' - to: '+to.path);
// if (to.name !== 'Login' && !isAuthorized) next({ name: 'Login' })
// else next()

// -----------------
  // if( !from.name ) {
  //   console.log('entro....')
  //   if( !isAuthorized ){  
  //     console.log(to.path)
  //     next({ path: '/login' })
  //   }else{
  //     console.log('next()')
  //     next();
  //   }
    // console.log('1ra. vez');
    // if( from.path != '/') { console.log('Entranda incorrecta...')}
    // next('/login');  // redirecciona
    // next(false)
  // }

  
// })

export default router
