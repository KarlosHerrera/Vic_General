//  Menu.vue
<template>
  <div class='menu'>
    <div class='itmMenu' @click="action('/pliegomatrimonial')"><p>Pliego Matrimonial</p></div>
    <div class='itmMenu'>Dispensa de Impedimentos</div>
    <div class='itmMenu'>Licencia de Bautismo</div>
    <div class='itmMenu'>Dispensa de Proclamas</div>
    <div class='itmMenu'>Licencia de Traslado</div>
    <div class='itmMenu'>Dispensa Partida Baut.</div>
    <div class='itmMenu'>Medio Pliego</div>
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
  display: flex;
  flex-direction: row;
  /* justify-content: space-around; */
  /* align-items: center;   */
  width: 80%;
  margin: 0.133rem;
  padding: 0.134rem;
  height: 2.3rem;
  font-size: 1.1rem;
 
}  
.itmMenu {
  display: flex;
  justify-content: center;
  align-items: center;  
  background-color: var(--background-menu) !important;
  color: var(--font-color);
  margin: 3rem 6rem;
  font-size: 1.5rem;
  width: 15rem;
  height: 8rem;
  /* border: 1px solid gray; */
  box-shadow: 9px 7px 5px rgba(212, 211, 211, 0.77);
}
.itmMenu:hover {
  cursor: pointer;
  font-size: 1.55rem;
  color: white;
  width: 13.1rem;
  height: 8.1rem;   
  box-shadow: 9px 7px 5px rgba(185, 181, 181, 0.77);
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