import { DataTypes } from 'sequelize';
import { sequelize } from '../config/database.js';
import Presupuesto from './Presupuesto.js';
import Cliente from './Cliente.js';
import Moneda from './Moneda.js';

const Contrato = sequelize.define('Contrato', {
  presupuesto_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Presupuesto,
      key: 'id'
    },
    allowNull: false
  },
  cliente_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Cliente,
      key: 'id'
    },
    allowNull: false
  },
  fecha_inicio: {
    type: DataTypes.DATE,
    allowNull: false
  },
  fecha_fin: {
    type: DataTypes.DATE,
    allowNull: true,
    validate: {
      isAfter: DataTypes.DATE
    }
  },
  detalles: {
    type: DataTypes.TEXT,
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
  tableName: 'Contratos',
  timestamps: false,
  underscored: true
});

Contrato.belongsTo(Presupuesto, { foreignKey: 'presupuesto_id' });
Contrato.belongsTo(Cliente, { foreignKey: 'cliente_id' });
Contrato.belongsTo(Moneda, { foreignKey: 'moneda_id' });

export default Contrato;
