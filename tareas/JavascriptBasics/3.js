function reverseArray(arr) {
    const reversedArray = [];
    for (let i = arr.length - 1; i >= 0; i--) {
        reversedArray.push(arr[i]);
    }
    return reversedArray;
}

function reverseArrayInPlace(arr) {
    const length = arr.length;
    for (let i = 0; i < Math.floor(length / 2); i++) {

        const temp = arr[i];
        arr[i] = arr[length - 1 - i];
        arr[length - 1 - i] = temp;
    }
}

const originalArray = [1, 2, 3, 4, 5];

const newArray = reverseArray(originalArray.slice()); 
console.log("Nuevo arreglo:", newArray); 
console.log("Arreglo original:", originalArray); 

reverseArrayInPlace(originalArray);
console.log("Arreglo modificado in-place:", originalArray);
