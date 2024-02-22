function cadenaMasFrecuente(listaCadenas) {
    let frecuencias = {};
    for (let cadena of listaCadenas) {
        frecuencias[cadena] = (frecuencias[cadena] || 0) + 1;
    }

    let maxFrecuencia = 0;
    let cadenaFrecuente = null;
    for (let cadena in frecuencias) {
        if (frecuencias[cadena] > maxFrecuencia) {
            cadenaFrecuente = cadena;
            maxFrecuencia = frecuencias[cadena];
        }
    }

    return cadenaFrecuente;
}

let listaCadenas = ["manzana", "banana", "manzana", "pera", "uva"];
let resultadoCadenaFrecuente = cadenaMasFrecuente(listaCadenas);
console.log(resultadoCadenaFrecuente);
