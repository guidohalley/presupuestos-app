// src/components/Footer.js
import React from 'react';

function Footer() {
  return (
    <footer className="bg-gray-800 text-gray-100 p-4 mt-auto">
      <div className="text-center">
        &copy; {new Date().getFullYear()} twodesigners.online . Todos los derechos reservados.
      </div>
    </footer>
  );
}

export default Footer;
