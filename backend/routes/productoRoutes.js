import express from 'express';
import { getAllProductos, createProducto, getProductoById, updateProducto, deleteProducto } from '../controllers/productoController.js';

const router = express.Router();

// Rutas para manejar los productos
router.get('/', getAllProductos);
router.post('/', createProducto);
router.get('/:id', getProductoById);
router.put('/:id', updateProducto);
router.delete('/:id', deleteProducto);

export default router;
