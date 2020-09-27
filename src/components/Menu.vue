//  Menu.vue
<template>
  <div class='menu d-flex flex-wrap justify-content-around'>
    <div class='itmMenu' @click="action('/pliegomatrimonial')"><p>Pliego</p><p>Matrimonial</p><p>Nuevo</p></div>
    <div class='itmMenu'><p class='align_center'>Dispensa de</p><p> Impedimentos</p></div>
    <div class='itmMenu' @click="action('/licenciabautismo')"><p>Licencia de</p><p>Bautismo</p><p>de Adulto</p></div>
    <div class='itmMenu'><p>Dispensa de</p><p>Proclamas</p></div>
    <div class='itmMenu' @click="action('/licenciatraslado')"><p>Licencia de</p><p>Traslado</p></div>
    <div class='itmMenu' @click="action('/licenciatraslado')"><p class='align_center'>Dispensa de</p><p> Partida Bautismal</p></div>
    <div class='itmMenu'><p>Medio Pliego</p><p>Matrimonial</p></div>
  </div>
</template> 

<script>
console.log('<< Menu.vue >>');  

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
    action(action){
      console.log(`action(${action})`);
      this.$router.push(action);
    },
    currentUser(){
      // console.log('currentUser()');
      // this.iconUser = this.$store.state.User_Name.substr(0,1);
      this.iconUser = this.User_Name.substr(0,1);
      this.userCurrent = this.User_Name;
      // Genera itmMenues de Usuario
      this.listOptionsPerfil = [{dsc: 'Cerrar-Sesion', action: '/logout'}, 
                                {dsc: 'Perfil-Usuario', action: '/perfilUsuario'},
                                {dsc: 'Cambio-Clave', action: '/cambioClave'},
                                {dsc: 'Salir', action: '/exit'}, 
                                ]
      if( this.User_Role == 'Administrador') this.listOptionsPerfil.unshift({dsc: 'Usuarios', action: '/usuarios'})   ;              

      // Genera itmMenues de SubMenu
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
.menu {
  /* width: 90%; */
  margin: 0.133rem;
  padding: 0.133rem;
  /* height: 2.3rem; */
  font-size: 1.1rem;
 
}
.itmMenu {
  background-color: var(--background-menu) !important;
  font-size: 1.4rem;
  color: var(--font-color);
  /* color: rgb(95, 127, 138); */
  width: 12rem;
  height: 7rem;
  margin: 2rem 4rem;
  padding: 1.0rem;
  /* border: 1px solid gray; */
  box-shadow: 9px 7px 5px rgba(212, 211, 211, 0.77);
    box-shadow: 9px 7px 5px rgba(185, 181, 181, 0.77);
}
.itmMenu:hover {
  cursor: pointer;
  /* font-size: 1.55rem; */
  color: white;
  /* color: black; */
  /* width: 12.1rem;
  height: 6rem;    */

  box-shadow: 9px 7px 5px rgba(185, 181, 181, 0.77);
}
div p {
    text-align: center;
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