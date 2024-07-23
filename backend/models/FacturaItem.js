import { DataTypes } from 'sequelize';
import { sequelize } from '../config/database.js';
import Factura from './Factura.js';
import Producto from './Producto.js';

const FacturaItem = sequelize.define('FacturaItem', {
  factura_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Factura,
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
  tableName: 'Facturas_Items',
  timestamps: false,
  underscored: true
});

FacturaItem.belongsTo(Factura, { foreignKey: 'factura_id' });
FacturaItem.belongsTo(Producto, { foreignKey: 'producto_id' });

export default FacturaItem;
