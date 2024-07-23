import express from 'express';
import { getAllFacturas, createFactura, getFacturaById, updateFactura, deleteFactura } from '../controllers/facturaController.js';

const router = express.Router();

// Rutas para manejar las facturas
router.get('/', getAllFacturas);
router.post('/', createFactura);
router.get('/:id', getFacturaById);
router.put('/:id', updateFactura);
router.delete('/:id', deleteFactura);

export default router;
