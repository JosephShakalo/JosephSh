function medianaYModa(listaNumeros) {
    const ordenados = [...listaNumeros].sort((a, b) => a - b);
    const longitud = ordenados.length;
    
    const mediana = longitud % 2 === 0
        ? (ordenados[longitud / 2 - 1] + ordenados[longitud / 2]) / 2
        : ordenados[Math.floor(longitud / 2)];
    
    const frecuencias = {};
    let moda = null;
    let maxFrecuencia = 0;

    ordenados.forEach(numero => {
        frecuencias[numero] = (frecuencias[numero] || 0) + 1;

        if (frecuencias[numero] > maxFrecuencia) {
            moda = numero;
            maxFrecuencia = frecuencias[numero];
        }
    });

    return { mediana, moda };
}

// Ejemplo de uso:
let listaNumeros = [5, 2, 3, 5, 1, 2, 3, 4];
let resultado = medianaYModa(listaNumeros);
console.log(resultado);
