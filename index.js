const express = require('express');
const bodyParser = require('body-parser');
const PDFDocument = require('pdfkit');
const fs = require('fs');
const sequelize = require('./config/database');
const app = express();

app.use(bodyParser.json());

const createPDF = (data, filename) => {
  const doc = new PDFDocument();

  // Configurar el archivo de salida
  const filePath = `./pdfs/${filename}`;
  doc.pipe(fs.createWriteStream(filePath));

  // Añadir contenido al PDF
  doc.fontSize(20).text('Presupuesto de Servicios', { align: 'center' });
  doc.moveDown();
  doc.fontSize(12).text('Nota: Este presupuesto no incluye costos de publicidad.', { align: 'left' });
  doc.moveDown();

  doc.fontSize(16).text('Descripción del Proyecto', { underline: true });
  doc.moveDown();
  doc.fontSize(12).text('Servicios integrales de marketing digital y producción audiovisual ofrecidos por twodesigners para PUNTO IA, enfocados en la gestión de la marca.');
  doc.moveDown();

  doc.fontSize(16).text('Componentes del Proyecto', { underline: true });
  doc.moveDown();

  // Añadir los componentes del proyecto
  data.items.forEach(item => {
    doc.fontSize(14).text(item.nombre, { underline: true });
    doc.moveDown();
    doc.fontSize(12).text(`- Precio: $${item.precio.toFixed(2)}`);
    doc.moveDown();
  });

  doc.fontSize(16).text('Total del Presupuesto', { underline: true });
  doc.moveDown();
  doc.fontSize(12).text(`Total: $${data.items.reduce((total, item) => total + item.precio, 0).toFixed(2)}`);

  // Finalizar el documento
  doc.end();

  return filePath;
};

// Ruta para crear un presupuesto
app.post('/api/presupuesto', (req, res) => {
  const data = req.body;
  const filename = `presupuesto-${Date.now()}.pdf`;
  const filePath = createPDF(data, filename);

  res.json({ filename });
});

// Ruta para obtener el PDF
app.get('/api/presupuesto/:filename', (req, res) => {
  const filename = req.params.filename;
  const filePath = `./pdfs/${filename}`;
  res.download(filePath);
});

sequelize.sync().then(() => {
  app.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}).catch(err => {
  console.error('Unable to connect to the database:', err);
});
