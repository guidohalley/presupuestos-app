--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Ubuntu 14.12-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)

-- Started on 2024-07-24 09:35:36 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3495 (class 1262 OID 183587)
-- Name: presupuesto; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE presupuesto WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es_AR.UTF-8';

ALTER DATABASE presupuesto OWNER TO postgres;

\connect presupuesto

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;

ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';

SET default_tablespace = '';

SET default_table_access_method = heap;

-- parte 2 
--
-- TOC entry 210 (class 1259 OID 183806)
-- Name: Clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Clientes" (
    id serial PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefono VARCHAR(255),
    direccion VARCHAR(255),
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    empresa_id INTEGER NOT NULL,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id),
    CONSTRAINT chk_email CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
);

--
-- TOC entry 231 (class 1259 OID 184023)
-- Name: Clientes_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Clientes_empresa_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Clientes_empresa_id_seq" OWNER TO postgres;

--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 231
-- Name: Clientes_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Clientes_empresa_id_seq" OWNED BY public."Clientes".empresa_id;

--
-- TOC entry 209 (class 1259 OID 183805)
-- Name: Clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Clientes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Clientes_id_seq" OWNER TO postgres;

--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 209
-- Name: Clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Clientes_id_seq" OWNED BY public."Clientes".id;
-- parte 3
--
-- TOC entry 220 (class 1259 OID 183915)
-- Name: Comprobantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comprobantes" (
    id serial PRIMARY KEY,
    contrato_id integer NOT NULL,
    total numeric(10,2) NOT NULL CHECK (total >= 0),
    fecha_emision timestamp with time zone NOT NULL,
    fecha_vencimiento timestamp with time zone,
    estado character varying(255),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_contrato FOREIGN KEY(contrato_id) REFERENCES public."Contratos"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id)
);

--
-- TOC entry 220 (class 1259 OID 183915)
-- Name: Comprobantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comprobantes" (
    id serial PRIMARY KEY,
    numero_comprobante VARCHAR(20) NOT NULL,
    tipo_comprobante VARCHAR(50) NOT NULL,
    punto_venta VARCHAR(5) NOT NULL,
    cae VARCHAR(14),
    fecha_vencimiento_cae TIMESTAMPTZ,
    contrato_id integer NOT NULL,
    total numeric(10,2) NOT NULL CHECK (total >= 0),
    fecha_emision timestamp with time zone NOT NULL,
    fecha_vencimiento timestamp with time zone,
    estado character varying(255),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_contrato FOREIGN KEY(contrato_id) REFERENCES public."Contratos"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id)
);

ALTER TABLE public."Comprobantes" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 184047)
-- Name: Comprobantes_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Comprobantes_empresa_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Comprobantes_empresa_id_seq" OWNER TO postgres;

--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 232
-- Name: Comprobantes_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Comprobantes_empresa_id_seq" OWNED BY public."Comprobantes".empresa_id;
-- parte 4
--
-- TOC entry 222 (class 1259 OID 183927)
-- Name: Comprobantes_Items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comprobantes_Items" (
    id serial PRIMARY KEY,
    factura_id integer NOT NULL,
    contrato_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_factura FOREIGN KEY(factura_id) REFERENCES public."Comprobantes"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_contrato FOREIGN KEY(contrato_id) REFERENCES public."Contratos"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id)
);

ALTER TABLE public."Comprobantes_Items" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 184058)
-- Name: Comprobantes_Items_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Comprobantes_Items_empresa_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Comprobantes_Items_empresa_id_seq" OWNER TO postgres;

--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 233
-- Name: Comprobantes_Items_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Comprobantes_Items_empresa_id_seq" OWNED BY public."Comprobantes_Items".empresa_id;
-- parte 5
--
-- TOC entry 216 (class 1259 OID 183865)
-- Name: Contratos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Contratos" (
    id serial PRIMARY KEY,
    presupuesto_id integer NOT NULL,
    cliente_id integer NOT NULL,
    fecha_inicio timestamp with time zone NOT NULL,
    fecha_fin timestamp with time zone,
    detalles text,
    moneda_id integer NOT NULL,
    total numeric(10,2) NOT NULL CHECK (total >= 0),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_presupuesto FOREIGN KEY(presupuesto_id) REFERENCES public."Presupuestos"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_cliente FOREIGN KEY(cliente_id) REFERENCES public."Clientes"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_moneda FOREIGN KEY(moneda_id) REFERENCES public."Monedas"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id)
);

ALTER TABLE public."Contratos" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 184070)
-- Name: Contratos_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Contratos_empresa_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Contratos_empresa_id_seq" OWNER TO postgres;

--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 234
-- Name: Contratos_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Contratos_empresa_id_seq" OWNED BY public."Contratos".empresa_id;

--
-- TOC entry 215 (class 1259 OID 183864)
-- Name: Contratos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Contratos_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Contratos_id_seq" OWNER TO postgres;

--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 215
-- Name: Contratos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Contratos_id_seq" OWNED BY public."Contratos".id;

--
-- TOC entry 212 (class 1259 OID 183817)
-- Name: Monedas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Monedas" (
    id serial PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    simbolo VARCHAR(255) NOT NULL,
    tipo_cambio numeric(10,2) NOT NULL,
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id)
);

ALTER TABLE public."Monedas" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 184083)
-- Name: Monedas_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Monedas_empresa_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Monedas_empresa_id_seq" OWNER TO postgres;

--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 235
-- Name: Monedas_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Monedas_empresa_id_seq" OWNED BY public."Monedas".empresa_id;

--
-- TOC entry 211 (class 1259 OID 183816)
-- Name: Monedas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Monedas_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Monedas_id_seq" OWNER TO postgres;

--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 211
-- Name: Monedas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Monedas_id_seq" OWNED BY public."Monedas".id;
--
-- TOC entry 224 (class 1259 OID 183944)
-- Name: Presupuesto_Items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Presupuesto_Items" (
    id serial PRIMARY KEY,
    presupuesto_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad integer NOT NULL,
    precio numeric(10,2) NOT NULL CHECK (precio >= 0),
    total numeric(10,2) NOT NULL CHECK (total >= 0),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    CONSTRAINT fk_presupuesto FOREIGN KEY(presupuesto_id) REFERENCES public."Presupuestos"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_producto FOREIGN KEY(producto_id) REFERENCES public."Productos"(id) ON UPDATE CASCADE
);

ALTER TABLE public."Presupuesto_Items" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 183943)
-- Name: Presupuesto_Items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Presupuesto_Items_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Presupuesto_Items_id_seq" OWNER TO postgres;

--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 223
-- Name: Presupuesto_Items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Presupuesto_Items_id_seq" OWNED BY public."Presupuesto_Items".id;
--
-- TOC entry 214 (class 1259 OID 183843)
-- Name: Presupuestos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Presupuestos" (
    id serial PRIMARY KEY,
    cliente_id integer NOT NULL,
    moneda_id integer NOT NULL,
    total numeric(10,2) NOT NULL CHECK (total >= 0),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY(cliente_id) REFERENCES public."Clientes"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_moneda FOREIGN KEY(moneda_id) REFERENCES public."Monedas"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id)
);

ALTER TABLE public."Presupuestos" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 184096)
-- Name: Presupuestos_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Presupuestos_empresa_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Presupuestos_empresa_id_seq" OWNER TO postgres;

--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 236
-- Name: Presupuestos_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Presupuestos_empresa_id_seq" OWNED BY public."Presupuestos".empresa_id;

--
-- TOC entry 213 (class 1259 OID 183842)
-- Name: Presupuestos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Presupuestos_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Presupuestos_id_seq" OWNER TO postgres;

--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 213
-- Name: Presupuestos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Presupuestos_id_seq" OWNED BY public."Presupuestos".id;
--
-- TOC entry 218 (class 1259 OID 183889)
-- Name: Productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Productos" (
    id serial PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion text,
    precio numeric(10,2) NOT NULL CHECK (precio >= 0),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id)
);

ALTER TABLE public."Productos" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 184001)
-- Name: Productos_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Productos_empresa_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Productos_empresa_id_seq" OWNER TO postgres;

--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 230
-- Name: Productos_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Productos_empresa_id_seq" OWNED BY public."Productos".empresa_id;

--
-- TOC entry 217 (class 1259 OID 183888)
-- Name: Productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Productos_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Productos_id_seq" OWNER TO postgres;

--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 217
-- Name: Productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Productos_id_seq" OWNED BY public."Productos".id;
CREATE TABLE public."Impuestos" (
    id serial PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL, -- IVA, Retención, etc.
    porcentaje numeric(5,2) NOT NULL CHECK (porcentaje >= 0),
    descripcion text,
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id)
);

ALTER TABLE public."Impuestos" OWNER TO postgres;

CREATE SEQUENCE public."Impuestos_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Impuestos_id_seq" OWNER TO postgres;

ALTER SEQUENCE public."Impuestos_id_seq" OWNED BY public."Impuestos".id;

CREATE TABLE public."Comprobantes_Impuestos" (
    id serial PRIMARY KEY,
    comprobante_id integer NOT NULL,
    impuesto_id integer NOT NULL,
    monto numeric(10,2) NOT NULL CHECK (monto >= 0),
    CONSTRAINT fk_comprobante FOREIGN KEY(comprobante_id) REFERENCES public."Comprobantes"(id) ON UPDATE CASCADE,
    CONSTRAINT fk_impuesto FOREIGN KEY(impuesto_id) REFERENCES public."Impuestos"(id) ON UPDATE CASCADE
);

ALTER TABLE public."Comprobantes_Impuestos" OWNER TO postgres;

CREATE SEQUENCE public."Comprobantes_Impuestos_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Comprobantes_Impuestos_id_seq" OWNER TO postgres;

ALTER SEQUENCE public."Comprobantes_Impuestos_id_seq" OWNED BY public."Comprobantes_Impuestos".id;

--
-- TOC entry 226 (class 1259 OID 183961)
-- Name: Usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Usuarios" (
    id serial PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    empresa_id integer NOT NULL,
    CONSTRAINT fk_empresa FOREIGN KEY(empresa_id) REFERENCES public.empresa(id),
    CONSTRAINT chk_email CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
);

ALTER TABLE public."Usuarios" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 183990)
-- Name: Usuarios_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Usuarios_empresa_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Usuarios_empresa_id_seq" OWNER TO postgres;

--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 229
-- Name: Usuarios_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Usuarios_empresa_id_seq" OWNED BY public."Usuarios".empresa_id;

--
-- TOC entry 225 (class 1259 OID 183960)
-- Name: Usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Usuarios_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."Usuarios_id_seq" OWNER TO postgres;

--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 225
-- Name: Usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Usuarios_id_seq" OWNED BY public."Usuarios".id;

--
-- TOC entry 228 (class 1259 OID 183982)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    id serial PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 183981)
-- Name: empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empresa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.empresa_id_seq OWNER TO postgres;

--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 227
-- Name: empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_id_seq OWNED BY public.empresa.id;

--
-- Constraints and Foreign Keys for Table: Clientes
--

ALTER TABLE ONLY public."Clientes"
    ADD CONSTRAINT "Clientes_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT "Clientes_email_key" UNIQUE (email),
    ADD CONSTRAINT "Clientes_cuit_key" UNIQUE (cuit),
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;


--
-- Constraints and Foreign Keys for Table: Comprobantes
--

ALTER TABLE ONLY public."Comprobantes"
    ADD CONSTRAINT "Comprobantes_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_contrato FOREIGN KEY (contrato_id) REFERENCES public."Contratos" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;

--
-- Constraints and Foreign Keys for Table: Comprobantes_Items
--

ALTER TABLE ONLY public."Comprobantes_Items"
    ADD CONSTRAINT "Comprobantes_Items_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_factura FOREIGN KEY (factura_id) REFERENCES public."Comprobantes" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_contrato FOREIGN KEY (contrato_id) REFERENCES public."Contratos" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;


--
-- Constraints and Foreign Keys for Table: Contratos
--

ALTER TABLE ONLY public."Contratos"
    ADD CONSTRAINT "Contratos_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_presupuesto FOREIGN KEY (presupuesto_id) REFERENCES public."Presupuestos" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES public."Clientes" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_moneda FOREIGN KEY (moneda_id) REFERENCES public."Monedas" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;


--
-- Constraints and Foreign Keys for Table: Monedas
--

ALTER TABLE ONLY public."Monedas"
    ADD CONSTRAINT "Monedas_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;


--
-- Constraints and Foreign Keys for Table: Presupuesto_Items
--

ALTER TABLE ONLY public."Presupuesto_Items"
    ADD CONSTRAINT "Presupuesto_Items_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_presupuesto FOREIGN KEY (presupuesto_id) REFERENCES public."Presupuestos" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_producto FOREIGN KEY (producto_id) REFERENCES public."Productos" (id) ON UPDATE CASCADE;

--
-- Constraints and Foreign Keys for Table: Presupuestos
--

ALTER TABLE ONLY public."Presupuestos"
    ADD CONSTRAINT "Presupuestos_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES public."Clientes" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_moneda FOREIGN KEY (moneda_id) REFERENCES public."Monedas" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;

--
-- Constraints and Foreign Keys for Table: Productos
--

ALTER TABLE ONLY public."Productos"
    ADD CONSTRAINT "Productos_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;
--
-- Constraints and Foreign Keys for Table: Usuarios
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT "Usuarios_email_key" UNIQUE (email),
    ADD CONSTRAINT "Usuarios_username_key" UNIQUE (username),
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;

--
-- Constraints and Foreign Keys for Table: empresa
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pk PRIMARY KEY (id);

--
-- Constraints and Foreign Keys for Table: Impuestos
--

ALTER TABLE ONLY public."Impuestos"
    ADD CONSTRAINT "Impuestos_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_empresa FOREIGN KEY (empresa_id) REFERENCES public.empresa (id) ON UPDATE CASCADE;

--
-- Constraints and Foreign Keys for Table: Comprobantes_Impuestos
--

ALTER TABLE ONLY public."Comprobantes_Impuestos"
    ADD CONSTRAINT "Comprobantes_Impuestos_pkey" PRIMARY KEY (id),
    ADD CONSTRAINT fk_comprobante FOREIGN KEY (comprobante_id) REFERENCES public."Comprobantes" (id) ON UPDATE CASCADE,
    ADD CONSTRAINT fk_impuesto FOREIGN KEY (impuesto_id) REFERENCES public."Impuestos" (id) ON UPDATE CASCADE;

--
-- TOC entry 3481 (class 0 OID 183982)
-- Dependencies: 228
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa (id, nombre, cuit, direccion, telefono) FROM stdin;
1	twodesigners	30712345678	"Av. Siempreviva 742"	"1234-5678"
2	otro	30798765432	"Calle Falsa 123"	"8765-4321"
\.

--
-- TOC entry 3463 (class 0 OID 183806)
-- Dependencies: 210
-- Data for Name: Clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Clientes" (id, nombre, email, telefono, direccion, cuit, tipo_cliente, estado, "createdAt", "updatedAt", empresa_id) FROM stdin;
1	cliente1	fulano@fulano	3434	asdfsdf	20123456789	individual	activo	2024-07-23 09:02:52.17-03	2024-07-23 09:02:52.17-03	1
2	cliente2	fulano@fulaffno.com	3434454	asdfssd	20234567890	empresa	activo	2024-07-23 09:07:10.972-03	2024-07-23 09:07:10.972-03	2
\.
--
-- TOC entry 3465 (class 0 OID 183817)
-- Dependencies: 212
-- Data for Name: Monedas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Monedas" (id, nombre, simbolo, tipo_cambio, created_at, updated_at, empresa_id) FROM stdin;
1	Peso	$	1.00	\N	\N	1
2	Dólar	USD	150.00	\N	\N	1
\.
--
-- TOC entry 3471 (class 0 OID 183889)
-- Dependencies: 218
-- Data for Name: Productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Productos" (id, nombre, descripcion, precio, created_at, updated_at, empresa_id) FROM stdin;
1	Página Web	Landing Page	850000.00	\N	\N	1
2	SEO	Optimización de motores de búsqueda	50000.00	\N	\N	1
\.
--
-- TOC entry 3479 (class 0 OID 183961)
-- Dependencies: 226
-- Data for Name: Usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Usuarios" (id, username, password_hash, email, nombre_completo, rol, ultimo_inicio_sesion, created_at, updated_at, empresa_id) FROM stdin;
1	guido	$2b$10$sd8osgyTtAmBUSEt2RSs2ekb2twA7MDLCan5eHQAkYAk2fS4bNfeC	guido@guido.com	Guido Smith	admin	\N	2024-07-23 09:00:10.419-03	2024-07-23 09:00:10.419-03	1
2	guido2	$2b$10$6AdjJNKylh7hmVspB.7m5.KbQYV6SoD/wlZrhxCvkuRPkotMWigDu	guido2@guido2.com	Guido Doe	usuario	\N	2024-07-23 10:29:10.389-03	2024-07-23 10:29:10.389-03	1
\.
--
-- TOC entry 3469 (class 0 OID 183865)
-- Dependencies: 216
-- Data for Name: Contratos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Contratos" (id, presupuesto_id, cliente_id, fecha_inicio, fecha_fin, condiciones, tipo_contrato, firmado, detalles, moneda_id, total, created_at, updated_at, empresa_id) FROM stdin;
1	1	1	2024-07-01 00:00:00-03	2025-07-01 00:00:00-03	Condiciones de ejemplo	Tipo A	FALSE	Detalles de ejemplo	1	850000.00	\N	\N	1
\.
--
-- TOC entry 3467 (class 0 OID 183843)
-- Dependencies: 214
-- Data for Name: Presupuestos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Presupuestos" (id, numero_presupuesto, estado_presupuesto, cliente_id, moneda_id, total, created_at, updated_at, empresa_id) FROM stdin;
1	PRESUP-20240701	pendiente	1	1	850000.00	\N	\N	1
\.
--
-- TOC entry 3477 (class 0 OID 183944)
-- Dependencies: 224
-- Data for Name: Presupuesto_Items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Presupuesto_Items" (id, presupuesto_id, producto_id, cantidad, precio, total, created_at, updated_at) FROM stdin;
1	1	1	1	850000.00	850000.00	\N	\N
\.
--
-- TOC entry 3481 (class 0 OID 183982)
-- Dependencies: 228
-- Data for Name: Impuestos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Impuestos" (id, tipo, porcentaje, descripcion, created_at, updated_at, empresa_id) FROM stdin;
1	IVA	21.00	Impuesto al Valor Agregado	\N	\N	1
2	Retención	10.00	Retención de Ganancias	\N	\N	1
\.
--
-- TOC entry 3481 (class 0 OID 183982)
-- Dependencies: 228
-- Data for Name: Comprobantes_Impuestos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Comprobantes_Impuestos" (id, comprobante_id, impuesto_id, monto) FROM stdin;
1	1	1	178500.00
2	1	2	85000.00
\.

