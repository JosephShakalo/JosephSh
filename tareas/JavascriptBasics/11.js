function ordenAlfabetico(listaCadenas) {
    return listaCadenas.slice().sort();
}

// Ejemplo de uso:
let listaDesordenada = ["pera", "manzana", "uva","banana"];
let listaOrdenada = ordenAlfabetico(listaDesordenada);
console.log(listaOrdenada);
