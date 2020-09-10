//  form.js

'use strict';

export function evalInput(obj){
	// console.log('evalua(name= '+obj.name+'){...}');
	//let ele = document.querySelector("#"+e.target.id);	// obj = objeto evento es pasado como argumento
	let idForm = obj.form.id;								// Id del formulario padre
	let objForm = document.getElementById(idForm);			// Form padre del input 
	if( !objForm ) console.log('Form no encontrado!');
	// let btnSave = objForm.getAttribute('data-btnSave');	/ objeto boton Save (form: data-btnSave='idBoton')
	let btnEnable = objForm.getAttribute('data-btnEnable');	// objeto boton por habilitar (form: data-btnEnable='idBoton')
		// let btnHabilita = objForm.getAttribute('data-btnHabilita');	// TemporaL
    let sPatron = obj.getAttribute("pattern");				// Valor del patron (string)
	let idInput = obj.getAttribute("id");					// Valor del id
	let lblError = document.getElementById(idInput+'Error');
	let txtError = '';
	if(lblError) txtError = lblError.textContent;			// Texto del label de error

	//let oExpReg = new RegExp(sPatron);
	// Crea el objeto patron para el 			// Longitud maxima definida por atributo elemento
	//let maxLength = obj.getAttribute("maxlength");
	let sValor = obj.value;									// Valor actual del elemento 'string'
	let nLonText = sValor.length;							// Longitud del valor
	// let lValido = obj.checkValidity();						// test del input
	// let lEstado = obj.validity.valid;						// estado resultante del conjunto de atributos del input
	let upper = obj.getAttribute('data-upper');
	if(upper){
		// let vue_valor = obj.getAttribute('v-model');
		// console.log('vue_valor = ',  vue_valor);
		switch(upper.toUpperCase()) {
			case "1C":
			if(nLonText==1) obj.value = sValor.toUpperCase(); 
			break;
		case "ALL":
			obj.value = sValor.toUpperCase();
			break;
		default:

		}
		//   console.log('nuevo valor =', obj.value);	
	}

	let vForm = objForm.checkValidity();					// Evalua la validez inteegral del Form

	//console.log('idForm=', idForm);
// console.dir(btnEnable);
// console.dir(objForm);
// console.log('---------------------------------')
// console.log(lblError);
// console.log('form.checkValidity= ' , vForm );
// console.log('Resultante final del input = ', lEstado);
// console.log('input.checkValidity= ', lValido);

	//texto = texto.substring(0,texto.length-1);	// elimina el caracter maximo

	if ( !evalExpReg(sPatron, sValor) ) {
		if( lblError && txtError.length>0 ) { lblError.classList.add('colorError'); }else{ obj.classList.add('colorError'); }
	}else{
		if( lblError && txtError.length>0 ) { lblError.classList.remove('colorError'); }else{ obj.classList.remove('colorError'); }
	}
	btnEnable = document.getElementById(btnEnable);		// Boton de confirmacion (form-data)
	if( vForm ) {
		if( btnEnable ) btnEnable.removeAttribute('disabled');
	}else{
		if( btnEnable ) btnEnable.setAttribute('disabled','');
	}
}
export function evalValue(id){
	// console.log(`evalValue(${id})`);
	if( !id || id == null || !typeof(Id) == 'string') return false;	
	let obj = document.getElementById(id);
	if( !obj ) return false;
	let sValor = obj.value;
	let sPatron = obj.getAttribute("pattern");
	let sRequerido = obj.getAttribute("required");
	// console.log('required... ', sRequerido);
	if( sRequerido && sValor.trim() == '' ) return false;
	if( (!sPatron || sPatron != '') && sValor.trim() != '' ){
		// console.log('expresion regular...');
		if ( !evalExpReg(sPatron, sValor) )	return false;
	}
	return true;
}
// function evalValues(aValues){
// console.log(`evalValues(${aValues})`);	
// 	return true;
// }
export function evalString(value){
	// console.log(`evalString(${value})`);
	if( !value || value == null || !typeof(value) == 'string') return false;
	if( value.trim() == '') return false;
	return true;
}
// function evalStrings(){
// 	return true;
// }
export function evalNumber(value){
	// console.log(`evalNumber(${value})`);
	if( !value || value == null || !typeof(value) == 'number') return false;
	if( value== 0 ) return false;	
	return true;
}
function evalExpReg(sPatron, sValor){
	// Evalua Expresion Regular del Input
	// if( arguments.length != 2) console.log('evalExpReg() -> Arguments no valid.');
	if( sPatron == null || sValor == null ) return false;	
	// console.log("evaluaPatron( "+sPatron+" , "+sValor+" )");
	let oExpReg = new RegExp(sPatron);
		if (!oExpReg.test(sValor)) {
			// console.log("invalido");
			return false;
		}
		// console.log("valido");
		return true;					
}

export function evalForm(idForm){
	if( !idForm) return false;
	var oForm=document.getElementById(idForm);
	if( !oForm ){ console.log('Form (id='+idForm+'), not found.'); return false; }
	if( oForm.nodeName !== 'FORM' ){ console.log('Id = '+idForm+', no es un FORM'); return false;}
	if ( oForm.checkValidity() ){
		return false;
	}
	return true;			
}

export function seePassword(self, keys){
	// console.log('seePassword()');
	// if( arguments.length != 2) console.log('seePassword() -> Arguments no valid.');
	if( self == null || keys == null ) return false;
	// let text = 'password';
	let obj = null;
	let text = ( self.checked == true )? 'text': 'password';
    for(let e=0; keys.length > e; e++){  
		obj = document.getElementById( keys[e] );
		if (obj) obj.setAttribute('type',text);		// Modificando atributo
    }  
}

export function disabledForm(idForm, YesNo, ElementsForm){
    //  Habilita/Deshabilita (YesNo = boolean), todos los elementos del form () o una lista especifica (ElementsForm)
    // console.log('disabledForm('+idForm+')');
    // console.log('boolean: ', YesNo);
    if( !idForm || !YesNo ){
        console.log('disabledForm(idForm - String, YesNo - Boolean)');
        return null;
    }
    const objForm = document.getElementById(idForm).elements;
	if( !objForm ){ console.log('Form (Form ='+idForm+'), not found.'); return null; }
	// console.log(objForm);
    // if( objForm.nodeName !== 'FORM' ){ console.log('Form = '+idForm+', no es un FORM'); return null;}
    // console.dir(objForm);
    if( !ElementsForm ){        // Todos los elementos del form
        for(let e=0; e < objForm.length ; e++){
			// console.log('===>',objForm[e]);
            objForm[e].disabled = YesNo;
        }
    }else{  // Algunos elementos "array" del form 
        // console.log(typeof(ElementsForm));  // Array
        for(let e=0; e < ElementsForm.length ; e++){
			// console.log('==>', objForm[ElementsForm[e]]);
            objForm[ElementsForm[e]].disabled = YesNo; 
        }        
    }

}	// End disabledForm()

export function test(){
	console.log('func.test....export....');
}

// export default {
// 	evalInput,
// 	evalForm,
// 	seePassword,

// }