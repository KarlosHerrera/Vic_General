// input-fecha.vue
<template>
    <div class="input-group date">
        <div class="input-group date">
            <input id='idDate' type="text" class="">
        </div>
    </div>  
</template>

<script>
console.log('<< input-date.vue >>');

export default {
    name: 'input-fecha',
    data(){
        return {
            dd: '',
            mm: '',
            aa: ''
        }
    },    


    mounted: {
        // $('#idDate').datepicker({
        //     format: "dd/mm/yyyy",
        //     todayBtn: true,
        //     clearBtn: true,
        //     language: "es",
        //     todayHighlight: true
        // })      
    }
}
</script>

<style scoped>

</style>