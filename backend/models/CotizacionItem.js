const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');
const Cotizacion = require('./Cotizacion');
const Producto = require('./Producto');

const CotizacionItem = sequelize.define('CotizacionItem', {
  cotizacion_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Cotizacion,
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
  tableName: 'Cotizacion_Items',
  timestamps: false,
  underscored: true
});

CotizacionItem.belongsTo(Cotizacion, { foreignKey: 'cotizacion_id' });
CotizacionItem.belongsTo(Producto, { foreignKey: 'producto_id' });

module.exports = CotizacionItem;
