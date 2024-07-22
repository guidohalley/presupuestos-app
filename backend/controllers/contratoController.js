const Contrato = require('../models/Contrato');
const Presupuesto = require('../models/Presupuesto');
const Cliente = require('../models/Cliente');
const Moneda = require('../models/Moneda');

exports.getAllContratos = async (req, res) => {
  try {
    const contratos = await Contrato.findAll({
      include: [
        { model: Presupuesto },
        { model: Cliente },
        { model: Moneda }
      ]
    });
    res.json(contratos);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch contracts' });
  }
};

exports.createContrato = async (req, res) => {
  try {
    const contrato = await Contrato.create(req.body);
    res.json(contrato);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create contract' });
  }
};

exports.getContratoById = async (req, res) => {
  try {
    const contrato = await Contrato.findByPk(req.params.id, {
      include: [
        { model: Presupuesto },
        { model: Cliente },
        { model: Moneda }
      ]
    });
    if (!contrato) {
      return res.status(404).json({ error: 'Contract not found' });
    }
    res.json(contrato);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch contract' });
  }
};

exports.updateContrato = async (req, res) => {
  try {
    const contrato = await Contrato.findByPk(req.params.id);
    if (!contrato) {
      return res.status(404).json({ error: 'Contract not found' });
    }
    await contrato.update(req.body);
    res.json(contrato);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update contract' });
  }
};

exports.deleteContrato = async (req, res) => {
  try {
    const contrato = await Contrato.findByPk(req.params.id);
    if (!contrato) {
      return res.status(404).json({ error: 'Contract not found' });
    }
    await contrato.destroy();
    res.json({ message: 'Contract deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete contract' });
  }
};
