

document.querySelectorAll('button').forEach( $ele => {

  $ele.addEventListener( 'click', calcular_compra );

});

function calcular_compra( evt ){

  let resultado = document.querySelector('#valor_compra');
  
  resultado.innerHTML = "";  

  if( evt.target.id == 'calcular_compra' ){

    let 
      valor     = parseFloat(document.querySelector('#valor_unitario').innerHTML),
      cantidad  = parseInt(document.querySelector('#cantidad').value),
      descuento = parseFloat(document.querySelector('#categoria').value)
    ;

    if( !cantidad ){

      alert('La cantidad debe ser al menos de 1...');

      cantidad.value = "1";
    }
    else{

      resultado.innerHTML = ( valor * cantidad ) - ( valor * cantidad * descuento );

    }

  }

}



