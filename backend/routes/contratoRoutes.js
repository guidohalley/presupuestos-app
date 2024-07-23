import express from 'express';
import { getAllContratos, createContrato, getContratoById, updateContrato, deleteContrato } from '../controllers/contratoController.js';

const router = express.Router();

// Rutas para manejar los contratos
router.get('/', getAllContratos);
router.post('/', createContrato);
router.get('/:id', getContratoById);
router.put('/:id', updateContrato);
router.delete('/:id', deleteContrato);

export default router;
