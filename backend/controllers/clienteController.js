import Cliente from '../models/Cliente.js';

export const getClientes = async (req, res) => {
  try {
    const clientes = await Cliente.findAll();
    res.json(clientes);
  } catch (error) {
    res.status(500).json({ error: 'Error fetching clients' });
  }
};

export const createCliente = async (req, res) => {
  try {
    const { nombre, email, telefono, direccion } = req.body;
    const newCliente = await Cliente.create({
      nombre,
      email,
      telefono,
      direccion,
    });
    res.status(201).json(newCliente);
  } catch (error) {
    res.status(500).json({ error: 'Error creating client' });
  }
};
