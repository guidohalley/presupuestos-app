import axios from 'axios';

const api = axios.create({
  baseURL: 'https://tu-railway-url/api', // Reemplaza esta URL con la URL de tu backend en Railway
});

export const getClientes = () => api.get('/clientes');
export const createCliente = (cliente) => api.post('/clientes', cliente);

export const getProductos = () => api.get('/productos');
export const createProducto = (producto) => api.post('/productos', producto);

export const getPresupuestos = () => api.get('/presupuestos');
export const createPresupuesto = (presupuesto) => api.post('/presupuestos', presupuesto);

export const getMonedas = () => api.get('/monedas');

export const getCotizaciones = () => api.get('/cotizaciones');

export default api;
