import React, { useEffect, useState } from 'react';
import axios from 'axios';

const Presupuestos = () => {
  const [presupuestos, setPresupuestos] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchPresupuestos = async () => {
      try {
        const response = await axios.get('http://localhost:3010/api/presupuestos');
        setPresupuestos(response.data);
      } catch (error) {
        setError('Error fetching budgets');
      }
    };

    fetchPresupuestos();
  }, []);

  return (
    <div className="max-w-7xl mx-auto p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-bold mb-6 text-center">Presupuestos</h2>
      {error && <p className="text-red-500 text-center mb-4">{error}</p>}
      <table className="min-w-full bg-white mt-4">
        <thead>
          <tr>
            <th className="py-2 px-4 border-b">Cliente</th>
            <th className="py-2 px-4 border-b">Moneda</th>
            <th className="py-2 px-4 border-b">Total</th>
          </tr>
        </thead>
        <tbody>
          {presupuestos.map((presupuesto) => (
            <tr key={presupuesto.id}>
              <td className="py-2 px-4 border-b">{presupuesto.Cliente.nombre}</td>
              <td className="py-2 px-4 border-b">{presupuesto.Moneda.nombre}</td>
              <td className="py-2 px-4 border-b">{presupuesto.total}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Presupuestos;
