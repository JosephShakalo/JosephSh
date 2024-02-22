function capitalizarPrimeraLetra(cadena) {
    let palabras = cadena.split(" "); 
    let palabrasCapitalizadas = palabras.map(palabra => palabra.charAt(0).toUpperCase() + palabra.slice(1));
    let resultado = palabrasCapitalizadas.join(" ");
    return resultado;
}

let cadenaEntrada = "esta es una prueba";
let resultado = capitalizarPrimeraLetra(cadenaEntrada);
console.log(resultado);
