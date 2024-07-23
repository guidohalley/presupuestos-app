const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');
const Cliente = require('./Cliente');
const Moneda = require('./Moneda');

const Cotizacion = sequelize.define('Cotizacion', {
  cliente_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Cliente,
      key: 'id'
    },
    allowNull: false
  },
  moneda_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Moneda,
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
  frecuencia: {
    type: DataTypes.STRING,
    allowNull: false,
    validate: {
      isIn: [['mensual', 'única', 'anual']]
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
  tableName: 'Cotizaciones',
  timestamps: false,
  underscored: true
});

Cotizacion.belongsTo(Cliente, { foreignKey: 'cliente_id' });
Cotizacion.belongsTo(Moneda, { foreignKey: 'moneda_id' });

module.exports = Cotizacion;
