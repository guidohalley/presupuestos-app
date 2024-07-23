import Cotizacion from '../models/Cotizacion.js';
import CotizacionItem from '../models/CotizacionItem.js';
import Cliente from '../models/Cliente.js';
import Producto from '../models/Producto.js';
import Moneda from '../models/Moneda.js';

export const getAllCotizaciones = async (req, res) => {
  try {
    const cotizaciones = await Cotizacion.findAll({
      include: [
        { model: Cliente },
        { model: Moneda },
        {
          model: CotizacionItem,
          include: [{ model: Producto }],
        },
      ],
    });
    res.json(cotizaciones);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch quotations" });
  }
};

export const createCotizacion = async (req, res) => {
  try {
    const cotizacion = await Cotizacion.create(req.body, {
      include: [CotizacionItem],
    });
    res.json(cotizacion);
  } catch (error) {
    res.status(500).json({ error: "Failed to create quotation" });
  }
};

export const getCotizacionById = async (req, res) => {
  try {
    const cotizacion = await Cotizacion.findByPk(req.params.id, {
      include: [
        { model: Cliente },
        { model: Moneda },
        {
          model: CotizacionItem,
          include: [{ model: Producto }],
        },
      ],
    });
    if (!cotizacion) {
      return res.status(404).json({ error: "Quotation not found" });
    }
    res.json(cotizacion);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch quotation" });
  }
};

export const updateCotizacion = async (req, res) => {
  try {
    const cotizacion = await Cotizacion.findByPk(req.params.id);
    if (!cotizacion) {
      return res.status(404).json({ error: "Quotation not found" });
    }
    await cotizacion.update(req.body);
    res.json(cotizacion);
  } catch (error) {
    res.status(500).json({ error: "Failed to update quotation" });
  }
};

export const deleteCotizacion = async (req, res) => {
  try {
    const cotizacion = await Cotizacion.findByPk(req.params.id);
    if (!cotizacion) {
      return res.status(404).json({ error: "Quotation not found" });
    }
    await cotizacion.destroy();
    res.json({ message: "Quotation deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete quotation" });
  }
};
