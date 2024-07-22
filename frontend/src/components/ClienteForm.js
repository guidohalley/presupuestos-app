import React, { useState } from 'react';
import axios from 'axios';

const ClienteForm = () => {
  const [nombre, setNombre] = useState('');
  const [email, setEmail] = useState('');
  const [telefono, setTelefono] = useState('');
  const [direccion, setDireccion] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('https://tu-railway-url/api/clientes', { nombre, email, telefono, direccion });
      console.log(response.data);
      // Reset form
      setNombre('');
      setEmail('');
      setTelefono('');
      setDireccion('');
    } catch (error) {
      console.error('Error creating client', error);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="max-w-lg mx-auto p-4 bg-white shadow-md rounded-lg">
      <h2 className="text-2xl font-bold mb-4">Crear Cliente</h2>
      <div className="mb-4">
        <label className="block text-gray-700">Nombre</label>
        <input 
          type="text" 
          value={nombre} 
          onChange={(e) => setNombre(e.target.value)} 
          className="w-full px-3 py-2 border border-gray-300 rounded" 
          required 
        />
      </div>
      <div className="mb-4">
        <label className="block text-gray-700">Email</label>
        <input 
          type="email" 
          value={email} 
          onChange={(e) => setEmail(e.target.value)} 
          className="w-full px-3 py-2 border border-gray-300 rounded" 
          required 
        />
      </div>
      <div className="mb-4">
        <label className="block text-gray-700">Teléfono</label>
        <input 
          type="text" 
          value={telefono} 
          onChange={(e) => setTelefono(e.target.value)} 
          className="w-full px-3 py-2 border border-gray-300 rounded" 
        />
      </div>
      <div className="mb-4">
        <label className="block text-gray-700">Dirección</label>
        <input 
          type="text" 
          value={direccion} 
          onChange={(e) => setDireccion(e.target.value)} 
          className="w-full px-3 py-2 border border-gray-300 rounded" 
        />
      </div>
      <button 
  
