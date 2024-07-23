const Presupuesto = require("../models/Presupuesto");
const PresupuestoItem = require("../models/PresupuestoItem");
const Cliente = require("../models/Cliente");
const Producto = require("../models/Producto");
const Moneda = require("../models/Moneda");
const Cotizacion = require("../models/Cotizacion");

exports.getAllPresupuestos = async (req, res) => {
  try {
    const presupuestos = await Presupuesto.findAll({
      include: [
        { model: Cliente },
        { model: Moneda },
        {
          model: PresupuestoItem,
          include: [{ model: Producto }],
        },
        { model: Cotizacion },
      ],
    });
    res.json(presupuestos);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch budgets" });
  }
};

exports.createPresupuesto = async (req, res) => {
  try {
    const presupuesto = await Presupuesto.create(req.body, {
      include: [PresupuestoItem],
    });
    res.json(presupuesto);
  } catch (error) {
    res.status(500).json({ error: "Failed to create budget" });
  }
};

exports.getPresupuestoById = async (req, res) => {
  try {
    const presupuesto = await Presupuesto.findByPk(req.params.id, {
      include: [
        { model: Cliente },
        { model: Moneda },
        {
          model: PresupuestoItem,
          include: [{ model: Producto }],
        },
        { model: Cotizacion },
      ],
    });
    if (!presupuesto) {
      return res.status(404).json({ error: "Budget not found" });
    }
    res.json(presupuesto);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch budget" });
  }
};

exports.updatePresupuesto = async (req, res) => {
  try {
    const presupuesto = await Presupuesto.findByPk(req.params.id);
    if (!presupuesto) {
      return res.status(404).json({ error: "Budget not found" });
    }
    await presupuesto.update(req.body);
    res.json(presupuesto);
  } catch (error) {
    res.status(500).json({ error: "Failed to update budget" });
  }
};

exports.deletePresupuesto = async (req, res) => {
  try {
    const presupuesto = await Presupuesto.findByPk(req.params.id);
    if (!presupuesto) {
      return res.status(404).json({ error: "Budget not found" });
    }
    await presupuesto.destroy();
    res.json({ message: "Budget deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete budget" });
  }
};
