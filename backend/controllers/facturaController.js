const Factura = require('../models/Factura');
const FacturaItem = require('../models/FacturaItem');
const Contrato = require('../models/Contrato');
const Cliente = require('../models/Cliente');
const Producto = require('../models/Producto');

exports.getAllFacturas = async (req, res) => {
  try {
    const facturas = await Factura.findAll({
      include: [
        { model: Contrato, include: [Cliente] },
        {
          model: FacturaItem,
          include: [Producto]
        }
      ]
    });
    res.json(facturas);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch invoices' });
  }
};

exports.createFactura = async (req, res) => {
  try {
    const factura = await Factura.create(req.body, {
      include: [FacturaItem]
    });
    res.json(factura);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create invoice' });
  }
};

exports.getFacturaById = async (req, res) => {
  try {
    const factura = await Factura.findByPk(req.params.id, {
      include: [
        { model: Contrato, include: [Cliente] },
        {
          model: FacturaItem,
          include: [Producto]
        }
      ]
    });
    if (!factura) {
      return res.status(404).json({ error: 'Invoice not found' });
    }
    res.json(factura);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch invoice' });
  }
};

exports.updateFactura = async (req, res) => {
  try {
    const factura = await Factura.findByPk(req.params.id);
    if (!factura) {
      return res.status(404).json({ error: 'Invoice not found' });
    }
    await factura.update(req.body);
    res.json(factura);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update invoice' });
  }
};

exports.deleteFactura = async (req, res) => {
  try {
    const factura = await Factura.findByPk(req.params.id);
    if (!factura) {
      return res.status(404).json({ error: 'Invoice not found' });
    }
    await factura.destroy();
    res.json({ message: 'Invoice deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete invoice' });
  }
};
