import React, { useState } from 'react';
import api from '../services/api';

const PresupuestoForm = () => {
    const [cliente, setCliente] = useState('');
    const [items, setItems] = useState([{ nombre: '', cantidad: 1, precio: 0 }]);
    const [pdfLink, setPdfLink] = useState('');

    const handleItemChange = (index, field, value) => {
        const newItems = [...items];
        newItems[index][field] = value;
        setItems(newItems);
    };

    const addItem = () => {
        setItems([...items, { nombre: '', cantidad: 1, precio: 0 }]);
    };

    const handleSubmit = async (event) => {
        event.preventDefault();
        const presupuesto = { cliente, items };
        try {
            const response = await api.post('/presupuesto', presupuesto);
            setPdfLink(`http://localhost:3000/api/presupuesto/${response.data.filename}`);
        } catch (error) {
            console.error(error);
        }
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
                <h3 className="text-lg font-bold mb-2">Items</h3>
                {items.map((item, index) => (
                    <div key={index} className="mb-2 flex space-x-2">
                        <input
                            type="text"
                            placeholder="Nombre del item"
                            value={item.nombre}
                            onChange={(e) => handleItemChange(index, 'nombre', e.target.value)}
                            className="w-1/3 px-3 py-2 border border-gray-300 rounded"
                        />
                        <input
                            type="number"
                            placeholder="Cantidad"
                            value={item.cantidad}
                            onChange={(e) => handleItemChange(index, 'cantidad', e.target.value)}
                            className="w-1/3 px-3 py-2 border border-gray-300 rounded"
                        />
                        <input
                            type="number"
                            placeholder="Precio"
                            value={item.precio}
                            onChange={(e) => handleItemChange(index, 'precio', e.target.value)}
                            className="w-1/3 px-3 py-2 border border-gray-300 rounded"
                        />
                    </div>
                ))}
                <button type="button" onClick={addItem} className="mt-2 px-4 py-2 bg-blue-500 text-white rounded">Agregar Item</button>
            </div>
            <button type="submit" className="w-full px-4 py-2 bg-green-500 text-white rounded">Generar Presupuesto</button>
            {pdfLink && <a href={pdfLink} target="_blank" rel="noopener noreferrer" className="block mt-4 text-blue-500 underline">Descargar PDF</a>}
        </form>
    );
};

export default PresupuestoForm;
