import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import LoginForm from './components/LoginForm';
import RegisterForm from './components/RegisterForm';
import Dashboard from './components/Dashboard';
import Home from './pages/Home';

const App = () => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const handleLogin = () => {
    setIsLoggedIn(true);
  };

  return (
    <Router>
      <div className="min-h-screen flex flex-col">
        {isLoggedIn ? (
          <Routes>
            <Route path="/*" element={<Dashboard />} />
          </Routes>
        ) : (
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/login" element={<LoginForm onLogin={handleLogin} />} />
            <Route path="/register" element={<RegisterForm />} />
          </Routes>
        )}
      </div>
    </Router>
  );
};

export default App;
