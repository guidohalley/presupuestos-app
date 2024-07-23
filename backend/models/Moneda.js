import { DataTypes } from 'sequelize';
import { sequelize } from '../config/database.js';

const Moneda = sequelize.define('Moneda', {
  nombre: {
    type: DataTypes.STRING,
    allowNull: false
  },
  simbolo: {
    type: DataTypes.STRING,
    allowNull: false
  },
  tipo_cambio: {
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
  tableName: 'Monedas',
  timestamps: false,
  underscored: true
});

export default Moneda;
