function primerNoRepetido(cadena) {
    for (let caracter of cadena) {
        if (cadena.indexOf(caracter) === cadena.lastIndexOf(caracter)) {
            return caracter;
        }
    }
    return null;
}

let resultado = primerNoRepetido('abacddbec');
console.log('Primer carácter no repetido:', resultado);
