import React from 'react';
import { Link } from 'react-router-dom';

const Home = () => {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gray-100">
      <div className="bg-white p-8 rounded-lg shadow-md w-full max-w-md">
        <h1 className="text-3xl font-bold mb-4 text-center text-indigo-600">Bienvenido a PresupuestosApp</h1>
        <p className="mb-6 text-gray-700 text-center">
          Esta aplicación te permite gestionar clientes, crear presupuestos, y mucho más.
          Utiliza la barra de navegación para iniciar sesión, registrarte, o navegar a las secciones de clientes y presupuestos.
        </p>
        <div className="flex justify-around">
          <Link to="/login">
            <button className="bg-indigo-500 text-white py-2 px-4 rounded-lg hover:bg-indigo-600 transition duration-300">
              Iniciar Sesión
            </button>
          </Link>
          <Link to="/register">
            <button className="bg-green-500 text-white py-2 px-4 rounded-lg hover:bg-green-600 transition duration-300">
              Registrarse
            </button>
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Home;
