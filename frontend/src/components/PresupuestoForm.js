import React, { useState, useEffect } from 'react';
import axios from 'axios';

const PresupuestoForm = () => {
  const [clientes, setClientes] = useState([]);
  const [productos, setProductos] = useState([]);
  const [monedas, setMonedas] = useState([]);
  const [cotizaciones, setCotizaciones] = useState([]);
  
  const [clienteId, setClienteId] = useState('');
  const [monedaId, setMonedaId] = useState('');
  const [cotizacionId, setCotizacionId] = useState('');
  const [items, setItems] = useState([]);
  const [total, setTotal] = useState(0);

  useEffect(() => {
    const fetchData = async () => {
      const clientesResponse = await axios.get('http://localhost:3000/api/clientes');
      setClientes(clientesResponse.data);

      const productosResponse = await axios.get('http://localhost:3000/api/productos');
      setProductos(productosResponse.data);

      const monedasResponse = await axios.get('http://localhost:3000/api/monedas');
      setMonedas(monedasResponse.data);

      const cotizacionesResponse = await axios.get('http://localhost:3000/api/cotizaciones');
      setCotizaciones(cotizacionesResponse.data);
    };

    fetchData();
  }, []);

  const handleAddItem = () => {
    setItems([...items, { productoId: '', cantidad: 1, precio: 0, total: 0 }]);
  };

  const handleItemChange = (index, field, value) => {
    const newItems = [...items];
    newItems[index][field] = value;

    if (field === 'productoId') {
      const producto = productos.find(p => p.id === parseInt(value));
      newItems[index].precio = producto.precio;
      newItems[index].total = producto.precio * newItems[index].cantidad;
    }

    if (field === 'cantidad') {
      newItems[index].total = newItems[index].precio * value;
    }

    setItems(newItems);
    calculateTotal(newItems);
  };

  const calculateTotal = (items) => {
    const total = items.reduce((sum, item) => sum + item.total, 0);
    setTotal(total);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://localhost:3000/api/presupuestos', {
        cliente_id: clienteId,
        moneda_id: monedaId,
        cotizacion_id: cotizacionId,
        total,
        items
      });
      console.log(response.data);
      // Reset form
      setClienteId('');
      setMonedaId('');
      setCotizacionId('');
      setItems([]);
      setTotal(0);
    } catch (error) {
      console.error('Error creating budget', error);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="max-w-lg mx-auto p-4 bg-white shadow-md rounded-lg">
      <h2 className="text-2xl font-bold mb-4">Crear Presupuesto</h2>
      <div className="mb-4">
        <label className="block text-gray-700">Cliente</label>
        <select 
          value={clienteId} 
          onChange={(e) => setClienteId(e.target.value)} 
          className="w-full px-3 py-2 border border-gray-300 rounded" 
          required
        >
          <option value="">Seleccionar Cliente</option>
          {clientes.map(cliente => (
            <option key={cliente.id} value={cliente.id}>{cliente.nombre}</option>
          ))}
        </select>
      </div>
      <div className="mb-4">
        <label className="block text-gray-700">Moneda</label>
        <select 
          value={monedaId} 
          onChange={(e) => setMonedaId(e.target.value)} 
          className="w-full px-3 py-2 border border-gray-300 rounded" 
          required
        >
          <option value="">Seleccionar Moneda</option>
          {monedas.map(moneda => (
            <option key={moneda.id} value={moneda.id}>{moneda.nombre}</option>
          ))}
        </select>
      </div>
      <div className="mb-4">
        <label className="block text-gray-700">Cotización</label>
        <select 
          value={cotizacionId} 
          onChange={(e) => setCotizacionId(e.target.value)} 
          className="w-full px-3 py-2 border border-gray-300 rounded"
        >
          <option value="">Seleccionar Cotización (Opcional)</option>
          {cotizaciones.map(cotizacion => (
            <option key={cotizacion.id} value={cotizacion.id}>{cotizacion.id}</option>
          ))}
        </select>
      </div>
      <div className="mb-4">
        <h3 className="text-lg font-bold mb-2">Items</h3>
        {items.map((item, index) => (
          <div key={index} className="mb-2 flex items-center">
            <select 
              value={item.productoId} 
              onChange={(e) => handleItemChange(index, 'productoId', e.target.value)} 
              className="w-1/2 px-3 py-2 border border-gray-300 rounded mr-2"
              required
            >
              <option value="">Seleccionar Producto</option>
              {productos.map(producto => (
                <option key={producto.id} value={producto.id}>{producto.nombre}</option>
              ))}
            </select>
            <input 
              type="number" 
              value={item.cantidad} 
              onChange={(e) => handleItemChange(index, 'cantidad', e.target.value)} 
              className="w-1/4 px-3 py-2 border border-gray-300 rounded mr-2"
              min="1"
              required
            />
            <input 
              type="number" 
              value={item.precio} 
              onChange={(e) => handleItemChange(index, 'precio', e.target.value)} 
              className="w-1/4 px-3 py-2 border border-gray-300 rounded" 
              readOnly 
            />
          </div>
        ))}
        <button 
          type="button" 
          onClick={handleAddItem} 
          className="w-full bg-green-500 text-white py-2 px-4 rounded hover:bg-green-700 transition-colors"
        >
          Añadir Item
        </button>
      </div>
      <div className="mb-4">
        <h3 className="text-lg font-bold">Total: ${total.toFixed(2)}</h3>
      </div>
      <button 
        type="submit" 
        className="w-full bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-700 transition-colors"
      >
        Crear Presupuesto
      </button>
    </form>
  );
};

export default PresupuestoForm;
