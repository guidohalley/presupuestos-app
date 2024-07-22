import React from 'react';
import ClienteForm from '../components/ClienteForm';
import PresupuestoForm from '../components/PresupuestoForm';
import PresupuestoList from '../components/PresupuestoList';

const Home = () => {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-3xl font-bold mb-4">Gestor de Presupuestos</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <div>
          <h2 className="text-2xl font-bold mb-2">Crear Cliente</h2>
          <ClienteForm />
        </div>
        <div>
          <h2 className="text-2xl font-bold mb-2">Crear Presupuesto</h2>
          <PresupuestoForm />
        </div>
        <div className="col-span-1 md:col-span-2 lg:col-span-3">
          <h2 className="text-2xl font-bold mb-2">Lista de Presupuestos</h2>
          <PresupuestoList />
        </div>
      </div>
    </div>
  );
};

export default Home;
