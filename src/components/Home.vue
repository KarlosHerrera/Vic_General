//  Home.vue
<template>
  <!-- <div class='d-flex'> -->
    <div id='Home' class="home d-flex justify-content-between align-content-start">  
      <div class='col-6 d-flex justify-content-start align-items-center'>
        <router-link class="brand" to="/menu">Vicaria General</router-link>
      </div>
      <div class="col-6 d-flex justify-content-end align-items-center">
        <!-- Acceso y control de opciones -->
        <!-- <div class="col-6 d-flex align-items-end"> -->
          <div class='icon_ctn' @click='userRole()' v-if="User_Name == '' " data-toggle="tooltip" data-placement="bottom" title="Iniciar Sesion">
            <i class="icon_user">?</i>
          </div>
          <div class='icon_ctn' @click="userRole()" v-if="User_Name != '' " data-toggle="tooltip" data-placement="bottom" :title="userCurrent">
            <i class="icon_user">{{ iconUser }}</i>
          </div>
          <!-- Componente   --> 
            <!-- <div id='userRole' class="drowndown" >                        
              <ul class="dropdown-menu dropdown-menu-right" :class="{show: roleView}" role="menu" aria-labelledby="userRole">
                <li class='dropdown-item' v-for="(item, index) in listOptionsPerfil" :key='index' @click='actionRole(index)'>{{ item.dsc }}</li>
              </ul>
            </div> -->
        <!-- </div> -->

      </div>
    </div> 
  <!-- </div> -->
</template>

<script>

import { mapState } from 'vuex';

export default {
  name: 'Menu',
  components: {

  },
  data() {
      return {
        iconUser: '?',
        listOptionsPerfil: [{dsc: 'Cerrar-Sesion', action: '/logout'}, {dsc: 'Perfil-Usuario', action: '/perfilusuario'}, {dsc: 'Usuarios', action: '/usuarios'}, {dsc: 'Salir', action: '/exit'}, {dsc: 'Iniciar-Sesion', action: '/login'}, {dsc: 'Cambio-Clave', action: '/cambioClave'}],
        roleView: false,
        userCurrent: 'Sin Usuario',
        verMenu: true,
        disabledMenu: false
      }
  },
  computed: {
    ...mapState(['User_Name','User_Role']),
      User: function(){
        return this.User_Name;
    }  
  },
  methods: {
    setComponent(){
      // console.log(`Menu.vue setComponent(${this.User_Name}).........`);
      if( this.User_Name=='' ){
        // console.log('User_Name = empty');
        this.listOptionsPerfil = [{dsc: 'Iniciar-Sesion', action: '/login'}, {dsc: 'Salir', action: '/exit'}];
      }else{

        this.currentUser();
      }
    },
    userRole: function(){
      // console.log(`userRole(${this.roleView})`);
      this.roleView = !this.roleView; 
    },
    actionRole: function(index){
        // console.log(`actionRole( ${index} )`);
        // console.log('----------------------');
        let action = this.listOptionsPerfil[index].action;
        if( action == '/exit'){
          // console.log('/exit');
          // Salir
          // window.top.close();

          // setTimeout(function(){var ww = window.open(window.location, '_self'); ww.close(); }, 1000);

          // let customWindow = window.open('', '_parent', '');
          // customWindow.close();

        //  window.close();
          this.listOptionsPerfil = [{dsc: 'Iniciar-Sesion', action: '/login'}, {dsc: 'Salir', action: '/exit'}];
          // this.setComponent();
          window.location = "http://google.com";
        }else{
          if( action == '/logout' ){
            console.log('action/logout -> Cerrar Sesion')
            // Cerrar-Session
            this.listOptionsPerfil = [];
            this.listOptionsPerfil = [{dsc: 'Iniciar-Sesion', action: '/login'}, {dsc: 'Salir', action: '/exit'}];
            this.$store.dispatch('setUser', '');
            this.$store.dispatch('setRole', '');
            // console.log(this.listOptionsPerfil);
            this.setComponent();
            this.roleView = false;
            // console.log('Saliendo de /logout');
            this.$router.push('/');
          }else{
            // console.log(this.listOptionsPerfil);
            // console.log('ruta = ', action);
            this.roleView = false;
            this.$router.push(action)
    
          }

        }

    },
    currentUser(){
      // console.log('currentUser()');
      // this.iconUser = this.$store.state.User_Name.substr(0,1);
      this.iconUser = this.User_Name.substr(0,1);
      this.userCurrent = this.User_Name;
      // Genera opciones de Usuario
      this.listOptionsPerfil = [{dsc: 'Cerrar-Sesion', action: '/logout'}, 
                                {dsc: 'Perfil-Usuario', action: '/perfilUsuario'},
                                {dsc: 'Cambio-Clave', action: '/cambioClave'},
                                {dsc: 'Salir', action: '/exit'}, 
                                ]
      if( this.User_Role == 'Administrador') this.listOptionsPerfil.unshift({dsc: 'Usuarios', action: '/usuarios'})   ;              

      // Genera opciones de SubMenu
      //this.listOptionsUser = [{dsc: 'Print', action: '/home'}, {dsc: 'To Pdf', action: '/customers'}, {dsc: 'Migrar', action: '/users'}, {dsc: 'Salir', action: '/exit'}];
    },
    navItem(optionMenu){
      // console.log(`navitem(${optionMenu})`);
      let role = this.User_Role.trim();
      if ( role == '' ) return false;
      role =role. substr(0,1);
      if( !optionMenu || optionMenu.trim() == '' ) return false;
      optionMenu = optionMenu.trim().toUpperCase();
      if( optionMenu == '*') return true;
      if ( optionMenu.indexOf(role)== -1) return false;
      return true;
    },

  },
  watch: {
    User: function(newVal, oldVal){
      // console.log('watch.this.User_Name');
      console.log('New: ', newVal, ', Old: ', oldVal );
      this.currentUser();
    },
  },    
  created(){
    // console.log('Menu.vue.created()');
  },
  mounted: function(){
    console.log('App.vue.mounted()');
    this.setComponent();
  }
}
</script>

<style scoped>
.home {
  width: 99%;
  background-color: var(--background-menu) !important;
  color: var(-font-color);
  margin: 0.133rem;
  padding: 0.134rem;
  height: 2rem;
  font-size: 1.1rem;
}  
.brand {
  color: black;
  font-size: 1.4rem;
  text-decoration:none;
}
.icon_ctn {
  display: flex;
  align-items: center;
  justify-content: center;
}
.icon_ctn:hover {
    /* border: 1px solid blue; */
  color: blue;  
}
.icon_user {
  width: 1.4rem;
  height: 1.4rem;
  border-radius: 50%;
  line-height: 1.53rem;
  background-color: rgb(206, 193, 193);
  font-style: inherit;
  text-align: center;
  /* padding-right: 0.3rem; */

}
.icon_user:hover {
  cursor: pointer;
  background-color: lightgray !important;
  color: black !important;
}
.nav-link {
  color: black !important;
  padding: 0.32rem 0.5rem !important;
}
.nav-link:hover {
  /* color: white !important; */
    /* border-bottom: 1px solid white; */
} 
.router-link-active + div {
    display: block;
    width: 100%;
    height: 0.1rem;
    border-bottom-width: 0.1rem;
    border-bottom-style: solid;
    border-bottom-color: var(--font-color_hover);
}

</style>