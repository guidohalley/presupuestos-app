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
                    <li key={presupuesto.id} className="mb-2 p-2 border border-gray-300 rounded">
                        {presupuesto.cliente} - {presupuesto.total}
                        {/* Agregar enlace para ver o descargar el PDF */}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default PresupuestoList;
