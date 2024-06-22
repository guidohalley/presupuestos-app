const express = require('express');
const bodyParser = require('body-parser');
const sequelize = require('./config/database');
const app = express();

app.use(bodyParser.json());

// Define rutas y controladores aquí
const PDFDocument = require('pdfkit');
app.post('/api/presupuesto', (req, res) => {
    const doc = new PDFDocument();

    // Configura el PDF aquí con los datos del presupuesto
    doc.text('Presupuesto', 50, 50);

    // Guardar el archivo PDF en el servidor o enviarlo directamente al cliente
    res.setHeader('Content-Type', 'application/pdf');
    doc.pipe(res);
    doc.end();
});

sequelize.sync().then(() => {
    app.listen(3000, () => {
        console.log('Server is running on port 3000');
    });
}).catch(err => {
    console.error('Unable to connect to the database:', err);
});
