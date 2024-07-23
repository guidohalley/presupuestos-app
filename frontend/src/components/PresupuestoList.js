import React, { useEffect, useState } from 'react';
import axios from 'axios';

const PresupuestoList = () => {
  const [presupuestos, setPresupuestos] = useState([]);

  useEffect(() => {
    const fetchPresupuestos = async () => {
      try {
        const response = await axios.get('http://localhost:3000/api/presupuestos');
        setPresupuestos(response.data);
      } catch (error) {
        console.error('Error fetching budgets', error);
      }
    };

    fetchPresupuestos();
  }, []);

  return (
    <div className="max-w-4xl mx-auto p-4 bg-white shadow-md rounded-lg">
      <h2 className="text-2xl font-bold mb-4">Lista de Presupuestos</h2>
      <table className="min-w-full bg-white">
        <thead>
          <tr>
            <th className="py-2">ID</th>
            <th className="py-2">Cliente</th>
            <th className="py-2">Moneda</th>
            <th className="py-2">Total</th>
            <th className="py-2">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {presupuestos.map(presupuesto => (
            <tr key={presupuesto.id}>
              <td className="py-2">{presupuesto.id}</td>
              <td className="py-2">{presupuesto.Cliente.nombre}</td>
              <td className="py-2">{presupuesto.Moneda.nombre}</td>
              <td className="py-2">${presupuesto.total.toFixed(2)}</td>
              <td className="py-2">
                <button className="bg-blue-500 text-white py-1 px-3 rounded hover:bg-blue-700 transition-colors">
                  Ver
                </button>
                <button className="bg-red-500 text-white py-1 px-3 rounded hover:bg-red-700 transition-colors ml-2">
                  Eliminar
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default PresupuestoList;
