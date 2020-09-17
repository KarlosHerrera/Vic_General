<template>
  <div id='app' class='d-flex flex-column'>
    <Home></Home>
      <div id='main' class="main d-flex align-self-center">
        <!-- <Menu></Menu>  -->
        <router-view/>
      </div>
    <div></div>
  </div>
</template>

<script>
console.log('<<< app.vue >>>');

import Home from './components/Home.vue'
// import Menu from './components/Menu.vue'

export default {
  name: 'App',
  components: {
    Home,
    // Menu
  },
  methods: {
    config_app(){
      // console.log('app.config_app()');
      this.$store.dispatch('config_app');

    }
  },
  mounted: function(){
  this.config_app();
 this.$router.push('/menu');  
  }   
}
</script>

<style>
#app, .main {
  margin: 0.10rem;
  padding: 0.16rem;
}
#app {
  /* display: flex; */
  /* justify-content: center;
  align-items: center; */

  height: 97%; 
  width: 97%;
  background-color: var(--background-main);

}
.main {

 height: 95%;
  /* padding: 5px 0; */
}
</style>
