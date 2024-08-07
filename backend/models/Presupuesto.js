import { DataTypes } from 'sequelize';
import { sequelize } from '../config/database.js';
import Cliente from './Cliente.js';
import Moneda from './Moneda.js';
import Cotizacion from './Cotizacion.js';

const Presupuesto = sequelize.define('Presupuesto', {
  cliente_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Cliente,
      key: 'id'
    },
    allowNull: false
  },
  cotizacion_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Cotizacion,
      key: 'id'
    },
    allowNull: true
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
  created_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW
  },
  updated_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW
  }
}, {
  tableName: 'Presupuestos',
  timestamps: false,
  underscored: true
});

Presupuesto.belongsTo(Cliente, { foreignKey: 'cliente_id' });
Presupuesto.belongsTo(Cotizacion, { foreignKey: 'cotizacion_id' });
Presupuesto.belongsTo(Moneda, { foreignKey: 'moneda_id' });

export default Presupuesto;
