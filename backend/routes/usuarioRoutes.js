import express from 'express';
import { register, login, getAllUsuarios, getUsuarioById, updateUsuario, deleteUsuario } from '../controllers/usuarioController.js';

const router = express.Router();

// Rutas para manejar los usuarios
router.post('/register', register);
router.post('/login', login);
router.get('/', getAllUsuarios);
router.get('/:id', getUsuarioById);
router.put('/:id', updateUsuario);
router.delete('/:id', deleteUsuario);

export default router;
