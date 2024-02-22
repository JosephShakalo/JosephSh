function esPotenciaDeDos(numero) {
    if (numero <= 0) {
        return false;  
    }

   
    return (numero & (numero - 1)) === 0 && numero !== 0;
}


console.log(esPotenciaDeDos(16));  

