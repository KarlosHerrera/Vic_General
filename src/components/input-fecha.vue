// input-fecha.vue
<template>
    <div class="fecha_contenedor form-control form-control-sm d-flex align-items-center"  @blur='exitFecha'>
        <input ref='dia' name='dd' v-model='dd' type="text" minlength="2" maxlength="2" size='2' 
            @click="select($event.target)" @keyup="numDia($event.target)"
            class="dd fecha_input" autocomplete='off'><span class='barras'>/</span>

        <input ref='mes' name='mm' v-model='mm' type="text" minlength="2" maxlength="2" size='2'
             @click="select($event.target)" @keyup="numMes($event.target)"
            class="mm fecha_input" autocomplete='off'
            ><span  class='barras' >/</span>

        <input ref='anio' name='aa' v-model='aa' type="text"  minlength="4" maxlength="4" size='4'
            @click="select($event.target)" @keyup="numAnio($event.target)" @blur='exitFecha'
            class="aa fecha_input" autocomplete='off'>
    </div>
    <!-- dia   ^(?:3[01]|[12][0-9]|0?[1-9])$    -->
    <!-- mes   ^(0?[1-9]|1[1-2])$     -->
    <!-- ano   ^[1-9]{1}\d{3}$   -->
</template>

<script>
console.log('<< input-fecha.vue >>');

import moment from 'moment';
moment.locale('es');

export default {
    name: 'input-fecha',
    props: {
        // formato: YYYY-MM-DD
        fecha: { type: String, default: '' },
        msg: String
    },
    data(){
        return {
            dd: 'dd',
            mm: 'mm',
            aa: 'aaaa',
        }
    },    
    methods: {
        setComponent(){
            console.log('setComponent()')
            // this.$refs.dia.focus();
            // this.$refs.dia.select();
            console.log('Fecha: ', this.fecha)
        },
        select(self){
            // console.log(`click(${self})`)
            self.select();
            // this.$refs.dia.select();
        },
        numDia(self){
            // console.log(`numDia(${self})`)
            let numValido = '';
            let exit = false;
            let numero = self.value;
            for (let i=0; i < numero.length; i++) {
                if ('1234567890'.indexOf(numero.charAt(i)) != -1) numValido += numero.charAt(i);
            }
            numero = numValido;
            switch( numero.length ) {
                // case 0:
                //     numValido = 'dd'
                //     break; 
                case 1:
                    if( parseInt(numero, 10) > 3 ){
                        numValido = '0';
                        // exit = true;
                    }else{
                        numValido = numero;
                    }
                    break;
                case 2:
                    if( parseInt(numero, 10) > 31 ) {
                        numValido = '31';
                    }else{
                        if ( numero == '00' ){
                            numValido = 'dd'
                        }else{
                            numValido = numero;
                            exit = true;
                        }
                    }
                    break;
                default:
                    console.log('Dia, sin valor adecuado.')

            }          
            self.value = numValido;
            if( exit ) {
                this.evalFecha();   
                this.select(this.$refs.mes)      
            }
        },
        numMes(self){
            // console.log(`numMes(${self})`)
            let numValido = '';
            let exit = false;
            let numero = self.value.trim();
            for (let i=0; i < numero.length; i++) {
                if ('1234567890'.indexOf(numero.charAt(i)) != -1) numValido += numero.charAt(i);
            }
            numero = numValido;
            switch( numero.length ) {
                // case 0:
                //     numValido = 'dd'
                //     break; 
                case 1:
                    if( parseInt(numero, 10) > 1 ){
                        numValido = '1';
                        // exit = true;
                    }else{
                        numValido = numero;
                    }
                    break;
                case 2:
                    if( parseInt(numero, 10) > 12 ){
                        numValido = '12';
                        exit = true;
                    }else{
                        if( numero == '00' ){
                             numValido = 'mm'; 
                        }else{
                            numValido = numero;
                            exit = true;
                        }      
                    }
                    // numValido = numValido.substring(0, numValido.length - 1)
                    // this.select(this.$refs.anio)
                    break;
                default:
                    console.log('Mes,sin valor adecuado.')
            }                        
            self.value = numValido; 
            if( exit ) {
                this.evalFecha();   
                this.select(this.$refs.anio)      
            }            
        },
        numAnio(self){
            // console.log(`numAnio(${self})`)
            let exit = false;
            let numValido = '';
            let numero = self.value;
            for (let i=0; i < numero.length; i++) {
                if ('1234567890'.indexOf(numero.charAt(i)) != -1) numValido += numero.charAt(i);
            }
            numero = numValido;            
            switch( numero.length ) {
                case 1:
                    if( numero == '0' ){
                        numValido = 'aaaa';
                    }else{
                        if( parseInt(numero, 10) > 2  ){
                            numValido ='2'
                        }else{
                            numValido = numero;
                        }
                    }
                    break;
                case 2:
                    numValido = numero;
                    break;
                case 3:
                    numValido = numero;
                    break;
                case 4:
                    numValido = numero;
                    exit = true;
                    break;                                        
                default:
                    console.log('Año, sin valor adecuado.')
            }  
            self.value = numValido;
            if( exit ) {
                this.evalFecha();
                // this.select(this.$refs.mes)
            }   
        },        
        evalNumero(numero){
            console.log(`evalNumero(${numero})`)            
            let numValido = '';
            for (let i=0; i < numero.length; i++) {
                if ('1234567890'.indexOf(numero.charAt(i)) != -1) numValido += numero.charAt(i);
            }
            return numValido;
        },
        evalFecha(){
            console.log('evalFecha()');
            let valido = true;
            let diaExpReg = new RegExp('^(?:3[01]|[12][0-9]|0?[1-9])$');
            if ( !diaExpReg.test(this.dd)){
                // this.select(this.$refs.dia)  && this.dd.length == 1 
                console.log('dia!')
                valido = false;
            } 
            let mesExpReg = new RegExp('^(0?[1-9]|1[1-2])$');
            if (!mesExpReg.test(this.mm)) {
                // this.select(this.$refs.mes)
                 console.log('mes!')
                valido = false;
            }            
            let anioExpReg = new RegExp('^[1-9]{1}[0-9]{3}$');
            if (!anioExpReg.test(this.aa)) {
                // this.select(this.$refs.anio)
                valido = false;
            } 
            console.log('=>', this.aa+'-'+this.mm+'-'+this.dd)
            let fecha = moment(this.aa+'-'+this.mm+'-'+this.dd);
            console.log('fecha => ', fecha)
            if(fecha.isValid){
                console.log('fecha correcta')
                valido = true;
            }else{
                console.log('fecha incorrecta')
                valido = false;
            }   
            return valido;
        },
        exitFecha(){
            console.log('exitFecha()')

        }
    },
    watch: {
        fechaFinal: function(){
        //    this.$emit('filter_Process', value);
            console.log('watch.fechaFinal()')
           return this.aa+'-'+this.mm+'-'+this.dd;
        }
    },
    mounted: function(){
        this.setComponent();
    }    

}
// $('input,textarea').keydown(function(){ 
//     if(event.keyCode==13) { 
//     event.keyCode = 9; 
//     } 
// }); 
</script>

<style scoped>
.fecha_contenedor {
    /* border: 1px solid coral; */

}
.fecha_input {
    /* background-color: silver; */
    color: inherit;
    font-size: inherit;
    border: none;
    padding: 0px 2px;
}
.fecha_input:focus {
    background-color: rgb(0,120,215);
    color: white;
}
.dd {
    text-align: right;
    /* width: 20px; */
}
.mm {
text-align: center;   
 width: 25px;
}
.aa {
text-align: left;   
 width: 33px; 
}
.barras {
    background-color: white;
    /* background-color: orange; */
    font-size: inherit;
}
</style>