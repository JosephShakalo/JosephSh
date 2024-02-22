function bubbleSort(lista) {
    let n = lista.length;

    for (let i = 0; i < n - 1; i++) {
        for (let j = 0; j < n - 1 - i; j++) {

            if (lista[j] > lista[j + 1]) {
                const temp = lista[j];
                lista[j] = lista[j + 1];
                lista[j + 1] = temp;
            }
        }
    }

    return lista;
}


const numeros = [5, 2, 8, 1, 7];
const numerosOrdenados = bubbleSort(numeros);
console.log("Lista ordenada:", numerosOrdenados);
