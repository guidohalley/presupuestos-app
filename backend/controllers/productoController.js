import Producto from '../models/Producto.js';

export const getAllProductos = async (req, res) => {
  try {
    const productos = await Producto.findAll();
    res.json(productos);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch products" });
  }
};

export const createProducto = async (req, res) => {
  try {
    const producto = await Producto.create(req.body);
    res.json(producto);
  } catch (error) {
    res.status(500).json({ error: "Failed to create product" });
  }
};

export const getProductoById = async (req, res) => {
  try {
    const producto = await Producto.findByPk(req.params.id);
    if (!producto) {
      return res.status(404).json({ error: "Product not found" });
    }
    res.json(producto);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch product" });
  }
};

export const updateProducto = async (req, res) => {
  try {
    const producto = await Producto.findByPk(req.params.id);
    if (!producto) {
      return res.status(404).json({ error: "Product not found" });
    }
    await producto.update(req.body);
    res.json(producto);
  } catch (error) {
    res.status(500).json({ error: "Failed to update product" });
  }
};

export const deleteProducto = async (req, res) => {
  try {
    const producto = await Producto.findByPk(req.params.id);
    if (!producto) {
      return res.status(404).json({ error: "Product not found" });
    }
    await producto.destroy();
    res.json({ message: "Product deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete product" });
  }
};
