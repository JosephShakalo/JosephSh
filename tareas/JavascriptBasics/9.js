function longitudCadenaMasCorta(listaCadenas) {
    if (listaCadenas.length === 0) {
        return 0; // Manejar el caso de una lista vacía
    }

    let longitudMasCorta = listaCadenas[0].length;

    for (let i = 1; i < listaCadenas.length; i++) {
        let longitudActual = listaCadenas[i].length;
        if (longitudActual < longitudMasCorta) {
            longitudMasCorta = longitudActual;
        }
    }

    return longitudMasCorta;
}

let listaCadenas = ["Hola", "Adiós", "Programación", "JS"];
let resultado = longitudCadenaMasCorta(listaCadenas);
console.log(resultado);
