import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Home from './pages/Home';
import ClienteForm from './components/ClienteForm';
import PresupuestoForm from './components/PresupuestoForm';
import PresupuestoList from './components/PresupuestoList';

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/clientes" element={<ClienteForm />} />
          <Route path="/presupuestos" element={<PresupuestoForm />} />
          <Route path="/presupuestos/lista" element={<PresupuestoList />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
