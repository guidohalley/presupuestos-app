import React, { useEffect, useState } from 'react';
import { fetchClientes } from '../services/api';

const ClienteList = () => {
  const [clientes, setClientes] = useState([]);

  useEffect(() => {
    const getClientes = async () => {
      try {
        const clientesData = await fetchClientes();
        setClientes(clientesData);
      } catch (error) {
        console.error('Error fetching clients:', error);
      }
    };

    getClientes();
  }, []);

  return (
    <table className="min-w-full bg-white mt-4">
      <thead>
        <tr>
          <th className="py-2 px-4 border-b">Nombre</th>
          <th className="py-2 px-4 border-b">Email</th>
          <th className="py-2 px-4 border-b">Teléfono</th>
          <th className="py-2 px-4 border-b">Dirección</th>
        </tr>
      </thead>
      <tbody>
        {clientes.map((cliente) => (
          <tr key={cliente.id}>
            <td className="py-2 px-4 border-b">{cliente.nombre}</td>
            <td className="py-2 px-4 border-b">{cliente.email}</td>
            <td className="py-2 px-4 border-b">{cliente.telefono}</td>
            <td className="py-2 px-4 border-b">{cliente.direccion}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};

export default ClienteList;
