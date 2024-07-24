-- Tabla Usuarios
CREATE TABLE Usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT email_formato_correcto CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Índice para búsqueda rápida por username
CREATE INDEX idx_username ON Usuarios(username);

-- Tabla Clientes
CREATE TABLE Clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT email_formato_correcto CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Índice para búsqueda rápida por email
CREATE INDEX idx_email ON Clientes(email);

-- Tabla Productos
CREATE TABLE Productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para búsqueda rápida por nombre
CREATE INDEX idx_producto_nombre ON Productos(nombre);

-- Tabla Monedas
CREATE TABLE Monedas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    simbolo VARCHAR(10) NOT NULL,
    tipo_cambio DECIMAL(10, 4) NOT NULL CHECK (tipo_cambio > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla Cotizaciones
CREATE TABLE Cotizaciones (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES Clientes(id) ON DELETE CASCADE,
    moneda_id INTEGER REFERENCES Monedas(id) ON DELETE CASCADE,
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    frecuencia VARCHAR(20) CHECK (frecuencia IN ('mensual', 'única', 'anual')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para búsqueda rápida por cliente_id y moneda_id
CREATE INDEX idx_cotizaciones_cliente_id ON Cotizaciones(cliente_id);
CREATE INDEX idx_cotizaciones_moneda_id ON Cotizaciones(moneda_id);

-- Tabla Cotizacion_Items
CREATE TABLE Cotizacion_Items (
    id SERIAL PRIMARY KEY,
    cotizacion_id INTEGER REFERENCES Cotizaciones(id) ON DELETE CASCADE,
    producto_id INTEGER REFERENCES Productos(id) ON DELETE CASCADE,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0)
);

-- Índices para búsqueda rápida por cotizacion_id y producto_id
CREATE INDEX idx_cotizacion_items_cotizacion_id ON Cotizacion_Items(cotizacion_id);
CREATE INDEX idx_cotizacion_items_producto_id ON Cotizacion_Items(producto_id);

-- Tabla Presupuestos
CREATE TABLE Presupuestos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES Clientes(id) ON DELETE CASCADE,
    cotizacion_id INTEGER REFERENCES Cotizaciones(id) ON DELETE CASCADE,
    moneda_id INTEGER REFERENCES Monedas(id) ON DELETE CASCADE,
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para búsqueda rápida por cliente_id y cotizacion_id
CREATE INDEX idx_presupuestos_cliente_id ON Presupuestos(cliente_id);
CREATE INDEX idx_presupuestos_cotizacion_id ON Presupuestos(cotizacion_id);

-- Tabla Presupuesto_Items
CREATE TABLE Presupuesto_Items (
    id SERIAL PRIMARY KEY,
    presupuesto_id INTEGER REFERENCES Presupuestos(id) ON DELETE CASCADE,
    producto_id INTEGER REFERENCES Productos(id) ON DELETE CASCADE,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0)
);

-- Índices para búsqueda rápida por presupuesto_id y producto_id
CREATE INDEX idx_presupuesto_items_presupuesto_id ON Presupuesto_Items(presupuesto_id);
CREATE INDEX idx_presupuesto_items_producto_id ON Presupuesto_Items(producto_id);

-- Tabla Contratos
CREATE TABLE Contratos (
    id SERIAL PRIMARY KEY,
    presupuesto_id INTEGER REFERENCES Presupuestos(id) ON DELETE CASCADE,
    cliente_id INTEGER REFERENCES Clientes(id) ON DELETE CASCADE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    detalles TEXT,
    moneda_id INTEGER REFERENCES Monedas(id) ON DELETE CASCADE,
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fecha_fin_mayor_inicio CHECK (fecha_fin IS NULL OR fecha_fin > fecha_inicio)
);

-- Índices para búsqueda rápida por presupuesto_id y cliente_id
CREATE INDEX idx_contratos_presupuesto_id ON Contratos(presupuesto_id);
CREATE INDEX idx_contratos_cliente_id ON Contratos(cliente_id);

-- Tabla Facturas
CREATE TABLE Facturas (
    id SERIAL PRIMARY KEY,
    contrato_id INTEGER REFERENCES Contratos(id) ON DELETE CASCADE,
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE,
    estado VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT estado_valido CHECK (estado IN ('pagada', 'pendiente', 'vencida')),
    CONSTRAINT fecha_vencimiento_valida CHECK (fecha_vencimiento IS NULL OR fecha_vencimiento > fecha_emision)
);

-- Índices para búsqueda rápida por contrato_id
CREATE INDEX idx_facturas_contrato_id ON Facturas(contrato_id);

-- Tabla Facturas_Items
CREATE TABLE Facturas_Items (
    id SERIAL PRIMARY KEY,
    factura_id INTEGER REFERENCES Facturas(id) ON DELETE CASCADE,
    producto_id INTEGER REFERENCES Productos(id) ON DELETE CASCADE,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0)
);

-- Índices para búsqueda rápida por factura_id y producto_id
CREATE INDEX idx_facturas_items_factura_id ON Facturas_Items(factura_id);
CREATE INDEX idx_facturas_items_producto_id ON Facturas_Items(producto_id);
-- Cambiar nombre de tablas
ALTER TABLE public."Facturas" RENAME TO "Comprobantes";

-- Cambiar nombre de tablas
ALTER TABLE public."Facturas_Items" RENAME TO "Comprobantes_Items";



