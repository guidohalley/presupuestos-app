import React, { useState } from 'react';
import axios from 'axios';

const ClienteForm = ({ onClienteAdded }) => {
  const [nombre, setNombre] = useState('');
  const [email, setEmail] = useState('');
  const [telefono, setTelefono] = useState('');
  const [direccion, setDireccion] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    const newCliente = { nombre, email, telefono, direccion };
    try {
      await axios.post('http://localhost:3000/api/clientes', newCliente);
      setNombre('');
      setEmail('');
      setTelefono('');
      setDireccion('');
      onClienteAdded(); // Llamar al callback para actualizar la lista de clientes
    } catch (error) {
      console.error('Error creating client:', error);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="mb-4">
      <div className="mb-2">
        <label className="block text-gray-700">Nombre</label>
        <input
          type="text"
          value={nombre}
          onChange={(e) => setNombre(e.target.value)}
          className="w-full px-3 py-2 border rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300"
        />
      </div>
      <div className="mb-2">
        <label className="block text-gray-700">Email</label>
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="w-full px-3 py-2 border rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300"
        />
      </div>
      <div className="mb-2">
        <label className="block text-gray-700">Teléfono</label>
        <input
          type="text"
          value={telefono}
          onChange={(e) => setTelefono(e.target.value)}
          className="w-full px-3 py-2 border rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300"
        />
      </div>
      <div className="mb-2">
        <label className="block text-gray-700">Dirección</label>
        <input
          type="text"
          value={direccion}
          onChange={(e) => setDireccion(e.target.value)}
          className="w-full px-3 py-2 border rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300"
        />
      </div>
      <button
        type="submit"
        className="w-full bg-indigo-500 text-white py-2 px-4 rounded-lg hover:bg-indigo-600 transition-colors"
      >
        Crear Cliente
      </button>
    </form>
  );
};

export default ClienteForm;
