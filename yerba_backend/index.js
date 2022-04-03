const express = require('express');
const app = express();


const PORT = 8080;
app.listen(PORT);
app.use(express.json())



app.get('/tshirt', (req, res) => {
    res.status(200).send({
        tshirt: 't',
        size: 'large '
    })
});

app.post('/tshirt/:id', (req, res) => {
    const { id } = req.params;
    const { logo } = req.body;

    if(!logo) {
        res.status(418).send({ message: 'logo? modCheck?' })
    }

    res.status(200).send({
        tshirt: `T with your ${logo} and ID of ${id}`, 
    })
});