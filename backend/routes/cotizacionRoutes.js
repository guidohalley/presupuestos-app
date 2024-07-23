import express from 'express';
import { getAllCotizaciones, createCotizacion, getCotizacionById, updateCotizacion, deleteCotizacion } from '../controllers/cotizacionController.js';

const router = express.Router();

// Rutas para manejar las cotizaciones
router.get('/', getAllCotizaciones);
router.post('/', createCotizacion);
router.get('/:id', getCotizacionById);
router.put('/:id', updateCotizacion);
router.delete('/:id', deleteCotizacion);

export default router;
