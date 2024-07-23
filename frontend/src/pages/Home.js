// src/pages/Home.js
import React from 'react';
import Header from '../components/Header';
import Footer from '../components/Footer';

function Home() {
  return (
    <div className="min-h-screen flex flex-col bg-gray-100">
      <div 
        className="flex flex-col items-center justify-center bg-cover bg-center min-h-screen"
        style={{ backgroundImage: `url(${require('../assets/fondo-home.png')})` }}
      >
        <div className="max-w-md mx-auto text-center bg-gray-800 bg-opacity-75 p-6 rounded-lg shadow-lg">
          <h2 className="text-4xl font-bold text-gray-50">Bienvenido a PresupuestosApp</h2>
          <p className="text-xl text-gray-300 mt-4">Gestiona tus presupuestos con facilidad</p>
        </div>
      </div>
    </div>
  );
}

export default Home;
