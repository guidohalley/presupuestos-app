import React from 'react';
import PresupuestoForm from '../components/PresupuestoForm';
import PresupuestoList from '../components/PresupuestoList';

const Home = () => {
    return (
        <div className="min-h-screen bg-gray-100 flex flex-col items-center">
            <h1 className="text-2xl font-bold mt-8 mb-4">Gestor de Presupuestos</h1>
            <PresupuestoForm />
            <PresupuestoList />
        </div>
    );
};

export default Home;
