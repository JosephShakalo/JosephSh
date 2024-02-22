function hackerSpeak(cadena) {
    const cambioLetras = {
        'a': '4',
        'e': '3',
        'i': '1',
        'o': '0',
        's': '5',
        't': '7'
    };

    const hackerCadena = cadena.toLowerCase().split('').map(caracter => cambioLetras[caracter] || caracter).join('');

    return hackerCadena;
}

let cadenaOriginal = 'Javascript es divertido';
let resultado = hackerSpeak(cadenaOriginal);
console.log(resultado)
