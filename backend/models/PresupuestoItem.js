const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Presupuesto = require('./Presupuesto');
const Producto = require('./Producto');

const PresupuestoItem = sequelize.define('PresupuestoItem', {
  presupuesto_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Presupuesto,
      key: 'id'
    },
    allowNull: false
  },
  producto_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Producto,
      key: 'id'
    },
    allowNull: false
  },
  cantidad: {
    type: DataTypes.INTEGER,
    allowNull: false,
    validate: {
      min: 1
    }
  },
  precio: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
    validate: {
      min: 0
    }
  },
  total: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
    validate: {
      min: 0
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
  tableName: 'Presupuesto_Items',
  timestamps: false,
  underscored: true
});

PresupuestoItem.belongsTo(Presupuesto, { foreignKey: 'presupuesto_id' });
PresupuestoItem.belongsTo(Producto, { foreignKey: 'producto_id' });

module.exports = PresupuestoItem;
