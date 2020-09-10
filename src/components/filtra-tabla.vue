// Filtra-Tabla.vue
<template>
    <div class='content-search d-flex align-items-center'>
        <input v-model='strSearch' class="filterTable filterInput" type="text" size="30" placeholder="Ingrese texto a buscar" autofocus>
        <span class="filterTable filterReset filterInput" @click="strSearch='';">X</span>
        <!-- <i class="fas fa-search filterTableIcon"></i> -->
        <!-- 2 iconos: 1. Lupa strSearch==''      2. X si strSearch != '' -->
    </div>    
</template>

<script>
export default {
    name: 'filtra-tabla',
    props: {
        // 'recordList','colsSearch','listItems'
        recordList: {type: Array, required: true},
        colsSearch: {type: Array, required: true}
        // default: function() {    // Funcion de fabrica para devolver objects o arrays
        //     return {msg: 'hola'}
        // }
    },
    data() {
        return {
            strSearch: '',
        }
    },
    computed: {
        tempList: function(){          // Busca del elemento, varias columnas
        // console.log('FiltraTabComputed.tempList[]');
        let strSearch = this.strSearch;    // Search input-change
        
        let eleSearch = this.colsSearch;
        let searchReturn = false;
        return this.recordList.filter(function(item){
            searchReturn = false;
            for(let i=0; i < eleSearch.length; i++){
                // console.log('==>', item[eleSearch[i]] );
                if( !item[eleSearch[i]] ) {
                    // console.log('Not exist attribute: ', eleSearch[i]);
                }else{
                    if( item[eleSearch[i]].toLowerCase().includes(strSearch.toLowerCase()) ) searchReturn = true;
                }
            }
            return searchReturn;
            });
        }
    },
    watch: {
        tempList: function(value){
            // console.log(value);
            // this.listItems = value;
           this.$emit('filter_Process', value);
        }
    }
}
</script>
<style scoped>
.content-search {
    border: 1px solid rgb(185, 182, 182);
    font-size: inherit;
}
.filterTable {
    background-color: rgb(245, 245, 245);
    /* background-color:whitesmoke; */
    border: 0.072rem;
    padding: 0.04rem 0.286rem; 
    /* font-size: 1rem; */
    /* width: 13rem; */

}
.filterTable:focus {
    background-color: rgb(255, 255, 255);
    box-shadow: none;
    outline: none;
}
.formControl {
   /* line-height: 1rem !important; */
   /* height: 3rem !important; */
}
.filterInput {
   height: 1.90rem;
}
.filterInput:hover {
    background-color: rgb(255, 255, 255);
}
.filterReset {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-content: center;
    font-size: 0.8rem;
    background-color: var(--btnBackground); 
    border-radius: var(--border-radius) !important;   
    padding-left: 0.4rem;
    padding-right: 0.4rem;
    /* border-top-left-radius: 0 !important;  
    border-bottom-left-radius: 0 !important; */

}
.filterReset:hover {
    cursor: pointer;    
}
</style>