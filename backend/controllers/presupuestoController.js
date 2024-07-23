import Presupuesto from '../models/Presupuesto.js';
import PresupuestoItem from '../models/PresupuestoItem.js';
import Cliente from '../models/Cliente.js';
import Moneda from '../models/Moneda.js';
import Cotizacion from '../models/Cotizacion.js';

export const getAllPresupuestos = async (req, res) => {
  try {
    const presupuestos = await Presupuesto.findAll({
      include: [
        { model: Cliente },
        { model: Moneda },
        { model: Cotizacion },
        {
          model: PresupuestoItem,
        },
      ],
    });
    res.json(presupuestos);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch budgets" });
  }
};

export const createPresupuesto = async (req, res) => {
  try {
    const presupuesto = await Presupuesto.create(req.body, {
      include: [PresupuestoItem],
    });
    res.json(presupuesto);
  } catch (error) {
    res.status(500).json({ error: "Failed to create budget" });
  }
};

export const getPresupuestoById = async (req, res) => {
  try {
    const presupuesto = await Presupuesto.findByPk(req.params.id, {
      include: [
        { model: Cliente },
        { model: Moneda },
        { model: Cotizacion },
        {
          model: PresupuestoItem,
        },
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

export const updatePresupuesto = async (req, res) => {
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

export const deletePresupuesto = async (req, res) => {
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
