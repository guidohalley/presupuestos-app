import express from 'express';
import clienteRoutes from './clienteRoutes.js';
import contratoRoutes from './contratoRoutes.js';
import cotizacionRoutes from './cotizacionRoutes.js';
import facturaRoutes from './facturaRoutes.js';
import presupuestoRoutes from './presupuestoRoutes.js';
import productoRoutes from './productoRoutes.js';
import usuarioRoutes from './usuarioRoutes.js';

const router = express.Router();

router.use('/clientes', clienteRoutes);
router.use('/contratos', contratoRoutes);
router.use('/cotizaciones', cotizacionRoutes);
router.use('/facturas', facturaRoutes);
router.use('/presupuestos', presupuestoRoutes);
router.use('/productos', productoRoutes);
router.use('/usuarios', usuarioRoutes);

export default router;
