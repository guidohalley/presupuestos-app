import Contrato from '../models/Contrato.js';
import Presupuesto from '../models/Presupuesto.js';
import Cliente from '../models/Cliente.js';
import Moneda from '../models/Moneda.js';

export const getAllContratos = async (req, res) => {
  try {
    const contratos = await Contrato.findAll({
      include: [{ model: Presupuesto }, { model: Cliente }, { model: Moneda }],
    });
    res.json(contratos);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch contracts" });
  }
};

export const createContrato = async (req, res) => {
  try {
    const contrato = await Contrato.create(req.body);
    res.json(contrato);
  } catch (error) {
    res.status(500).json({ error: "Failed to create contract" });
  }
};

export const getContratoById = async (req, res) => {
  try {
    const contrato = await Contrato.findByPk(req.params.id, {
      include: [{ model: Presupuesto }, { model: Cliente }, { model: Moneda }],
    });
    if (!contrato) {
      return res.status(404).json({ error: "Contract not found" });
    }
    res.json(contrato);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch contract" });
  }
};

export const updateContrato = async (req, res) => {
  try {
    const contrato = await Contrato.findByPk(req.params.id);
    if (!contrato) {
      return res.status(404).json({ error: "Contract not found" });
    }
    await contrato.update(req.body);
    res.json(contrato);
  } catch (error) {
    res.status(500).json({ error: "Failed to update contract" });
  }
};

export const deleteContrato = async (req, res) => {
  try {
    const contrato = await Contrato.findByPk(req.params.id);
    if (!contrato) {
      return res.status(404).json({ error: "Contract not found" });
    }
    await contrato.destroy();
    res.json({ message: "Contract deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete contract" });
  }
};
