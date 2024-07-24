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

--
-- TOC entry 210 (class 1259 OID 183806)
-- Name: Clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Clientes" (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    telefono character varying(255),
    direccion character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    empresa_id integer NOT NULL
);


ALTER TABLE public."Clientes" OWNER TO postgres;

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


--
-- TOC entry 220 (class 1259 OID 183915)
-- Name: Comprobantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comprobantes" (
    id integer NOT NULL,
    contrato_id integer NOT NULL,
    total numeric(10,2) NOT NULL,
    fecha_emision timestamp with time zone NOT NULL,
    fecha_vencimiento timestamp with time zone,
    estado character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    empresa_id integer NOT NULL
);


ALTER TABLE public."Comprobantes" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 183927)
-- Name: Comprobantes_Items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comprobantes_Items" (
    id integer NOT NULL,
    factura_id integer NOT NULL,
    contrato_id integer NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    empresa_id integer NOT NULL
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


--
-- TOC entry 216 (class 1259 OID 183865)
-- Name: Contratos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Contratos" (
    id integer NOT NULL,
    presupuesto_id integer NOT NULL,
    cliente_id integer NOT NULL,
    fecha_inicio timestamp with time zone NOT NULL,
    fecha_fin timestamp with time zone,
    detalles text,
    moneda_id integer NOT NULL,
    total numeric(10,2) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    empresa_id integer NOT NULL
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
-- TOC entry 221 (class 1259 OID 183926)
-- Name: Facturas_Items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Facturas_Items_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Facturas_Items_id_seq" OWNER TO postgres;

--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 221
-- Name: Facturas_Items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Facturas_Items_id_seq" OWNED BY public."Comprobantes_Items".id;


--
-- TOC entry 219 (class 1259 OID 183914)
-- Name: Facturas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Facturas_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Facturas_id_seq" OWNER TO postgres;

--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 219
-- Name: Facturas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Facturas_id_seq" OWNED BY public."Comprobantes".id;


--
-- TOC entry 212 (class 1259 OID 183817)
-- Name: Monedas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Monedas" (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    simbolo character varying(255) NOT NULL,
    tipo_cambio numeric(10,2) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    empresa_id integer NOT NULL
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
    id integer NOT NULL,
    presupuesto_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    total numeric(10,2) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
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
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    moneda_id integer NOT NULL,
    total numeric(10,2) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    empresa_id integer NOT NULL
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
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text,
    precio numeric(10,2) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    empresa_id integer NOT NULL
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


--
-- TOC entry 226 (class 1259 OID 183961)
-- Name: Usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Usuarios" (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    empresa_id integer NOT NULL
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
    id integer NOT NULL,
    nombre character varying
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
-- TOC entry 3260 (class 2604 OID 183809)
-- Name: Clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Clientes" ALTER COLUMN id SET DEFAULT nextval('public."Clientes_id_seq"'::regclass);


--
-- TOC entry 3261 (class 2604 OID 184024)
-- Name: Clientes empresa_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Clientes" ALTER COLUMN empresa_id SET DEFAULT nextval('public."Clientes_empresa_id_seq"'::regclass);


--
-- TOC entry 3270 (class 2604 OID 183918)
-- Name: Comprobantes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes" ALTER COLUMN id SET DEFAULT nextval('public."Facturas_id_seq"'::regclass);


--
-- TOC entry 3271 (class 2604 OID 184048)
-- Name: Comprobantes empresa_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes" ALTER COLUMN empresa_id SET DEFAULT nextval('public."Comprobantes_empresa_id_seq"'::regclass);


--
-- TOC entry 3272 (class 2604 OID 183930)
-- Name: Comprobantes_Items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes_Items" ALTER COLUMN id SET DEFAULT nextval('public."Facturas_Items_id_seq"'::regclass);


--
-- TOC entry 3273 (class 2604 OID 184059)
-- Name: Comprobantes_Items empresa_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes_Items" ALTER COLUMN empresa_id SET DEFAULT nextval('public."Comprobantes_Items_empresa_id_seq"'::regclass);


--
-- TOC entry 3266 (class 2604 OID 183868)
-- Name: Contratos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contratos" ALTER COLUMN id SET DEFAULT nextval('public."Contratos_id_seq"'::regclass);


--
-- TOC entry 3267 (class 2604 OID 184071)
-- Name: Contratos empresa_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contratos" ALTER COLUMN empresa_id SET DEFAULT nextval('public."Contratos_empresa_id_seq"'::regclass);


--
-- TOC entry 3262 (class 2604 OID 183820)
-- Name: Monedas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Monedas" ALTER COLUMN id SET DEFAULT nextval('public."Monedas_id_seq"'::regclass);


--
-- TOC entry 3263 (class 2604 OID 184084)
-- Name: Monedas empresa_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Monedas" ALTER COLUMN empresa_id SET DEFAULT nextval('public."Monedas_empresa_id_seq"'::regclass);


--
-- TOC entry 3274 (class 2604 OID 183947)
-- Name: Presupuesto_Items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuesto_Items" ALTER COLUMN id SET DEFAULT nextval('public."Presupuesto_Items_id_seq"'::regclass);


--
-- TOC entry 3264 (class 2604 OID 183846)
-- Name: Presupuestos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuestos" ALTER COLUMN id SET DEFAULT nextval('public."Presupuestos_id_seq"'::regclass);


--
-- TOC entry 3265 (class 2604 OID 184097)
-- Name: Presupuestos empresa_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuestos" ALTER COLUMN empresa_id SET DEFAULT nextval('public."Presupuestos_empresa_id_seq"'::regclass);


--
-- TOC entry 3268 (class 2604 OID 183892)
-- Name: Productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Productos" ALTER COLUMN id SET DEFAULT nextval('public."Productos_id_seq"'::regclass);


--
-- TOC entry 3269 (class 2604 OID 184002)
-- Name: Productos empresa_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Productos" ALTER COLUMN empresa_id SET DEFAULT nextval('public."Productos_empresa_id_seq"'::regclass);


--
-- TOC entry 3275 (class 2604 OID 183964)
-- Name: Usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios" ALTER COLUMN id SET DEFAULT nextval('public."Usuarios_id_seq"'::regclass);


--
-- TOC entry 3276 (class 2604 OID 183991)
-- Name: Usuarios empresa_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios" ALTER COLUMN empresa_id SET DEFAULT nextval('public."Usuarios_empresa_id_seq"'::regclass);


--
-- TOC entry 3277 (class 2604 OID 183985)
-- Name: empresa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa ALTER COLUMN id SET DEFAULT nextval('public.empresa_id_seq'::regclass);


--
-- TOC entry 3463 (class 0 OID 183806)
-- Dependencies: 210
-- Data for Name: Clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Clientes" (id, nombre, email, telefono, direccion, "createdAt", "updatedAt", empresa_id) FROM stdin;
1	cliente1	fulano@fulano	3434	asdfsdf	2024-07-23 09:02:52.17-03	2024-07-23 09:02:52.17-03	1
2	cliente2	fulano@fulaffno.com	3434454	asdfssd	2024-07-23 09:07:10.972-03	2024-07-23 09:07:10.972-03	2
\.


--
-- TOC entry 3473 (class 0 OID 183915)
-- Dependencies: 220
-- Data for Name: Comprobantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Comprobantes" (id, contrato_id, total, fecha_emision, fecha_vencimiento, estado, created_at, updated_at, empresa_id) FROM stdin;
\.


--
-- TOC entry 3475 (class 0 OID 183927)
-- Dependencies: 222
-- Data for Name: Comprobantes_Items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Comprobantes_Items" (id, factura_id, contrato_id, created_at, updated_at, empresa_id) FROM stdin;
\.


--
-- TOC entry 3469 (class 0 OID 183865)
-- Dependencies: 216
-- Data for Name: Contratos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Contratos" (id, presupuesto_id, cliente_id, fecha_inicio, fecha_fin, detalles, moneda_id, total, created_at, updated_at, empresa_id) FROM stdin;
\.


--
-- TOC entry 3465 (class 0 OID 183817)
-- Dependencies: 212
-- Data for Name: Monedas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Monedas" (id, nombre, simbolo, tipo_cambio, created_at, updated_at, empresa_id) FROM stdin;
1	Peso	$	1.00	\N	\N	1
\.


--
-- TOC entry 3477 (class 0 OID 183944)
-- Dependencies: 224
-- Data for Name: Presupuesto_Items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Presupuesto_Items" (id, presupuesto_id, producto_id, cantidad, precio, total, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3467 (class 0 OID 183843)
-- Dependencies: 214
-- Data for Name: Presupuestos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Presupuestos" (id, cliente_id, moneda_id, total, created_at, updated_at, empresa_id) FROM stdin;
\.


--
-- TOC entry 3471 (class 0 OID 183889)
-- Dependencies: 218
-- Data for Name: Productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Productos" (id, nombre, descripcion, precio, created_at, updated_at, empresa_id) FROM stdin;
1	Pagina Web	Landing Page	850000.00	\N	\N	1
\.


--
-- TOC entry 3479 (class 0 OID 183961)
-- Dependencies: 226
-- Data for Name: Usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Usuarios" (id, username, password_hash, email, created_at, updated_at, empresa_id) FROM stdin;
1	guido	$2b$10$sd8osgyTtAmBUSEt2RSs2ekb2twA7MDLCan5eHQAkYAk2fS4bNfeC	guido@guido.com	2024-07-23 09:00:10.419-03	2024-07-23 09:00:10.419-03	1
2	guido2	$2b$10$6AdjJNKylh7hmVspB.7m5.KbQYV6SoD/wlZrhxCvkuRPkotMWigDu	guido2@guido2.com	2024-07-23 10:29:10.389-03	2024-07-23 10:29:10.389-03	1
\.


--
-- TOC entry 3481 (class 0 OID 183982)
-- Dependencies: 228
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa (id, nombre) FROM stdin;
1	twodesigners
2	otro
\.


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 231
-- Name: Clientes_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Clientes_empresa_id_seq"', 2, true);


--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 209
-- Name: Clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Clientes_id_seq"', 6, true);


--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 233
-- Name: Comprobantes_Items_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Comprobantes_Items_empresa_id_seq"', 1, false);


--
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 232
-- Name: Comprobantes_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Comprobantes_empresa_id_seq"', 1, false);


--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 234
-- Name: Contratos_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Contratos_empresa_id_seq"', 1, false);


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 215
-- Name: Contratos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Contratos_id_seq"', 1, false);


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 221
-- Name: Facturas_Items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Facturas_Items_id_seq"', 1, false);


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 219
-- Name: Facturas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Facturas_id_seq"', 1, false);


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 235
-- Name: Monedas_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Monedas_empresa_id_seq"', 1, true);


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 211
-- Name: Monedas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Monedas_id_seq"', 1, false);


--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 223
-- Name: Presupuesto_Items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Presupuesto_Items_id_seq"', 1, false);


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 236
-- Name: Presupuestos_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Presupuestos_empresa_id_seq"', 1, false);


--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 213
-- Name: Presupuestos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Presupuestos_id_seq"', 1, false);


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 230
-- Name: Productos_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Productos_empresa_id_seq"', 1, true);


--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 217
-- Name: Productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Productos_id_seq"', 1, false);


--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 229
-- Name: Usuarios_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Usuarios_empresa_id_seq"', 2, true);


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 225
-- Name: Usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Usuarios_id_seq"', 2, true);


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 227
-- Name: empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_id_seq', 1, false);


--
-- TOC entry 3279 (class 2606 OID 183815)
-- Name: Clientes Clientes_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Clientes"
    ADD CONSTRAINT "Clientes_email_key" UNIQUE (email);


--
-- TOC entry 3281 (class 2606 OID 183813)
-- Name: Clientes Clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Clientes"
    ADD CONSTRAINT "Clientes_pkey" PRIMARY KEY (id);


--
-- TOC entry 3287 (class 2606 OID 183872)
-- Name: Contratos Contratos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contratos"
    ADD CONSTRAINT "Contratos_pkey" PRIMARY KEY (id);


--
-- TOC entry 3293 (class 2606 OID 183932)
-- Name: Comprobantes_Items Facturas_Items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes_Items"
    ADD CONSTRAINT "Facturas_Items_pkey" PRIMARY KEY (id);


--
-- TOC entry 3291 (class 2606 OID 183920)
-- Name: Comprobantes Facturas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes"
    ADD CONSTRAINT "Facturas_pkey" PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 183824)
-- Name: Monedas Monedas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Monedas"
    ADD CONSTRAINT "Monedas_pkey" PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 183949)
-- Name: Presupuesto_Items Presupuesto_Items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuesto_Items"
    ADD CONSTRAINT "Presupuesto_Items_pkey" PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 183848)
-- Name: Presupuestos Presupuestos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuestos"
    ADD CONSTRAINT "Presupuestos_pkey" PRIMARY KEY (id);


--
-- TOC entry 3289 (class 2606 OID 183896)
-- Name: Productos Productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Productos"
    ADD CONSTRAINT "Productos_pkey" PRIMARY KEY (id);


--
-- TOC entry 3299 (class 2606 OID 183972)
-- Name: Usuarios Usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_email_key" UNIQUE (email);


--
-- TOC entry 3301 (class 2606 OID 183968)
-- Name: Usuarios Usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_pkey" PRIMARY KEY (id);


--
-- TOC entry 3303 (class 2606 OID 183970)
-- Name: Usuarios Usuarios_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_username_key" UNIQUE (username);


--
-- TOC entry 3295 (class 2606 OID 183980)
-- Name: Comprobantes_Items comprobantes_items_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes_Items"
    ADD CONSTRAINT comprobantes_items_unique UNIQUE (contrato_id);


--
-- TOC entry 3305 (class 2606 OID 183989)
-- Name: empresa empresa_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pk PRIMARY KEY (id);


--
-- TOC entry 3311 (class 2606 OID 183878)
-- Name: Contratos Contratos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contratos"
    ADD CONSTRAINT "Contratos_cliente_id_fkey" FOREIGN KEY (cliente_id) REFERENCES public."Clientes"(id) ON UPDATE CASCADE;


--
-- TOC entry 3312 (class 2606 OID 183883)
-- Name: Contratos Contratos_moneda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contratos"
    ADD CONSTRAINT "Contratos_moneda_id_fkey" FOREIGN KEY (moneda_id) REFERENCES public."Monedas"(id) ON UPDATE CASCADE;


--
-- TOC entry 3313 (class 2606 OID 183873)
-- Name: Contratos Contratos_presupuesto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contratos"
    ADD CONSTRAINT "Contratos_presupuesto_id_fkey" FOREIGN KEY (presupuesto_id) REFERENCES public."Presupuestos"(id) ON UPDATE CASCADE;


--
-- TOC entry 3317 (class 2606 OID 183933)
-- Name: Comprobantes_Items Facturas_Items_factura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes_Items"
    ADD CONSTRAINT "Facturas_Items_factura_id_fkey" FOREIGN KEY (factura_id) REFERENCES public."Comprobantes"(id) ON UPDATE CASCADE;


--
-- TOC entry 3320 (class 2606 OID 183950)
-- Name: Presupuesto_Items Presupuesto_Items_presupuesto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuesto_Items"
    ADD CONSTRAINT "Presupuesto_Items_presupuesto_id_fkey" FOREIGN KEY (presupuesto_id) REFERENCES public."Presupuestos"(id) ON UPDATE CASCADE;


--
-- TOC entry 3321 (class 2606 OID 183955)
-- Name: Presupuesto_Items Presupuesto_Items_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuesto_Items"
    ADD CONSTRAINT "Presupuesto_Items_producto_id_fkey" FOREIGN KEY (producto_id) REFERENCES public."Productos"(id) ON UPDATE CASCADE;


--
-- TOC entry 3308 (class 2606 OID 183849)
-- Name: Presupuestos Presupuestos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuestos"
    ADD CONSTRAINT "Presupuestos_cliente_id_fkey" FOREIGN KEY (cliente_id) REFERENCES public."Clientes"(id) ON UPDATE CASCADE;


--
-- TOC entry 3309 (class 2606 OID 183859)
-- Name: Presupuestos Presupuestos_moneda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuestos"
    ADD CONSTRAINT "Presupuestos_moneda_id_fkey" FOREIGN KEY (moneda_id) REFERENCES public."Monedas"(id) ON UPDATE CASCADE;


--
-- TOC entry 3306 (class 2606 OID 184127)
-- Name: Clientes cliente_empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Clientes"
    ADD CONSTRAINT cliente_empresa_fk FOREIGN KEY (id) REFERENCES public.empresa(id);


--
-- TOC entry 3316 (class 2606 OID 184053)
-- Name: Comprobantes comprobantes_empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes"
    ADD CONSTRAINT comprobantes_empresa_fk FOREIGN KEY (id) REFERENCES public.empresa(id);


--
-- TOC entry 3318 (class 2606 OID 183974)
-- Name: Comprobantes_Items comprobantes_items_contratos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes_Items"
    ADD CONSTRAINT comprobantes_items_contratos_fk FOREIGN KEY (id) REFERENCES public."Contratos"(id);


--
-- TOC entry 3319 (class 2606 OID 184065)
-- Name: Comprobantes_Items comprobantes_items_empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comprobantes_Items"
    ADD CONSTRAINT comprobantes_items_empresa_fk FOREIGN KEY (id) REFERENCES public.empresa(id);


--
-- TOC entry 3314 (class 2606 OID 184078)
-- Name: Contratos contratos_empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contratos"
    ADD CONSTRAINT contratos_empresa_fk FOREIGN KEY (id) REFERENCES public.empresa(id);


--
-- TOC entry 3307 (class 2606 OID 184132)
-- Name: Monedas monedas_empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Monedas"
    ADD CONSTRAINT monedas_empresa_fk FOREIGN KEY (id) REFERENCES public.empresa(id);


--
-- TOC entry 3310 (class 2606 OID 184102)
-- Name: Presupuestos presupuestos_empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Presupuestos"
    ADD CONSTRAINT presupuestos_empresa_fk FOREIGN KEY (id) REFERENCES public.empresa(id);


--
-- TOC entry 3315 (class 2606 OID 184137)
-- Name: Productos prodcutos_empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Productos"
    ADD CONSTRAINT prodcutos_empresa_fk FOREIGN KEY (id) REFERENCES public.empresa(id);


--
-- TOC entry 3322 (class 2606 OID 184142)
-- Name: Usuarios usuarios_empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT usuarios_empresa_fk FOREIGN KEY (id) REFERENCES public.empresa(id);


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-07-24 09:35:40 -03

--
-- PostgreSQL database dump complete
--

