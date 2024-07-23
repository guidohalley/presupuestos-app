const express = require('express');
const { getClientes, createCliente } = require('../controllers/clienteController');
const router = express.Router();

router.get('/', getClientes);
router.post('/', createCliente);

module.exports = router;
