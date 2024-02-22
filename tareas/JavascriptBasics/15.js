function ordenDescendente(listaNumeros) {
    return listaNumeros.slice().sort((a, b) => b - a);
}

let listaDesordenada = [5, 2, 8, 1, 4];
let listaOrdenDescendente = ordenDescendente(listaDesordenada);
console.log(listaOrdenDescendente);
