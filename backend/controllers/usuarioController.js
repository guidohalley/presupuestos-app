import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import Usuario from '../models/Usuario.js';

export const register = async (req, res) => {
  try {
    const { username, password, email } = req.body;

    const existingUser = await Usuario.findOne({ where: { username } });
    const existingEmail = await Usuario.findOne({ where: { email } });

    if (existingUser) {
      return res.status(400).json({ error: "Username already exists" });
    }

    if (existingEmail) {
      return res.status(400).json({ error: "Email already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const usuario = await Usuario.create({
      username,
      password_hash: hashedPassword,
      email,
    });

    res.json({ message: "User registered successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to register user" });
  }
};

export const login = async (req, res) => {
  try {
    const { username, password } = req.body;

    const usuario = await Usuario.findOne({ where: { username } });

    if (!usuario) {
      return res.status(400).json({ error: "Invalid username or password" });
    }

    const isPasswordValid = await bcrypt.compare(
      password,
      usuario.password_hash
    );

    if (!isPasswordValid) {
      return res.status(400).json({ error: "Invalid username or password" });
    }

    const token = jwt.sign({ userId: usuario.id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });

    res.json({ token });
  } catch (error) {
    console.error("Error logging in:", error);
    res.status(500).json({ error: "Failed to login user" });
  }
};

export const getAllUsuarios = async (req, res) => {
  try {
    const usuarios = await Usuario.findAll();
    res.json(usuarios);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch users" });
  }
};

export const getUsuarioById = async (req, res) => {
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) {
      return res.status(404).json({ error: "User not found" });
    }
    res.json(usuario);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch user" });
  }
};

export const updateUsuario = async (req, res) => {
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) {
      return res.status(404).json({ error: "User not found" });
    }
    await usuario.update(req.body);
    res.json(usuario);
  } catch (error) {
    res.status(500).json({ error: "Failed to update user" });
  }
};

export const deleteUsuario = async (req, res) => {
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) {
      return res.status(404).json({ error: "User not found" });
    }
    await usuario.destroy();
    res.json({ message: "User deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete user" });
  }
};
