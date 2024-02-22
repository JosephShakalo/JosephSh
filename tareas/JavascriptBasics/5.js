function calcularMaximoDivisor(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

let num1 = 36;
let num2 = 48;
let resultado = calcularMaximoDivisor(num1, num2);
console.log(`El máximo divisor de ${num1} y ${num2} es: ${resultado}`);
