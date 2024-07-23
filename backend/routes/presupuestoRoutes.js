import express from 'express';
import { getAllPresupuestos, createPresupuesto, getPresupuestoById, updatePresupuesto, deletePresupuesto } from '../controllers/presupuestoController.js';

const router = express.Router();

router.get('/', getAllPresupuestos);
router.post('/', createPresupuesto);
router.get('/:id', getPresupuestoById);
router.put('/:id', updatePresupuesto);
router.delete('/:id', deletePresupuesto);

export default router;
