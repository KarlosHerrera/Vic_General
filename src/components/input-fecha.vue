// input-fecha.vue
<template>
    <div class="fecha_contenedor form-control form-control-sm">
        <input ref='dia' name='dd' v-model='dd' type="text" minlength="2" maxlength="2" size='2' 
            @click="select($event.target)" @keyup="numDia($event.target)"
            class="dd fecha_input" autocomplete='off'><span class='barras'>/</span>

        <input ref='mes' name='mm' v-model='mm' type="text" minlength="2" maxlength="2" size='2'
             @click="select($event.target)" @keyup="numMes($event.target)"
            class="mm fecha_input" autocomplete='off'
            ><span  class='barras' >/</span>

        <input ref='anio' name='aa' v-model='aa' type="text"  minlength="4" maxlength="4" size='4'
            @click="select($event.target)" @keyup="numAnio($event.target)"
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
        fecha: String,
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
        },
        select(self){
            // console.log(`click(${self})`)
            self.select();
            // this.$refs.dia.select();
        },
        numDia(self){
            // console.log(`numDia(${self})`)
            let numValido = '';
            let numero = self.value;
            // console.log('----------------------------')
            // console.log('Input => ', numero)
            for (let i=0; i < numero.length; i++) {
                if ('1234567890'.indexOf(numero.charAt(i)) != -1) numValido += numero.charAt(i);
            }
            numero = numValido;
            switch( numero.length ) {
                // case 0:
                //     numValido = 'dd'
                //     break; 
                case 1:
                    if( parseInt(numero, 10) > 3 ) numValido = '0'+numero;
                    break;
                case 2:
                    if( parseInt(numero, 10) > 31 ) numValido = '31';
                    this.select(this.$refs.mes)
                    break;
                default:
                    console.log('Dia, sin valor adecuado.')
            }          
            self.value = numValido;
            // console.log('Devuelve => ', numValido)            
        },
        numMes(self){
            // console.log(`numMes(${self})`)
            let numValido = '';
            let numero = self.value;
            for (let i=0; i < numero.length; i++) {
                if ('1234567890'.indexOf(numero.charAt(i)) != -1) {
                    numValido += numero.charAt(i);
                }
            }
            numero = numValido;
            switch( numero.length ) {
                // case 0:
                //     numValido = 'dd'
                //     break; 
                case 1:
                    if( parseInt(numero, 10) > 1 ) numValido = 'dd';
                    break;
                case 2:
                    if( parseInt(numero, 10) > 12 ) numValido = '12';
                    // numValido = numValido.substring(0, numValido.length - 1)
                    this.select(this.$refs.anio)
                    break;
                default:
                    console.log('Mes,sin valor adecuado.')
            }             
            // console.log('numero.length = ', numero.length)
            // if( numero.length == 1 && parseInt(numero, 10) > 1 ){
            //     // console.log('1..')
            //     // numValido = ''
            //     numValido = 'dd'
            // }
            // if( numero.length == 2 && parseInt(numero, 10) > 12 ){
            //     numValido = numValido.substring(0, numValido.length - 1)
            //     numValido = '12'
            //     // console.log('2..')
            // }            
            self.value = numValido;
        },
        numAnio(self){
            // console.log(`numAnio(${self})`)
            let numValido = '';
            let numero = self.value;
            for (let i=0; i < numero.length; i++) {
                if ('1234567890'.indexOf(numero.charAt(i)) != -1) {
                    numValido += numero.charAt(i);
                }
            }
            numero = numValido;            
            switch( numero.length ) {
                case 1:
                    numValido = ( numero == '0' )? '': numero;
                    break;
                case 2:
                    numValido = numero;
                    break;
                case 3:
                    numValido = numero;
                    break;
                case 4:
                    numValido = numero;

                    break;                                        
                default:
                    console.log('Año, sin valor adecuado.')
            }  
            self.value = numValido;
        },        
        evalNumero(numero){
            console.log(`evalNumero(${numero})`)            
            let numValido = '';
            for (let i=0; i < numero.length; i++) {
                if ('1234567890'.indexOf(numero.charAt(i)) != -1) numValido += numero.charAt(i);
            }
            return numValido;
        }

    },
    mounted: function(){
        this.setComponent();
    }    

}
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
    padding: 1px 2px;
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
 width: 20px;
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