import Factura from '../models/Factura.js';
import FacturaItem from '../models/FacturaItem.js';
import Contrato from '../models/Contrato.js';
import Cliente from '../models/Cliente.js';
import Producto from '../models/Producto.js';

export const getAllFacturas = async (req, res) => {
  try {
    const facturas = await Factura.findAll({
      include: [
        { model: Contrato, include: [Cliente] },
        {
          model: FacturaItem,
          include: [Producto],
        },
      ],
    });
    res.json(facturas);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch invoices" });
  }
};

export const createFactura = async (req, res) => {
  try {
    const factura = await Factura.create(req.body, {
      include: [FacturaItem],
    });
    res.json(factura);
  } catch (error) {
    res.status(500).json({ error: "Failed to create invoice" });
  }
};

export const getFacturaById = async (req, res) => {
  try {
    const factura = await Factura.findByPk(req.params.id, {
      include: [
        { model: Contrato, include: [Cliente] },
        {
          model: FacturaItem,
          include: [Producto],
        },
      ],
    });
    if (!factura) {
      return res.status(404).json({ error: "Invoice not found" });
    }
    res.json(factura);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch invoice" });
  }
};

export const updateFactura = async (req, res) => {
  try {
    const factura = await Factura.findByPk(req.params.id);
    if (!factura) {
      return res.status(404).json({ error: "Invoice not found" });
    }
    await factura.update(req.body);
    res.json(factura);
  } catch (error) {
    res.status(500).json({ error: "Failed to update invoice" });
  }
};

export const deleteFactura = async (req, res) => {
  try {
    const factura = await Factura.findByPk(req.params.id);
    if (!factura) {
      return res.status(404).json({ error: "Invoice not found" });
    }
    await factura.destroy();
    res.json({ message: "Invoice deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete invoice" });
  }
};
