function factoriza(numero) {
    let factores = [];
    
    for (let i = 1; i <= numero; i++) {
        if (numero % i === 0) {
            factores.push(i);
        }
    }

    return factores;
}

let numeroAEvaluar = 20;
let resultado = factoriza(numeroAEvaluar);
console.log(resultado);
