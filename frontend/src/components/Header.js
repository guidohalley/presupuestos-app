import React from 'react';
import { Link } from 'react-router-dom';

function Header({ isLoggedIn, onLogout }) {
  return (
    <header className="bg-white p-4 shadow-md w-full flex justify-between items-center">
      <div className="flex items-center">
        <img src={require('../assets/TDLOGO.png')} alt="twodesigners" className="h-8 mr-3" />
      </div>
      <div>
        {isLoggedIn ? (
          <button onClick={onLogout} className="text-gray-900 hover:text-gray-700">
            Cerrar Sesión
          </button>
        ) : (
          <>
            <Link to="/login" className="mr-4 text-gray-900 hover:text-gray-700">
              Iniciar Sesión
            </Link>
            <Link to="/register" className="text-gray-900 hover:text-gray-700">
              Registrarse
            </Link>
          </>
        )}
      </div>
    </header>
  );
}

export default Header;
