import React, { useState, useEffect } from 'react';
import axios from 'axios';
import ClienteForm from './ClienteForm';

const Dashboard = () => {
  const [clientes, setClientes] = useState([]);

  useEffect(() => {
    fetchClientes();
  }, []);

  const fetchClientes = async () => {
    try {
      const response = await axios.get('http://localhost:3010/api/clientes');
      setClientes(response.data);
    } catch (error) {
      console.error('Error fetching clients:', error);
    }
  };

  return (
    <div className="min-h-screen flex flex-col">
      <header className="bg-indigo-600 text-white py-4">
        <div className="container mx-auto px-4">
        <img src={require('../assets/TDLOGO.png')} alt="twodesigners" className="h-8 mr-3" />
        </div>
      </header>
      <div className="flex flex-1">
        <aside className="bg-gray-800 text-white w-64 p-4">
          <nav>
            <ul>
              <li className="mb-2">
                <a href="/clientes" className="block py-2 px-4 rounded hover:bg-gray-700">Clientes</a>
              </li>
              <li className="mb-2">
                <a href="/presupuestos" className="block py-2 px-4 rounded hover:bg-gray-700">Presupuestos</a>
              </li>
            </ul>
          </nav>
        </aside>
        <main className="flex-1 p-6 bg-gray-100">
          <div className="container mx-auto px-4">
            <h2 className="text-xl font-bold mb-4">Clientes</h2>
            <ClienteForm onClienteAdded={fetchClientes} />
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
          </div>
        </main>
      </div>
    </div>
  );
};

export default Dashboard;
