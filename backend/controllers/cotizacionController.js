const Cotizacion = require("../models/Cotizacion");
const CotizacionItem = require("../models/CotizacionItem");
const Cliente = require("../models/Cliente");
const Producto = require("../models/Producto");
const Moneda = require("../models/Moneda");

exports.getAllCotizaciones = async (req, res) => {
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

exports.createCotizacion = async (req, res) => {
  try {
    const cotizacion = await Cotizacion.create(req.body, {
      include: [CotizacionItem],
    });
    res.json(cotizacion);
  } catch (error) {
    res.status(500).json({ error: "Failed to create quotation" });
  }
};

exports.getCotizacionById = async (req, res) => {
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

exports.updateCotizacion = async (req, res) => {
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

exports.deleteCotizacion = async (req, res) => {
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
