"use strict";

import express from "express";

const app = express();

const port = 5000;

app.use(express.json());

app.get(`/api/hello`, (req, resp) => {
    console.log("hello from server");
    resp.status(200).send("hello from server");
});

app.get(`/api/hello/:name`, (req, resp) => {
    console.log(req.params);
    resp.status(200).send(`hello ${req.params.name}`);
});

app.post(`/api/hello`, (req, resp) => {
    console.log(req.body); // Aquí se corrigió 'req,body' por 'req.body'
    resp.status(200).send(`hello ${req.body.name} ${req.body.surname}\n`);
});

app.listen(port, () => {
    console.log(`listening on port ${port}`);
});
