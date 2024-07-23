import React from 'react';
import { Link } from 'react-router-dom';

const Navbar = () => {
  return (
    <nav className="bg-gray-800 p-4">
      <div className="container mx-auto">
        <div className="flex items-center justify-between">
          <div className="text-white text-lg font-bold">
            <Link to="/">PresupuestosApp</Link>
          </div>
          <div>
            <Link to="/login" className="text-white px-4">Login</Link>
            <Link to="/register" className="text-white px-4">Register</Link>
            <Link to="/clientes" className="text-white px-4">Clientes</Link>
            <Link to="/presupuestos" className="text-white px-4">Presupuestos</Link>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
