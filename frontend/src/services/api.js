import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:3000/api',
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export const fetchClientes = async () => {
  try {
    const response = await api.get('/clientes');
    return response.data;
  } catch (error) {
    console.error('Error fetching clients:', error);
    throw error;
  }
};

export const getClientes = () => api.get('/clientes');
export const createCliente = (cliente) => api.post('/clientes', cliente);

export const getProductos = () => api.get('/productos');
export const createProducto = (producto) => api.post('/productos', producto);

export const getPresupuestos = () => api.get('/presupuestos');
export const createPresupuesto = (presupuesto) => api.post('/presupuestos', presupuesto);

export const getMonedas = () => api.get('/monedas');

export const getCotizaciones = () => api.get('/cotizaciones');

export default api;
