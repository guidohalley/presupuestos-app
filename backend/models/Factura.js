const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');
const Contrato = require('./Contrato');

const Factura = sequelize.define('Factura', {
  contrato_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Contrato,
      key: 'id'
    },
    allowNull: false
  },
  total: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
    validate: {
      min: 0
    }
  },
  fecha_emision: {
    type: DataTypes.DATE,
    allowNull: false
  },
  fecha_vencimiento: {
    type: DataTypes.DATE,
    allowNull: true,
    validate: {
      isAfter: DataTypes.DATE
    }
  },
  estado: {
    type: DataTypes.STRING,
    allowNull: true,
    validate: {
      isIn: [['pagada', 'pendiente', 'vencida']]
    }
  },
  created_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW
  },
  updated_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW
  }
}, {
  tableName: 'Facturas',
  timestamps: false,
  underscored: true
});

Factura.belongsTo(Contrato, { foreignKey: 'contrato_id' });

module.exports = Factura;
