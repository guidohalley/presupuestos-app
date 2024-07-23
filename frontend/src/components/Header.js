// src/components/Header.js
import React from 'react';
import { Link } from 'react-router-dom';
import { useNavigate } from 'react-router-dom';

function Header({ isLoggedIn, handleLogout }) {
  const navigate = useNavigate();

  const handleLogoClick = () => {
    navigate('/');
  };

  return (
    <nav className="bg-white p-4 shadow-md w-full">
      <div className="flex justify-between items-center">
        <div onClick={handleLogoClick} className="cursor-pointer">
          <img src={require('../assets/TDLOGO.png')} alt="Logo" className="h-10" />
        </div>
        <div>
          {isLoggedIn ? (
            <button onClick={handleLogout} className="text-red-600 hover:text-red-800">
              Cerrar Sesión
            </button>
          ) : (
            <>
              <Link to="/login" className="mr-4 text-black hover:text-gray-800">
                Iniciar Sesión
              </Link>
              <Link to="/register" className="text-black hover:text-gray-800">
                Registrarse
              </Link>
            </>
          )}
        </div>
      </div>
    </nav>
  );
}

export default Header;
