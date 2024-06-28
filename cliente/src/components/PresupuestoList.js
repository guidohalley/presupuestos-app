import React, { useEffect, useState } from 'react';
import api from '../services/api';

const PresupuestoList = () => {
  const [presupuestos, setPresupuestos] = useState([]);

  useEffect(() => {
    const fetchPresupuestos = async () => {
      try {
        const response = await api.get('/presupuestos');
        setPresupuestos(response.data);
      } catch (error) {
        console.error(error);
      }
    };

    fetchPresupuestos();
  }, []);

  return (
    <div className="max-w-lg mx-auto p-4 bg-white shadow-md rounded mt-4">
      <h3 className="text-lg font-bold mb-2">Lista de Presupuestos</h3>
      <ul>
        {presupuestos.map((presupuesto) => (
          <li key={presupuesto.id} className="mb-2 p-2 border border-gray-300 rounded flex justify-between">
            <div>
              <div>{presupuesto.cliente}</div>
              <div>Total: ${presupuesto.total.toFixed(2)}</div>
            </div>
            <a href={`http://localhost:3000/api/presupuesto/${presupuesto.filename}`} target="_blank" rel="noopener noreferrer" className="text-blue-500 underline">Descargar PDF</a>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default PresupuestoList;
