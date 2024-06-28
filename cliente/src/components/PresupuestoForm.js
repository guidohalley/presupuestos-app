import React, { useState } from 'react';
import api from '../services/api';

const PresupuestoForm = () => {
  const [cliente, setCliente] = useState('');
  const [servicios, setServicios] = useState({
    marketing: [
      { nombre: 'Community Manager', precio: '' },
      { nombre: 'Gestión de la Marca', precio: '' },
      { nombre: 'Campañas Publicitarias', precio: '' },
    ],
    produccionAudiovisual: [
      { nombre: 'Producción de Videos', precio: '' },
      { nombre: 'Producción de Fotos', precio: '' },
    ],
    disenoGrafico: [
      { nombre: 'Logotipo', precio: '' },
      { nombre: 'Manual de Marca', precio: '' },
      { nombre: 'Piezas Gráficas para redes sociales', precio: '' },
    ],
    legal: [
      { nombre: 'Asesoramiento sobre Identidad Digital', precio: '' },
      { nombre: 'Patente de la marca', precio: '' },
    ],
    informatica: [
      { nombre: 'Página Web', precio: '' },
      { nombre: 'Scripts personalizados para Marketing', precio: '' },
      { nombre: 'Sistemas Web', precio: '' },
    ],
  });

  const [presupuesto, setPresupuesto] = useState([]);
  const [pdfLink, setPdfLink] = useState('');

  const handleServicioChange = (area, index, value) => {
    const newServicios = { ...servicios };
    newServicios[area][index].precio = value;
    setServicios(newServicios);
  };

  const agregarServiciosAlPresupuesto = () => {
    const serviciosSeleccionados = [];
    Object.keys(servicios).forEach(area => {
      servicios[area].forEach(servicio => {
        if (servicio.precio) {
          serviciosSeleccionados.push({
            nombre: servicio.nombre,
            area,
            precio: parseFloat(servicio.precio),
          });
        }
      });
    });
    setPresupuesto(serviciosSeleccionados);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    agregarServiciosAlPresupuesto();
    const data = {
      cliente,
      items: presupuesto,
    };
    try {
      const response = await api.post('/presupuesto', data);
      setPdfLink(`http://localhost:3000/api/presupuesto/${response.data.filename}`);
    } catch (error) {
      console.error(error);
    }
  };

  const calcularTotal = () => {
    return presupuesto.reduce((total, servicio) => total + servicio.precio, 0);
  };

  return (
    <form onSubmit={handleSubmit} className="max-w-lg mx-auto p-4 bg-white shadow-md rounded">
      <div className="mb-4">
        <label className="block text-gray-700 font-bold mb-2">Cliente:</label>
        <input
          type="text"
          value={cliente}
          onChange={(e) => setCliente(e.target.value)}
          className="w-full px-3 py-2 border border-gray-300 rounded"
        />
      </div>
      <div className="mb-4">
        <h3 className="text-lg font-bold mb-2">Áreas y Servicios</h3>
        {Object.keys(servicios).map((area, areaIndex) => (
          <div key={areaIndex} className="mb-4">
            <h4 className="text-md font-semibold mb-2 capitalize">{area.replace(/([A-Z])/g, ' $1')}</h4>
            {servicios[area].map((servicio, servicioIndex) => (
              <div key={servicioIndex} className="mb-2 flex items-center">
                <label className="flex-1">
                  <input
                    type="checkbox"
                    checked={!!servicio.precio}
                    onChange={(e) => handleServicioChange(area, servicioIndex, e.target.checked ? '0' : '')}
                    className="mr-2"
                  />
                  {servicio.nombre}
                </label>
                <input
                  type="number"
                  placeholder="Precio"
                  value={servicio.precio}
                  onChange={(e) => handleServicioChange(area, servicioIndex, e.target.value)}
                  className="w-32 px-3 py-2 border border-gray-300 rounded"
                  disabled={!servicio.precio}
                />
              </div>
            ))}
          </div>
        ))}
      </div>
      <button type="button" onClick={agregarServiciosAlPresupuesto} className="w-full px-4 py-2 bg-blue-500 text-white rounded mb-4">Agregar al Presupuesto</button>
      <div className="mb-4">
        <h3 className="text-lg font-bold mb-2">Vista Previa del Presupuesto</h3>
        {presupuesto.map((servicio, index) => (
          <div key={index} className="mb-2 flex justify-between">
            <span>{servicio.nombre}</span>
            <span>${servicio.precio.toFixed(2)}</span>
          </div>
        ))}
        <div className="font-bold flex justify-between">
          <span>Total:</span>
          <span>${calcularTotal().toFixed(2)}</span>
        </div>
      </div>
      <button type="submit" className="w-full px-4 py-2 bg-green-500 text-white rounded">Generar Presupuesto</button>
      {pdfLink && <a href={pdfLink} target="_blank" rel="noopener noreferrer" className="block mt-4 text-blue-500 underline">Descargar PDF</a>}
    </form>
  );
};

export default PresupuestoForm;
