function esPalindromo(cadena) {
    const cadenaProcesada = cadena.toLowerCase().replace(/\s/g, '');

    const cadenaInvertida = cadenaProcesada.split('').reverse().join('');

    return cadenaProcesada === cadenaInvertida;
}

// Ejemplo d uso:
let ejemploPalindromo = "Anita lava la tina";
console.log(esPalindromo(ejemploPalindromo)); 
