"use strict";

import express from "express";

const app = express();
const port = 5000; 
app.use(express.json());

// Simulando una base de datos con un array
let cartas = [
{ id: '1', nombre: 'Carta 1', descripcion: 'Descripción de la Carta 1' },
{ id: '2', nombre: 'Carta 2', descripcion: 'Descripción de la Carta 2' },
{ id: '3', nombre: 'Carta 3', descripcion: 'Descripción de la Carta 3' },
{ id: '4', nombre: 'Carta 4', descripcion: 'Descripción de la Carta 4' },
{ id: '5', nombre: 'Carta 5', descripcion: 'Descripción de la Carta 5' },
{ id: '6', nombre: 'Carta 6', descripcion: 'Descripción de la Carta 6' }
];

// Regresa todas las cartas
app.get(`/api/cartas`, (req, resp) => {
    if (cartas.length > 0) {
        resp.status(200).json(cartas);
    } else {
        resp.status(404).send({ message: "No hay cartas" });
    }
});

// Regresa una carta por ID
app.get(`/api/cartas/:id`, (req, resp) => {
    const { id } = req.params;
    const carta = cartas.find(c => c.id == id);
    if (carta) {
        resp.status(200).json(carta);
    } else {
        resp.status(404).send({ message: "Carta no encontrada" });
    }
});

// Agrega una nueva carta
app.post(`/api/cartas`, (req, resp) => {
    const nuevaCarta = req.body;
    // Verificar si la carta ya existe
    const existe = cartas.some(c => c.id == nuevaCarta.id);
    if (!existe) {
        cartas.push(nuevaCarta);
        resp.status(201).send({ message: "Carta agregada correctamente" });
    } else {
        resp.status(400).send({ message: "La carta ya existe" });
    }
});

// Borrar una carta por ID
app.delete(`/api/cartas/:id`, (req, resp) => {
    const { id } = req.params;
    const indice = cartas.findIndex(c => c.id == id);
    if (indice !== -1) {
        cartas.splice(indice, 1);
        resp.status(200).send({ message: "Carta borrada correctamente" });
    } else {
        resp.status(404).send({ message: "Carta no encontrada" });
    }
});

// Actualizar una carta por ID
app.patch(`/api/cartas/:id`, (req, resp) => {
    const { id } = req.params;
    const actualizaciones = req.body;
    const carta = cartas.find(c => c.id == id);
    if (carta) {
        // Actualizar solo los campos que vienen en el JSON
        Object.keys(actualizaciones).forEach(key => carta[key] = actualizaciones[key]);
        resp.status(200).send({ message: "Carta actualizada correctamente" });
    } else {
        resp.status(404).send({ message: "Carta no encontrada" });
    }
});

app.listen(port, () => {
    console.log(`listening on port ${port}`);
});

//Para checar el servidor ir a: curl http://127.0.0.1:5000/api/{ATRIBUTO}