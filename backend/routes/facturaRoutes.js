const express = require('express');
const router = express.Router();
const facturaController = require('../controllers/facturaController');

// Rutas para manejar las facturas
router.get('/', facturaController.getAllFacturas);
router.post('/', facturaController.createFactura);
router.get('/:id', facturaController.getFacturaById);
router.put('/:id', facturaController.updateFactura);
router.delete('/:id', facturaController.deleteFactura);

module.exports = router;
