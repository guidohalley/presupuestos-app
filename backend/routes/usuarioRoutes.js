const express = require('express');
const router = express.Router();
const usuarioController = require('../controllers/usuarioController');

// Rutas para manejar los usuarios
router.post('/register', usuarioController.register);
router.post('/login', usuarioController.login);
router.get('/', usuarioController.getAllUsuarios);
router.get('/:id', usuarioController.getUsuarioById);
router.put('/:id', usuarioController.updateUsuario);
router.delete('/:id', usuarioController.deleteUsuario);

module.exports = router;
