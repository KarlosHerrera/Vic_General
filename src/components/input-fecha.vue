// input-fecha.vue
<template>
    <div class="fecha_contenedor form-control form-control-sm d-flex align-items-center" :class="{'deshabilita': habilita}"  @blur='exitComponent'>
        <!-- <label class="formControlLabel">{{ label }}</label> -->
        <input ref='dia' v-model='dd' type="text" minlength="2" maxlength="2" size='2' :disabled='habilita'
            @click="select($event.target)" @keyup="numDia($event.target)" @blur='diaBlur' @keyup.delete='borraFecha'
            class="dd fecha_input" :class="{'colorError': dd_invalido}" autocomplete='off'>
            <span class='barras' :class="{'deshabilita': habilita}">/</span>

        <input ref='mes' v-model='mm' type="text" minlength="2" maxlength="2" size='2' :disabled='habilita'
             @click="select($event.target)" @keyup="numMes($event.target)" @blur='mesBlur' @keyup.delete='borraFecha'
            class="mm fecha_input" autocomplete='off' >
            <span class='barras' :class="{'deshabilita': habilita}">/</span>

        <input ref='anio' v-model='aa' type="text"  minlength="4" maxlength="4" size='4' :disabled='habilita'
            @click="select($event.target)" @keyup="numAnio($event.target)" @keyup.delete='borraFecha'
            class="aa fecha_input" autocomplete='off'>

    </div>
    <!-- dia   ^(?:3[01]|[12][0-9]|0?[1-9])$    -->
    <!-- mes   ^(0?[1-9]|1[1-2])$     -->
    <!-- ano   ^[1-9]{1}\d{3}$   -->
        <!-- <input ref='dia' name='dd' v-model='dd' type="text" minlength="2" maxlength="2" size='2' 
            @click="select($event.target)" @keyup="numDia($event.target)" @blur='diaBlur' 
            class="dd fecha_input" autocomplete='off'><span class='barras'>/</span>     
        -->
</template>

<script>
console.log('<< input-fecha.vue >>');

import moment from 'moment';
moment.locale('es');

export default {
    name: 'input-fecha',
    props: ['value','label','habilita'],
    data(){
        return {
            dd: 'dd',
            mm: 'mm',
            aa: 'aaaa',
            dd_invalido: false,
            mm_invalido: false,
            aa_invalido: false,
        }
    }, 
    computed: {
        fechaRetorno: function(){
            return this.aa+'-'+this.mm+'-'+this.dd;
        },
        // habilita: function(){
        //     return this.disabled
        // }

    },
    methods: {
        setComponent(){
            console.log('setComponent()')
            // this.$refs.dia.focus();
            // this.$refs.dia.select();
            // console.log('value: ', this.value)
            // this.fecha = $attrs.value;
            // console.log('setComponent().this.value > ', this.value)
            // if( this.value != '' ){
                let tmpFecha = moment(this.value);
                if( !tmpFecha.isValid() || typeof(this.value)=='undefined' ){
                    console.log('<input-fecha>Fecha incorrecta!')
                }else{                    // console.log('valido...')
                    this.dd= moment(tmpFecha).format('DD');
                    this.mm= moment(tmpFecha).format('MM');
                    this.aa= moment(tmpFecha).format('YYYY');
                }                 
            // }

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
            this.dd_invalido = false
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
                        exit = true;
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
                // this.evalFecha();   
                this.select(this.$refs.mes)
                this.dd_invalido = false;
            }
        },
        diaBlur(){
            // console.log('Dia-Perdiendo el foco')
            // let diaExpReg = new RegExp('^(?:3[01]|[12][0-9]|0?[1-9])$');
            // let dia = this.dd;
            // if ( !(diaExpReg.test(this.dia) && dia.length == 2 && this.evalFecha()) ){
            //     this.$refs.dia.focus();
            // }
            this.$refs.mes.focus();
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
        mesBlur(){
            // console.log('Mes-Perdiendo el foco')
            // let mesExpReg = new RegExp('^(0?[1-9]|1[1-2])$');
            // if (!mesExpReg.test(this.mm)) {
            //     // this.select(this.$refs.mes)
            //      console.log('mes!')
            //     valido = false;
            // }           
            /////// Si presiona tab, salir de la fecha 
            this.$refs.anio.focus();
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
                if( !this.evalFecha() ){
                   this.$refs.anio.focus();  
                }
                // this.select(this.$refs.mes)
            }   
        },
        mesAnio(){
            // console.log('Mes-Perdiendo el foco')
            // let mesExpReg = new RegExp('^(0?[1-9]|1[1-2])$');
            // if (!mesExpReg.test(this.mm)) {
            //     // this.select(this.$refs.mes)
            //      console.log('mes!')
            //     valido = false;
            // }           
            /////// Si presiona tab, salir de la fecha 
            // this.$refs.anio.focus();
            if( !this.evalFecha() ){
                this.$refs.anio.focus();  
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

            // let anioExpReg = new RegExp('^[1-9]{1}[0-9]{3}$');
            // if (!anioExpReg.test(this.aa)) {
            //     // this.select(this.$refs.anio)
            //     valido = false;
            // } 
            // console.log('=>', this.aa+'-'+this.mm+'-'+this.dd)
            if( this.aa.trim()=='' && this.mm.trim()=='' && this.anio.trim()=='' ){
                this.dd = 'dd';
                this.mm = 'mm';
                this.aa = 'aaaa';
                this.$emit('input', undefined);                               
            }
            let fecha = moment(this.aa+'-'+this.mm+'-'+this.dd);
            // console.log('fecha => ', fecha)
            if( fecha.isValid() ){
                // console.log('fecha correcta')
                // this.$emit('confirma_fecha', this.aa+'-'+this.mm+'-'+this.dd );  
                this.$emit('input', this.aa+'-'+this.mm+'-'+this.dd );       
                // this.$emit('input',$event.target.value)         
                valido = true;
            }else{
                console.log('fecha incorrecta')
                this.dd_invalido = true,
                this.mm_invalido = true,
                this.aa_invalido = true, 
                valido = false;
            }   
            return valido;
        },
        borraFecha(e){
            // console.log(`borraFecha(${e.key})`)
            if (e.key == 46) {  // delete
                this.dd = 'dd';
                this.mm = 'mm';
                this.aa = 'aaaa';
                this.$emit('input', undefined); 
            }
        },
        exitFecha(){
            console.log('exitFecha()')

        },
        exitComponent(){
            console.log('exitComponent()')            
        }
    },
    watch: {
        fechaFinal: function(){
        //    this.$emit('filter_Process', value);
            console.log('watch.fechaFinal()')
           return this.aa+'-'+this.mm+'-'+this.dd;
        }
    },
    created() {
        // window.addEventListener('keydown', (e) => {
        //     console.log('tecla presionada: ', e.key);
        //     // if (e.key == 'F4') {
        //     //     alert("funciona!");
        //     //     this.showModal = !this.showModal;
        //     // }
        // })
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
.deshabilita {
    background-color: rgb(245, 245, 245);
}
</style>