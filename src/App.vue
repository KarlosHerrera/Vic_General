<template>
  <div id='app' class='container'>
    <!-- <Home></Home> -->
      <div id='main' class="main">
        <!-- <Menu></Menu>  -->
        <router-view/>
      </div>
    <div></div>
  </div>
</template>

<script>
console.log('<<< app.vue >>>');

// import Home from './components/Home.vue'
// import Menu from './components/Menu.vue'

export default {
  name: 'App',
  components: {
    // Home,
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
#app {
  width: 99%;
}
</style>
