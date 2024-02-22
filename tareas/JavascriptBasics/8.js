function quitaDuplicados(arreglo) {
    return Array.from(new Set(arreglo));
}

let arregloOriginal = [1, 0, 1, 10, 0, 1];
let resultado = quitaDuplicados(arregloOriginal);
console.log(resultado);
