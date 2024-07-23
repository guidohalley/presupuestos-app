const express = require('express');
const clienteRoutes = require('./clienteRoutes');
const contratoRoutes = require('./contratoRoutes');
const cotizacionRoutes = require('./cotizacionRoutes');
const facturaRoutes = require('./facturaRoutes');
const presupuestoRoutes = require('./presupuestoRoutes');
const productoRoutes = require('./productoRoutes');
const usuarioRoutes = require('./usuarioRoutes');

const router = express.Router();

router.use('/clientes', clienteRoutes);
router.use('/contratos', contratoRoutes);
router.use('/cotizaciones', cotizacionRoutes);
router.use('/facturas', facturaRoutes);
router.use('/presupuestos', presupuestoRoutes);
router.use('/productos', productoRoutes);
router.use('/usuarios', usuarioRoutes);

module.exports = router;
