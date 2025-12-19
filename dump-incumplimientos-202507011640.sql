--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.0

-- Started on 2025-07-01 16:40:56

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- TOC entry 3466 (class 1262 OID 16388)
-- Name: incumplimientos; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO owner_cumplimiento_dev;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 233 (class 1259 OID 24592)
-- Name: carta_incpmt; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.carta_incpmt (
    id_carta_incpmt integer NOT NULL,
    fecha_creacion timestamp without time zone,
    correlativo_correspondencia character varying,
    id_cumplimiento integer,
    asunto character varying
);


ALTER TABLE public.carta_incpmt OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 234 (class 1259 OID 24610)
-- Name: carta_incpmt_seg; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.carta_incpmt_seg (
    descripcion character varying,
    id_cartas_incpmt_seg character varying NOT NULL,
    id_tipo_evento_seg integer,
    fecha_evento timestamp without time zone,
    id_carta_incpmt integer
);


ALTER TABLE public.carta_incpmt_seg OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 228 (class 1259 OID 16770)
-- Name: cumplimiento; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.cumplimiento (
    id_cumplimiento integer NOT NULL,
    id_sub_norma integer,
    id_tipo_cumplimiento integer,
    id_detalle_cumplimiento integer,
    estado text,
    id_reuc bigint,
    periodo_cumplimiento character varying,
    fecha_carga character varying,
    anio character varying,
    vigencia boolean
);


ALTER TABLE public.cumplimiento OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 222 (class 1259 OID 16729)
-- Name: departamento; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.departamento (
    id_departamento integer NOT NULL,
    nombre text,
    jefatura text,
    responsable_nombre text
);


ALTER TABLE public.departamento OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 230 (class 1259 OID 16789)
-- Name: detalle_cumplimiento; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.detalle_cumplimiento (
    id_detalle_cumplimiento integer NOT NULL,
    valor_cumplimiento text,
    estado text,
    id_cumplimiento integer,
    nombre_empresa_cc character varying
);


ALTER TABLE public.detalle_cumplimiento OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 224 (class 1259 OID 16747)
-- Name: homologacion; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.homologacion (
    id_homologacion integer NOT NULL,
    id_sub_norma integer,
    valor_input_nombre_coordinado_archivo_sub_norma text,
    valor_output_empresa_cc text,
    valor_output_rut_coordinado character varying
);


ALTER TABLE public.homologacion OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 218 (class 1259 OID 16706)
-- Name: norma; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.norma (
    id_norma integer NOT NULL,
    nombre text,
    descripcion character varying,
    articulo character varying,
    cuerpo_legal character varying
);


ALTER TABLE public.norma OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 232 (class 1259 OID 16808)
-- Name: reuc; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.reuc (
    id_reuc integer NOT NULL,
    nombre_fantasia text,
    rut text,
    comentario text,
    codigo_postal text,
    gerente_general text,
    correo_electronico text,
    telefono text,
    direccion text,
    comuna text,
    encargado_titular text,
    razon_social character varying,
    tipo character varying
);


ALTER TABLE public.reuc OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 220 (class 1259 OID 16715)
-- Name: sub_norma; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.sub_norma (
    id_sub_norma integer NOT NULL,
    id_norma integer,
    descripcion text,
    id_departamento integer,
    nombre character varying,
    periocidad character varying,
    numeral character varying
);


ALTER TABLE public.sub_norma OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 227 (class 1259 OID 16769)
-- Name: tabla_cumplimiento_id_cumplimiento_seq; Type: SEQUENCE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE SEQUENCE public.tabla_cumplimiento_id_cumplimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tabla_cumplimiento_id_cumplimiento_seq OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 227
-- Name: tabla_cumplimiento_id_cumplimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tabla_cumplimiento_id_cumplimiento_seq OWNED BY public.cumplimiento.id_cumplimiento;


--
-- TOC entry 221 (class 1259 OID 16728)
-- Name: tabla_departamento_id_departamento_seq; Type: SEQUENCE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE SEQUENCE public.tabla_departamento_id_departamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tabla_departamento_id_departamento_seq OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 221
-- Name: tabla_departamento_id_departamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER SEQUENCE public.tabla_departamento_id_departamento_seq OWNED BY public.departamento.id_departamento;


--
-- TOC entry 229 (class 1259 OID 16788)
-- Name: tabla_detalle_cumplimiento_id_detalle_cumplimiento_seq; Type: SEQUENCE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE SEQUENCE public.tabla_detalle_cumplimiento_id_detalle_cumplimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tabla_detalle_cumplimiento_id_detalle_cumplimiento_seq OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 229
-- Name: tabla_detalle_cumplimiento_id_detalle_cumplimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER SEQUENCE public.tabla_detalle_cumplimiento_id_detalle_cumplimiento_seq OWNED BY public.detalle_cumplimiento.id_detalle_cumplimiento;


--
-- TOC entry 223 (class 1259 OID 16746)
-- Name: tabla_homologacion_id_homologacion_seq; Type: SEQUENCE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE SEQUENCE public.tabla_homologacion_id_homologacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tabla_homologacion_id_homologacion_seq OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 223
-- Name: tabla_homologacion_id_homologacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER SEQUENCE public.tabla_homologacion_id_homologacion_seq OWNED BY public.homologacion.id_homologacion;


--
-- TOC entry 217 (class 1259 OID 16705)
-- Name: tabla_norma_id_norma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tabla_norma_id_norma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tabla_norma_id_norma_seq OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 217
-- Name: tabla_norma_id_norma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER SEQUENCE public.tabla_norma_id_norma_seq OWNED BY public.norma.id_norma;


--
-- TOC entry 231 (class 1259 OID 16807)
-- Name: tabla_reuc_id_reuc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tabla_reuc_id_reuc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tabla_reuc_id_reuc_seq OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 231
-- Name: tabla_reuc_id_reuc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER SEQUENCE public.tabla_reuc_id_reuc_seq OWNED BY public.reuc.id_reuc;


--
-- TOC entry 219 (class 1259 OID 16714)
-- Name: tabla_sub_norma_id_sub_norma_seq; Type: SEQUENCE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE SEQUENCE public.tabla_sub_norma_id_sub_norma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tabla_sub_norma_id_sub_norma_seq OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 219
-- Name: tabla_sub_norma_id_sub_norma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER SEQUENCE public.tabla_sub_norma_id_sub_norma_seq OWNED BY public.sub_norma.id_sub_norma;


--
-- TOC entry 226 (class 1259 OID 16761)
-- Name: tipo_cumplimiento; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.tipo_cumplimiento (
    id_tipo_cumplimiento integer NOT NULL,
    nombre text
);


ALTER TABLE public.tipo_cumplimiento OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 225 (class 1259 OID 16760)
-- Name: tabla_tipo_cumplimiento_id_tipo_cumplimiento_seq; Type: SEQUENCE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE SEQUENCE public.tabla_tipo_cumplimiento_id_tipo_cumplimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tabla_tipo_cumplimiento_id_tipo_cumplimiento_seq OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 225
-- Name: tabla_tipo_cumplimiento_id_tipo_cumplimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER SEQUENCE public.tabla_tipo_cumplimiento_id_tipo_cumplimiento_seq OWNED BY public.tipo_cumplimiento.id_tipo_cumplimiento;


--
-- TOC entry 235 (class 1259 OID 24617)
-- Name: tipo_evento_seg; Type: TABLE; Schema: public; Owner: owner_cumplimiento_dev
--

CREATE TABLE public.tipo_evento_seg (
    id_tipo_evento_seg integer NOT NULL,
    estado character varying,
    descripcion character varying
);


ALTER TABLE public.tipo_evento_seg OWNER TO owner_cumplimiento_dev;

--
-- TOC entry 3262 (class 2604 OID 16773)
-- Name: cumplimiento id_cumplimiento; Type: DEFAULT; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER TABLE ONLY public.cumplimiento ALTER COLUMN id_cumplimiento SET DEFAULT nextval('public.tabla_cumplimiento_id_cumplimiento_seq'::regclass);


--
-- TOC entry 3259 (class 2604 OID 16732)
-- Name: departamento id_departamento; Type: DEFAULT; Schema: public; Owner: owner_cumplimiento_dev
--

ALTER TABLE ONLY public.departamento ALTER COLUMN id_departamento SET DEFAULT nextval('public.tabla_departamento_id_departamento_seq'::regclass);


--
-- TOC entry 3263 (class 2604 OID 16792)
-- Name: detalle_cumplimiento id_detalle_cumplimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cumplimiento ALTER COLUMN id_detalle_cumplimiento SET DEFAULT nextval('public.tabla_detalle_cumplimiento_id_detalle_cumplimiento_seq'::regclass);


--
-- TOC entry 3260 (class 2604 OID 16750)
-- Name: homologacion id_homologacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homologacion ALTER COLUMN id_homologacion SET DEFAULT nextval('public.tabla_homologacion_id_homologacion_seq'::regclass);


--
-- TOC entry 3257 (class 2604 OID 16709)
-- Name: norma id_norma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.norma ALTER COLUMN id_norma SET DEFAULT nextval('public.tabla_norma_id_norma_seq'::regclass);


--
-- TOC entry 3264 (class 2604 OID 16811)
-- Name: reuc id_reuc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reuc ALTER COLUMN id_reuc SET DEFAULT nextval('public.tabla_reuc_id_reuc_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 16718)
-- Name: sub_norma id_sub_norma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_norma ALTER COLUMN id_sub_norma SET DEFAULT nextval('public.tabla_sub_norma_id_sub_norma_seq'::regclass);


--
-- TOC entry 3261 (class 2604 OID 16764)
-- Name: tipo_cumplimiento id_tipo_cumplimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cumplimiento ALTER COLUMN id_tipo_cumplimiento SET DEFAULT nextval('public.tabla_tipo_cumplimiento_id_tipo_cumplimiento_seq'::regclass);


--
-- TOC entry 3458 (class 0 OID 24592)
-- Dependencies: 233
-- Data for Name: carta_incpmt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3459 (class 0 OID 24610)
-- Dependencies: 234
-- Data for Name: carta_incpmt_seg; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3453 (class 0 OID 16770)
-- Dependencies: 228
-- Data for Name: cumplimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cumplimiento VALUES (1, 1, 1, NULL, 'NO CUMPLE', 267, '5', '23062025', '2025', NULL);
INSERT INTO public.cumplimiento VALUES (2, 1, 1, NULL, 'CUMPLE', 212, '5', '23062025', '2025', NULL);
INSERT INTO public.cumplimiento VALUES (3, 17, 1, NULL, 'NO CUMPLE', 714, '5', '23062025', '2025', NULL);
INSERT INTO public.cumplimiento VALUES (4, 17, 1, NULL, 'NO CUMPLE', 671, '5', '23062025', '2025', NULL);
INSERT INTO public.cumplimiento VALUES (5, 17, 1, NULL, 'NO CUMPLE', 412, '5', '23062025', '2025', NULL);
INSERT INTO public.cumplimiento VALUES (6, 17, 1, NULL, 'NO CUMPLE', 267, '5', '23062025', '2025', NULL);
INSERT INTO public.cumplimiento VALUES (7, 3, 1, NULL, 'CUMPLE', 149, '5', '23062025', '2025', NULL);
INSERT INTO public.cumplimiento VALUES (8, 3, 1, NULL, 'CUMPLE', 149, '5', '23062025', '2025', NULL);


--
-- TOC entry 3447 (class 0 OID 16729)
-- Dependencies: 222
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departamento VALUES (1, 'Departamento Scada y SITR', 'Víctor Reyes', 'Gerardo Cárdenas');
INSERT INTO public.departamento VALUES (2, 'Departamento de Confiabilidad y Soporte Técnico', 'Felipe Antinao', 'Alberto Triguero');
INSERT INTO public.departamento VALUES (3, 'Departamento de Confiabilidad y Soporte Técnico', 'Felipe Antinao', 'Felipe Neira');
INSERT INTO public.departamento VALUES (4, 'Departamento de Modelación y Aplicaciones EMS', 'Jorge Vargas', 'Joaquín Mesías  / Gabriela Sáez');
INSERT INTO public.departamento VALUES (5, 'Departamento Estudios Eléctricos', 'Eugenio Quintana', 'Eugenio Quintana');
INSERT INTO public.departamento VALUES (6, 'Departamento de Activos e Información Técnica', 'Víctor Alvarez', 'Yozu Cataldo / Juan Quezada');
INSERT INTO public.departamento VALUES (7, 'Departamento de Transferencias de Potencia y Cargos de Transmisión', 'Manuel Gatica', 'Manuel Gatica');
INSERT INTO public.departamento VALUES (8, 'Departamento de Medición de Energía', 'Tomas Valenzuela', 'Juan Soto');


--
-- TOC entry 3455 (class 0 OID 16789)
-- Dependencies: 230
-- Data for Name: detalle_cumplimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.detalle_cumplimiento VALUES (1, '99.38459730987977', 'CUMPLE', 1, 'AELA EÓLICA SARCO SPA');
INSERT INTO public.detalle_cumplimiento VALUES (2, '98.188248373822', 'CUMPLE', 1, 'LICÁN SPA');
INSERT INTO public.detalle_cumplimiento VALUES (3, '96.24320939672694', 'CUMPLE', 1, 'AELA EÓLICA LLANQUIHUE SPA');
INSERT INTO public.detalle_cumplimiento VALUES (4, '93.31185284747109', 'NO CUMPLE', 1, 'AELA EÓLICA NEGRETE SPA');
INSERT INTO public.detalle_cumplimiento VALUES (5, '89.89340577927702', 'NO CUMPLE', 1, 'SAN ANDRÉS SPA');
INSERT INTO public.detalle_cumplimiento VALUES (6, '82.014744911546', 'NO CUMPLE', 1, 'AELA GENERACIÓN S.A.');
INSERT INTO public.detalle_cumplimiento VALUES (7, '100', 'CUMPLE', 2, 'WPD NEGRETE SPA');
INSERT INTO public.detalle_cumplimiento VALUES (8, 'J1', 'NO CUMPLE', 3, 'Ana María S.A.');
INSERT INTO public.detalle_cumplimiento VALUES (9, 'J3', 'NO CUMPLE', 3, 'Ana María S.A.');
INSERT INTO public.detalle_cumplimiento VALUES (10, 'J4', 'NO CUMPLE', 3, 'Ana María S.A.');
INSERT INTO public.detalle_cumplimiento VALUES (11, 'J6', 'NO CUMPLE', 3, 'Ana María S.A.');
INSERT INTO public.detalle_cumplimiento VALUES (12, 'J9', 'NO CUMPLE', 3, 'Ana María S.A.');
INSERT INTO public.detalle_cumplimiento VALUES (13, 'SSAA', 'NO CUMPLE', 3, 'Ana María S.A.');
INSERT INTO public.detalle_cumplimiento VALUES (14, 'PMGD1', 'NO CUMPLE', 4, 'Ailin Fotovoltaica SpA');
INSERT INTO public.detalle_cumplimiento VALUES (15, 'PMGD2', 'NO CUMPLE', 5, 'Alto Cautín');
INSERT INTO public.detalle_cumplimiento VALUES (16, 'PMGD5', 'NO CUMPLE', 5, 'Alto Cautín');
INSERT INTO public.detalle_cumplimiento VALUES (17, 'E1', 'NO CUMPLE', 6, 'Aela Generación');
INSERT INTO public.detalle_cumplimiento VALUES (18, '52', 'CUMPLE', 7, 'Alfalfal');
INSERT INTO public.detalle_cumplimiento VALUES (19, '52', 'CUMPLE', 7, 'Campiche');
INSERT INTO public.detalle_cumplimiento VALUES (20, '52', 'CUMPLE', 7, 'Laguna Verde');
INSERT INTO public.detalle_cumplimiento VALUES (21, '52', 'CUMPLE', 7, 'Laja E.V.');
INSERT INTO public.detalle_cumplimiento VALUES (22, '52', 'CUMPLE', 7, 'Maitenes');
INSERT INTO public.detalle_cumplimiento VALUES (23, '52', 'CUMPLE', 7, 'Nueva Ventanas');
INSERT INTO public.detalle_cumplimiento VALUES (24, '52', 'CUMPLE', 7, 'Queltehues');
INSERT INTO public.detalle_cumplimiento VALUES (25, '52', 'CUMPLE', 7, 'Trueno');
INSERT INTO public.detalle_cumplimiento VALUES (26, '52', 'CUMPLE', 7, 'Ventanas 1-2');
INSERT INTO public.detalle_cumplimiento VALUES (27, '52', 'CUMPLE', 7, 'Los Olmos');
INSERT INTO public.detalle_cumplimiento VALUES (28, '52', 'CUMPLE', 7, 'Mesamávida');
INSERT INTO public.detalle_cumplimiento VALUES (29, '52', 'CUMPLE', 7, 'Campo Lindo ');
INSERT INTO public.detalle_cumplimiento VALUES (30, '52', 'CUMPLE', 7, 'San Matias y Volcán');
INSERT INTO public.detalle_cumplimiento VALUES (31, '53', 'CUMPLE', 8, 'Angamos 1 y 2');
INSERT INTO public.detalle_cumplimiento VALUES (32, '53', 'CUMPLE', 8, 'Cochrane 1 y 2');
INSERT INTO public.detalle_cumplimiento VALUES (33, '53', 'CUMPLE', 8, 'Norgener 1 y 2');
INSERT INTO public.detalle_cumplimiento VALUES (34, '53', 'CUMPLE', 8, 'Andes Solar');
INSERT INTO public.detalle_cumplimiento VALUES (35, '53', 'CUMPLE', 8, 'PFV Bolero');
INSERT INTO public.detalle_cumplimiento VALUES (36, '53', 'CUMPLE', 8, 'PE Los Cururos');


--
-- TOC entry 3449 (class 0 OID 16747)
-- Dependencies: 224
-- Data for Name: homologacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.homologacion VALUES (1, 1, 'AELA EOLICA SARCO', '76.644.111-4', '76.489.426-K');
INSERT INTO public.homologacion VALUES (2, 1, 'ELECTRICA LICAN', '76.375.780-3', '76.489.426-K');
INSERT INTO public.homologacion VALUES (3, 1, 'AM EOLICA LLANQUIHUE', '76.296.433-3', '76.489.426-K');
INSERT INTO public.homologacion VALUES (4, 1, 'EOLICA NEGRETE', '76.120.744-K', '76.489.426-K');
INSERT INTO public.homologacion VALUES (5, 1, 'SAN ANDRES SPA', '76.273.569-5', '76.489.426-K');
INSERT INTO public.homologacion VALUES (6, 1, 'AELA GENERACION SA', '76.489.426-K', '76.489.426-K');
INSERT INTO public.homologacion VALUES (7, 1, 'WPD NEGRETE SPA', '76.311.926-2', '76.311.926-2');
INSERT INTO public.homologacion VALUES (8, 17, 'Ana María S.A.', '77.677.302-6', '77.677.302-6');
INSERT INTO public.homologacion VALUES (9, 17, 'Ailin Fotovoltaica SpA', '77.018.069-4', '77.018.069-4');
INSERT INTO public.homologacion VALUES (10, 17, 'Alto Cautín', '76.044.129-5', '76.044.129-5');
INSERT INTO public.homologacion VALUES (11, 17, 'Aela Generación', '76.489.426-K', '76.489.426-K');
INSERT INTO public.homologacion VALUES (12, 3, 'Alfalfal', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (13, 3, 'Campiche', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (14, 3, 'Laguna Verde', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (15, 3, 'Laja E.V.', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (16, 3, 'Maitenes', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (17, 3, 'Nueva Ventanas', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (18, 3, 'Queltehues', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (19, 3, 'Trueno', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (20, 3, 'Ventanas 1-2', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (21, 3, 'Los Olmos', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (22, 3, 'Mesamávida', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (23, 3, 'Campo Lindo ', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (24, 3, 'San Matias y Volcán', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (25, 3, 'Angamos 1 y 2', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (26, 3, 'Cochrane 1 y 2', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (27, 3, 'Norgener 1 y 2', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (28, 3, 'Andes Solar', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (29, 3, 'PFV Bolero', NULL, '94.272.000-9');
INSERT INTO public.homologacion VALUES (30, 3, 'PE Los Cururos', NULL, '94.272.000-9');


--
-- TOC entry 3443 (class 0 OID 16706)
-- Dependencies: 218
-- Data for Name: norma; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.norma VALUES (1, NULL, 'De acuerdo con lo establecido en el Artículo 1-14 de la Norma Técnica de Seguridad y Calidad de Servicio (NTSyCS), el Coordinador Eléctrico Nacional debe informar dentro del primer trimestre de cada año a la SEC el grado de cumplimiento de cada coordinado del  sistema Eléctrico Nacional, razón por la cual se emite este Informe Anual de Cumplimiento.', '1.14', 'NTSyCS');


--
-- TOC entry 3457 (class 0 OID 16808)
-- Dependencies: 232
-- Data for Name: reuc; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reuc VALUES (1, 'Masisa', '96.802.690-9', '', '7550159.0', 'Roberto Salas', 'roberto.salas@masisa.com', '56223506110', 'Apoquindo 3650, P 10 Las Condes  Las Condes - Chile', 'Las Condes', 'Luis Quiroga', 'Masisa S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (2, 'Agrícola Lágrimas del Sur SpA (Ex Agricola Ponce)', '76.738.520-K', 'Coordinado de PMGD HP LOS CORRALES desde el 1 de abril de 2023.', '8320330.0', 'Carlos Valenzuela Pérez', 'carlosvalenzuela@distvalenzuela.cl', '56990206553', 'Fundo Los Zanjones S/N Osorno', 'Osorno', 'Matías Alejandro Burton Hormazabal', 'Lágrimas del Sur SpA', 'PMGD');
INSERT INTO public.reuc VALUES (3, 'Los Espinos (Fusión con Mainco SpA)', '76.925.800-0', '', '7500007.0', 'Tomas Schroter', 'tomas.schroter@potenciachile.cl', '56223554900', 'Monseñor Sotero Sanz 267', 'Providencia', 'Octavio Ramirez', 'Espinos S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (4, 'Transchile', '76.311.940-8', '', '7550099.0', 'Felipe Riquelme', 'friquelme@ferrovial.com', '56225606236', 'Av APoquindo 4700, Piso 13', 'Las Condes', 'Felipe Riquelme', 'Transchile Charrúa Transmisión  S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (5, 'Petroquim', '78.021.560-7', '', '', 'Jorge Rodolfo Garcia Rodriguez', 'jgarcia@petroquim.cl', '56223516700', 'Hernando de Aguirre 268, 4to. piso, Providencia', 'Providencia', 'Sergio Raul Reyes  Romero', 'Petroquim S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (6, 'Luzparral', '96.866.680-0', '', '', 'Francisco Solis Ganga', 'fsolisg@luzlinares.cl', '56732634004', 'Chacabuco 675, Linares', 'Lineares', 'Jorge Antonio Valladares Muñoz', 'Luzparral S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (7, 'Eléctrica Caren', '76.149.809-6', '', '', 'Esteban Moraga', 'esteban.moraga@latampower.com', '56228203200', 'Cerro El Plomo 5680 Ofc 1202', 'Las Condes', 'Fernando Llaitul', 'Empresa Eléctrica Carén S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (8, 'Amanecer Solar', '76.273.559-8', '', '7550104.0', 'Héctor Mauricio Roche Galdames', 'hector.roche@sunedison.com', '56225947460', 'Av. El Golf 40, Piso 12, Las Condes, Santiago,  CP 7550107', 'Las Condes', 'Guillermo Diego Loli Huaraca', 'Amanecer Solar SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (9, 'Las Pampas', '76.254.294-3', '', '7550173.0', 'Mauro Angel Aranda', 'mangel@biog.cl', '56932481403', 'Cerro El Plomo 5630, Of 1304', 'Las Condes', 'Bastián Osorio González', 'Bio Energía Las Pampas SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (10, 'Gas Sur', '96.853.490-4', '', '', 'Javier Eduardo Roa de la Carrera', 'jroa@gassur.cl', '56412660990', 'Avenida Gran Bretaña 5691', 'Talcahuano', 'Carlos Victoriano Román Olave', 'Gas Sur S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (11, 'CAP Huachipato', '94.637.000-2', '', '4271542.0', 'Ernesto Escobar Elissetche ', 'ernesto.escobar@csh.cl', '56412502203', 'Av. Gran Bretaña 2910', 'Talcahuano', 'Esteban Matamala', 'Compañía Siderurgica Huachipato S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (12, 'EDECSA', '96.766.110-4', '', '2480000.0', 'Cristian Candia', 'ccandia@litoral.cl', '56352205003', 'Avda. Peñablanca 540, Algarrobo', 'Algarrobo', 'Felipe Aravena Cofre', 'Energía de Casablanca S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (13, 'Nueva Degan', '76.265.287-0', '', '7560742.0', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Generación de Energía Nueva Degan SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (14, 'Cristalchile', '90.331.000-6', '', '', 'Eduardo Carvallo Infante', 'ecarvallo@cristalchile.cl', '56227878591', 'José Luis Caro 501', 'Padre Hurtado', 'Felipe Morales', 'Cristalerías de Chile S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (15, 'Minera Tres Valles', '77.856.200-6', '', '7561211.0', 'Gilberto Schubert De Oliveira ', 'gilberto.schubert@mineratresvalles.cl', '56442081010', 'Avenida Apoquindo 4775, Of. 501, Las Condes', 'Las Condes', 'Jaime Veas Lopez ', 'Sociedad Contractual Minera Tres Valles', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (16, 'Dosal', '84.992.400-1', '', '1000000.0', 'Andrés Calvo', 'acalvo@dosal.cl', '56752310034', 'Huerto Mercedes Carolina s/n Tutuquén', 'Curicó', 'Nelson Arenas ', 'Dosal hnos y Cia Ltda', 'PMGD');
INSERT INTO public.reuc VALUES (17, 'Bioenergías Forestales', '76.188.197-3', '', '8340432.0', 'Enrique Donoso', 'enrique.donoso@cmpc.cl', '56224412051', 'Agustinas 1343, Piso 4', 'Santiago', 'Sergio Zamora Ramírez', 'Bioenergías Forestales SpA', 'Transmisor Dedicado,Cliente Libre,Transmisor Zonal,PMG,Generador');
INSERT INTO public.reuc VALUES (18, 'Inchalam', '91.868.000-4', '', '', 'Enrique Gajardo Lagos ', 'enrique.gajardo@inchalam.cl', '56412267600', 'Avda. Gran Bretaña 2675 Talcahuano', 'Talcahuano', 'Luis Ricardo Contzen Rigo-Righi', 'Industria Chilena de Alambre S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (19, 'Luz Osorno', '96.531.500-4', '', '310318.0', 'Francisco Alliende A.', 'rodrigo@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Kandinsky Dintrans Perez', 'Compañía Eléctrica de Osorno S.A', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (20, 'CAP CMP', '94.638.000-8', '', '', 'Francisco Carvajal P.', 'fcarvajal@cmp.cl', '56993194327', '', '', 'Rodrigo Barrueto Díaz', 'Compañía Minera del Pacífico S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (21, 'Generadora Roblería', '76.051.263-K', '', '', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'Hidroeléctrica Robleria SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (22, 'Moly-Cop', '92.244.000-K', '', '4271543.0', 'Gustavo Alcazar Mendez', 'intercambio_empresas@molycop.cl', '56992232784', 'Avenida gran Bretaña 2075 Talcahuano', 'Talcahuano', 'CARLOS ABARZUA', 'Moly-Cop Chile S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (23, 'Copelec', '80.237.700-2', '', '3800750.0', 'José Patricio Lagos Cisterna', 'plagos@copelec.cl', '56422204412', '18 de Septiembre 688, Chillán', 'Chillán', 'Iván Fuentealba Carrasco', 'Cooperativa de Consumo de Energía Eléctrica Chillán Ltda.', 'Transmisor Zonal,Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (24, 'Minera Mantos de Oro', '78.928.380-K', '', '', 'Rodrigo Gomides', 'rodrigo.gomides@kinross.com', '56522523329', 'Los Carrera 6651, Paipote', '', 'Leonardo Ramirez', 'CIA. Minera Mantos de Oro', 'Cliente Libre');
INSERT INTO public.reuc VALUES (25, 'Enel Distribución (Fusión con Luz Andes)', '96.800.570-7', '', '8330099.0', 'Victor Tavera Olivos', 'victor.tavera@enel.com', '56992366444', 'Roger de Flor 2725, Torre Encomenderos', 'Las Condes', 'Francisco Messen Rebolledo', 'Enel Distribución Chile S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (26, 'Parque fotovoltaico Quilapilún', '76.414.107-5', '', '', 'Luis Alfredo Solar Pinedo ', 'asolar@atlasren.com', '56226118300', 'Apoquindo 3472, piso 9', 'Las Condes', 'Tomás Ávila Araya', 'Chungungo S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (27, 'Fusión con Empresa Eléctrica ERNC I S.A.', '76.284.682-9', '', '550049.0', 'Jaime Pino', 'jpino@innergex.com', '56223787970', 'Isidora Goyenechea 3477, Of. 211, Piso 21', 'Las Condes', 'Carlos De la Fuente', 'PV Salvador S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (28, 'Aguas del Melado', '77.277.800-7', '', '7550594.0', 'Paulo Bezanilla Saavedra ', 'op.energia@besalco.cl', '56223312200', 'Av. Tajamar N°183, oficina 301, Las Condes', '', 'Jonathan Cardenas Parra', 'Empresa Eléctricas Aguas del Melado SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (29, 'Ucuquer Dos', '76.319.372-1', '', '', 'Luis Ljubetic', 'lljubetic@coener.cl', '56988998449', 'Av. Vitacura 5093, of. 510', 'Vitacura', 'Luis Ljubetic', 'Energías Ucuquer Dos S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (30, 'Alba', '76.114.239-9', '', '7560742.0', 'Rosaline Corinthien', 'nora.calas@engie.com', '56223533200', 'Isidora Goyenechea 2800, piso 16', 'Las Condes', 'Pablo Jorquera Riquelme', 'Alba SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (31, 'Parque Eólico Los Cururos', '76.178.599-0', '', '7630454.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Parque Eólico Los Cururos SpA', 'Generador');
INSERT INTO public.reuc VALUES (32, 'Renovalia Chile Seis SpA', '76.327.569-8', '', '7561160.0', 'Santiago Rull Cullen', 'chapeana@disagrupo.es', '34922238700', 'Cerro el Plomo 5420 oficina 903', 'Las Condes', 'Joaquín Gurriarán Florido', 'Las Mollacas SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (33, 'Minera Maricunga', '76.038.806-8', '', '1535418.0', 'Alberto Opazo', 'alberto.opazo@kinross.com', '56522528000', 'Los Carreras 6651, Copiapó.', 'Copiapó', 'Marcelo Amaya', 'Compañía Minera Maricunga', 'Cliente Libre');
INSERT INTO public.reuc VALUES (34, 'EKA Chile', '99.500.140-3', '', '4290310.0', 'Isaac Morend Deresinsky', 'isaac.morend@akzonobel.com', '56412129256', 'Av. Rocoto 2911 Sector Industrial', 'Talcahuano', 'Angelo Adrian Lagos Cifuentes', 'EKA CHILE S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (35, 'Acciona Energía Chile', '76.437.712-5', '', '7580575.0', 'Jaime Toledo Ruiz', 'jatoledor@acciona.com', '56226308319', 'Av. Santa Rosa 76, Piso 11', 'Santiago', 'Javier Toro Cabrera', 'Acciona Energía Chile Holdings S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (36, 'Barrick Generación', '96.576.920-K', '', '7510125.0', 'Gonzalo Montes Astaburuaga', 'gomontes@barrick.com', '56223402022', 'Avenida Ricardo Lyon N°222, Piso 9', 'Providencia', 'Guillermo Bolados', 'Compañía Barrick Chile Generación SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (37, 'CELMSA', '95.177.000-0', '', '7560742.0', 'Raul Alamos Letelier ', 'ralamos@carenpa.cl', '56225942400', 'Cerro El Plomo 5630', 'Las Condes', 'Luis Soto Nuñez', 'CIA Eléctrica los Morros S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (38, 'Minera Lumina Copper', '99.531.960-8', '', '8720046.0', 'Nelson Pizarro Contador ', 'comunicaciones@caserones.cl', '56224322500', 'Andrés Bello 2687 Piso 4', 'Las Condes', 'Ricardo Alexis Ocaranza León', 'Compañía SCM Minera Lumina Copper Chile', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (39, 'Emelca', '81.577.400-0', '', '2480000.0', 'Luis Eduardo Silva Chavez', 'e.silva@emelca.cl', '56322741445', 'Avenida Diego Portales 351, of. Nº 9', 'Casablanca', 'Alexis Astudillo', 'Empresa Eléctrica de Casablanca S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (40, 'Central Yungay (ex Orazul Energy Chile Holding II B.V. S.C.P.A.)', '76.060.441-0', '', '', 'Victoria Salinas', 'victoria.salinas@inkiaenergy.com', '56228207100', 'Cerro el Plomo 5680, Of 1501', 'Las Condes', 'Javier Pujol', 'Central Yungay S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (41, 'PSF Lomas Coloradas', '76.284.911-9', '', '7510574.0', 'Alfonso Izquierdo Irarrázaval', 'aizquierdo@menchaca.cl', '56223902200', 'Mar del Plata 2111, Providencia, Santiago, Chile', 'Providencia', 'Luis Ljubetic', 'PSF Lomas Coloradas S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (42, 'Transelec', '76.555.400-4', '', '7560970.0', 'Arturo Le Blanc Cerda', 'aleblanc@transelec.cl', '56224677001', 'Orinoco 90, piso 14', 'Las Condes', 'María José Reveco', 'Transelec S.A.', 'Transmisor Nacional,Transmisor Zonal');
INSERT INTO public.reuc VALUES (43, 'Minera Candelaria', '85.272.800-0', '', '7550000.0', 'Juan Carlos Pino Escobar', 'juan.pino@lundinmining.com', '56522461074', 'Avda. El Bosque Norte #500, Oficina 1102, Santiago', 'Las Condes', 'Victor Chaura Pérez', 'Compañía Contractual Minera Candelaria', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (44, 'Pacific Hydro', '96.990.040-8', '', '7550071.0', 'Renzo Valentino', 'rvalentino@pacifichydro.cl', '56225194200', 'Av. Isidora Goyenechea 3520 piso 10', 'Las Condes', 'Luis Osvaldo Nuñez Herrera', 'Pacific Hydro Chile S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (45, 'Puntilla', '96.817.230-1', '', '7560970.0', 'Alejandro Gómez Vidal', 'agomez@scmaipo.cl', '56225922300', 'ORINOCO 90, PISO 11', 'Las Condes', 'Karen Beltran Cerda', 'Eléctrica Puntilla S.A.', 'PMGD,Transmisor Zonal,Generador,PMG');
INSERT INTO public.reuc VALUES (46, 'Hidroeléctrica Allipén', '76.071.891-2', '', '1000000.0', 'Tomas Fahrenkrog', 'tfahrenkrog@gpe.cl', '56229168200', 'Félix de Amesti 90. Oficina 201', 'Las Condes', 'María Luisa Orellana', 'Hidroelectrica Allipén S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (47, 'SOCOEPA', '81.629.800-8', '', '5230000.0', 'Jorge Vergara Parra ', 'cooperativa@socoepa.cl', '56632421356', 'Av. Pérez Rosales 1167', 'Paillaco', 'Luis Candia Aguilar', 'Cooperativa Eléctrica Paillaco Ltda', 'Transmisor Zonal,Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (48, 'Cemento Bío Bío del Sur', '96.755.490-1', '', '4271543.0', 'Guido Efrens sepulveda Navarro', 'guido.sepulveda@cbb.cl', '56995383336', 'Avenida Grand Bretaña 1725', '', 'Jaime Valdes Leiva', 'Cementos Bío Bío del Sur S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (49, 'GNL Quintero', '76.788.080-4', '', '', 'Antonio Bacigalupo ', 'sebastian.russi@gnlquintero.cl', '56224990900', 'Rosario Norte 532, Oficina 1604', 'Las Condes', 'Alejandro Amorin Torres', 'GNL Quintero S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (50, 'PMGD Bureo', '76.219.874-6', '', '7510054.0', 'Juan León Obrecht', 'jlo@agrosonda.cl', '56223765202', 'Carretera General San Martin 16.500 15A', 'Colina', 'Juan León Obrecht', 'PMGD Bio Bio Negrete S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (51, 'Los Guindos', '76.284.294-7', '', '', 'Rene Fernandez Weisser ', 'rene.fernandez@losguindosgeneracion.cl', '56225711500', 'Av. Del Parque 4161 Piso 2, Ciudad Empresarial, Huechuraba', 'Huechuraba', 'Gabriel Flores', 'Los Guindos Generación SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (52, 'HESA', '76.030.971-0', '', '1000000.0', 'Ivonne Bell Rodríguez', 'ibell@hidrolena.cl', '56222282859', 'Málaga 115, of. 709', 'Las Condes', 'Ivonne Bell Rodríguez', 'Hidroeléctrica Ensenada S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (53, 'Hidroeléctrica La Arena', '76.037.036-3', '', '1000001.0', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Empresa Eléctrica La Arena SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (54, 'S.W. Operations', '76.131.355-K', '', '8340425.0', 'RODRIGO DANÚS', 'plarenas@swc.cl', '56225891900', 'Alonso de Córdova 3827, Piso 8', 'Vitacura', 'Rodrigo Danus Laucirica', 'S.W. Operations S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (55, 'Hidroeléctrica Rio Huasco', '76.071.113-6', '', '1000000.0', 'Tomas Fahrenkrog', 'tfahrenkrog@gpe.cl', '56229168200', 'Félix de Amesti 90. Oficina 201', 'Las Condes', 'María Luisa Orellana', 'Hidroeléctrica Río Huasco S.A.', 'Transmisor Dedicado,Generador,PMG');
INSERT INTO public.reuc VALUES (56, 'Minera Los Pelambres', '96.790.240-3', '', '', 'Alejandro Vasquez Montero', 'avasquez@pelambres.cl', '56958114785', 'Apoquindo 4001', 'Las Condes', 'Hermógenes Zepeda', 'Minera Los Pelambres', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (57, 'Cemento Bio Bio Centro', '96.718.010-6', 'Cambio de razón social según Diario Oficial Núm. 44.040.', '1000000.0', 'German Blumel Araya ', 'german.blumel@cbb.cl', '56412267000', 'Av. Gran Bretaña 1725', 'Talcahuano', 'Jaime Valdes Leiva', 'Cbb Cales S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (58, 'Minera Altos de Punitaqui', '76.099.463-4', '', '1900000.0', 'Lautaro Manriquez ', 'lautaro.manriquez@altospunitaqui.cl', '56532424900', 'Miguel Aguirre 280 Of. 47, Ovalle', 'Punitaqui', 'Luis Antonio Olivares Garcia', 'Minera Altos de Punitaqui Ltda', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (59, 'Minera Las Cenizas', '79.963.260-8', '', '', 'Cristian Argandoña', 'cristian.argandona@cenizas.cl', '56223688336', 'Apoquindo 3885, Piso 14', 'Las Condes', 'Gustavo Cortes', 'Minera Las Cenizas S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (60, 'OXY', '93.797.000-5', '', '7510078.0', 'Mario Coddou Göring ', 'mario_coddou@oxy.com', '56227185000', 'Nueva de Lyon N° 072, Piso N°10', 'Providencia', 'Gigio Isola', 'Occidental Chemical Chile Ltda.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (61, 'Kaltemp', '76.392.163-8', '', '', 'Antonio Boetsch ', 'antonio@boetek.cl', '56228621700', 'Av. El Rosal 4571', 'Huechuraba', 'Antonio Boetsch ', 'Generadora Eléctrica Kaltemp Ltda.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (62, 'Commonplace', '76.233.264-7', '', '7570441.0', 'Gabriela Sommerfeld Rosero', 'gabi.sommerfeld@coolbrand.com.ec', '', 'Martín de Zamora 6101. Of. 1, Las Condes, Santiago', '', 'Luis Ljubetic', 'Commonplace Energy SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (63, 'CEC', '70.287.900-0', '', '3342913.0', 'Luis Alejandro Toledo Moreno', 'alejandro.toledo@gencec.cl', '56752310389', 'Avda. Camilo Henríquez 153', 'Curicó', 'Kadir Andres Ruiz Novoa', 'Cooperativa de Abastecimiento de Energía Eléctrica Curico LTDA.', 'Distribuidoras (Concesionarias de Distribución),Transmisor Zonal');
INSERT INTO public.reuc VALUES (64, 'Eléctrica Colina', '96.783.910-8', '', '', 'Luis Fernando Roa Vargas', 'luis.roa@enel.com', '56971389477', 'Chacabuco 31', 'Colina', 'Jorge Ossandon', 'Empresa Eléctrica de Colina Ltda.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (65, 'Representa a: Esperanza, Zofri y Estandartes', '96.774.300-3', '', '', 'Fernando Ávalos', 'favalos@enorchile.cl', '56224102544', 'Av. Santa María 2120', 'Providencia', 'Fernando Ávalos', 'Enorchile S.A.', 'PMGD,Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (66, 'Eletrans S.A.', '76.230.505-4', '', '', 'Álvaro Arturo Alarcón Molina', 'aalarcom@eletrans.cl', '56939140144', 'Av. Argentina N° 1', 'Valparaíso', 'Álvaro Arturo Alarcón Molina', 'Eletrans S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (67, 'Palmucho', '76.406.120-9', '', '7550188.0', 'Juan Carlos Albala', 'juan.albala@atlantica.com', '34618919091', 'Camino el Alba 9500, Torre B, 406', 'Santiago', 'Juan Carlos Albala', 'Palmucho S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (68, 'Hidropaloma', '76.849.580-7', '', '1000000.0', 'Enrico Gatti Sani ', 'enrico.gatti@scotta.cl', '56232027360', 'Vitacura 2969 Of. 901 Las Condes', '', 'Carlos Alejandro Galaz Springer', 'Hidropaloma S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (69, 'Litoral', '91.344.000-5', '', '2710000.0', 'Cristian Candia', 'ccandia@chilquintadx.cl', '56352205003', 'Avda. Peñablanca 540, Algarrobo', 'Algarrobo', 'Felipe Aravena Cofre', 'Compañía Eléctrica del Litoral S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (70, 'Punta Palmeras', '76.106.835-0', '', '7580575.0', 'Jaime Toledo Ruiz', 'jatoledor@acciona.com', '56226308319', 'Av. Santa Rosa 76, Piso 11', 'Santiago', 'Javier Toro Cabrera', 'Punta Palmeras S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (71, 'Cemento Melón', '76.109.779-2', '', '', 'Ivan Marinado Felipos', 'ivan.marinado@melon.cl', '56222800450', 'Isidora Goyenechea 2800, piso 13, Las condes, Santiago, Chile.', 'Las Condes', 'Helmut Brandau', 'Melon S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (72, 'Pehuenche', '96.504.980-0', '', '', 'Carlos Ivan Peña Garay,', 'carlos.penag@enel.com', '56226309000', 'Santa Rosa 76, Santiago Centro.', 'Santiago', 'Miguel Buzunariz Ramos', 'Empresa Eléctrica Pehuenche S.A.', 'Generador,Transmisor Zonal,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (73, 'Biocruz Generación', '76.171.705-7', '', '7591047.0', 'Jose Manuel Carvallo Munita', 'jcarvallo@hbsenergia.cl', '56222157731', 'Estoril 50 Oficina 601, Las Condes', 'Las Condes', 'Jose Manuel Carvallo Munita', 'Biocruz Generación S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (74, 'Metro', '61.219.000-3', '', '8330181.0', 'Felipe Bravo', 'fbravo@metro.cl', '56229372000', 'Avenida Libertador Bernardo O''Higgins 1414', 'Santiago', 'Daniel Lillo Opazo', 'Empresa de Transporte de Pasajeros Metro S.A.', 'Cliente Libre,Transmisor Zonal');
INSERT INTO public.reuc VALUES (75, 'Hidroeléctrica Mallarauco', '76.055.136-8', '', '1000000.0', 'Tomas Fahrenkrog', 'tfahrenkrog@gpe.cl', '56229168200', 'Félix de Amesti 90. Oficina 201', 'Las Condes', 'María Luisa Orellana', 'Hidroeléctrica Mallarauco S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (76, 'El Agrio', '76.364.112-0', '', '', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'El Agrio Hidro SpA', 'PMGD');
INSERT INTO public.reuc VALUES (77, 'Tiltil Solar', '76.254.347-8', '', '1000000.0', 'JoungYoul Lee', 'joung-youl.lee@hanwha.com', '56232234744', 'Apoquindo 5400, piso 21', 'Santiago', 'Gonzalo Nuñez', 'Hanwha Q Cells Til Til Uno SpA', 'PMGD');
INSERT INTO public.reuc VALUES (78, 'Parque Eólico Lebu', '76.416.891-7', '', '9230003.0', 'Francisco Ruiz Morande', 'fruiz@cristoro.cl', '56224374500', 'Dagoberto Godoy 145', 'Cerrillos', 'María Isabel González Rodríguez', 'Parque Eólico Lebu-Toro SpA', 'PMGD,PMG,Generador');
INSERT INTO public.reuc VALUES (79, 'EFE', '61.216.000-7', '', '', 'José Solorza', 'jose.solorza@efe.cl', '56225855050', 'Morande 115 PB', 'Santiago', 'Daniel Pinto', 'Empresa de los Ferrocarriles del Estado', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (80, 'Minera Atacama Kozan', '77.134.510-7', '', '', 'Sensuke Arai', 'arai@atacamakozan.cl', '56522203800', 'Parcela Los Olivos sin Numero Tierra Amarilla Copiapó.', 'Tierra Amarilla', 'Roberto Alexandre Celedon Diaz', 'Sociedad Contractual Minera Atacama Kozan', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (81, 'Rucatayo', '76.030.638-K', '', '', 'María Teresa Gonzalez', 'contacto@statkraft.com', '56225929200', 'Vitacura 2969, Oficina 701', 'Las Condes', 'CARLOS MANTE', 'Empresa Eléctrica Rucatayo S.A.', 'Generador');
INSERT INTO public.reuc VALUES (82, 'Estancilla', '76.145.769-1', '', '1000000.0', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Generadora Estancilla SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (83, 'Bellavista', '76.377.436-8', '', '7560742.0', 'JORGE ANDRES LEMBEYE ILLANES', 'jlembeye@lembeye.cl', '56953043093', 'AV APOQUINDO 5950', '', 'Rodrigo Orellana', 'Parque Solar Bellavista SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (84, 'Pehui Ltda', '76.067.554-7', '', '5312350.0', 'Ricardo Mohr Rioseco', 'ricardo@generhom.com', '56642239001', 'Av Juan Mackenna 716 Oficina  D', 'Osorno', 'Camila Nail Barría', 'Generadora Eléctrica Pehui Ltda', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (85, 'Chilquinta (ex Chilquinta Energía)', '96.813.520-1', '', '2391395.0', 'Francisco Mualim Tietz ', 'fmualim@chilquinta.cl', '56322452280', 'Av. Argentina N° 1 piso 9', 'Valparaíso', 'Luis Eduardo Sepúlveda Iturra', 'Chilquinta Distribución S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (86, 'Hidrolircay', '76.025.973-K', '', '1000000.0', 'Carl Weber Silva', 'cweber@hidromaule.cl', '56229635200', 'Avenida Presidente Kennedy 5454, of. 1601', 'Vitacura', 'Diego Heinrich', 'Hidroeléctrica Río Lircay S.A.', 'Generador,Transmisor Dedicado,PMG');
INSERT INTO public.reuc VALUES (87, 'Minera Centenario', '76.051.610-4', '', '', 'Marco Fazzi Soto', 'marco.fazzi@cl.kghm.com', '56932470085', 'Magdalena 140, piso 10', '', 'Raúl Balboa', 'Sociedad Contractual Minera Franke', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (88, 'Beneo Orafti', '77.894.990-3', '', '', 'Edgar Stadtfeld ', 'orafti.chile@orafti.cl', '56422458000', 'Km 445 Ruta 5 Sur', 'Pemuco', 'Michael Cornejo Muñoz', 'Orafti Chile S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (89, 'Los Padres Hidro', '76.248.798-5', '', '1000000.0', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'Los Padres Hidro SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (90, 'Eléctrica Til Til', '70.849.500-K', '', '', 'Rubén Humberto Bustos Tapia', 'rbustos@electricatiltil.cl', '56228461278', 'Emilio Valle 013', 'Tiltil', 'Juan Carlos López  Griffiths', 'Empresa Eléctrica Municipalidad de Til Til', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (91, 'Minera Valle Central', '96.595.400-7', '', '', 'Christian Cáceres Meneses', 'ccaceres@mineravallecentral.cl', '56722330100', 'Colihues s/n KM.13', '', 'Francisco Reyes J.', 'Minera Valle Central S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (92, 'Hidroeléctrica Diuto', '76.074.053-5', '', '1000000.0', 'Lluc Rovira Masramon', 'lrovira@engiaux.com', '56432311198', 'Av. Alemania 245, Los Angeles', 'Los Ángeles', 'Lluc Rovira Masramon', 'Minicentral Hidroeléctrica El Diuto S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (93, 'ERSA', '87.756.500-9', '', '', 'Patricio Farfán Bórquez', 'pfarfan@enaprefinerias.cl', '56222803000', 'Apoquindo 2929, piso 5', '', 'Mario Tellez', 'ENAP Refinerías S.A.', 'Cliente Libre,Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (94, 'Hidroeléctrica Puclaro', '99.589.620-6', '', '1000000.0', 'Tomas Fahrenkrog', 'tfahrenkrog@gpe.cl', '56229168200', 'Félix de Amesti 90. Oficina 201', 'Las Condes', 'María Luisa Orellana', 'Hidroelectrica Puclaro S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (95, 'Enerbosch', '76.028.873-K', '', '', 'Bautista Bosch Ostale', 'bautista.bosch@enerbosch.cl', '56222455946', 'Manquehue Sur 520, of 320', 'Las Condes', 'Bautista Bosch Ostale', 'Enerbosch S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (96, 'Curileufu', '84.100.300-4', '', '7580575.0', 'Alfredo Erlwein Kaltenbacher', 'aecuri@tie.cl', '56222078770', 'Av. Apoquindo 4445, of. 301, Las Condes', 'Las Condes', 'Pedro Bustamante', 'Sociedad Agrícola y Ganadera Curileufu Ltda.', 'PMGD');
INSERT INTO public.reuc VALUES (97, 'Coopelan', '81.585.900-6', '', '', 'Jose Luis Neira Veloso', 'coopelan@coopelan.cl', '56432407070', 'Av. Las Industrias N°4670, Los Angeles', 'Los Ángeles', 'Jose Luis Neira Veloso', 'Cooperativa Eléctrica Los Angeles LTDA', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (326, 'PMGD Piquero', '76.746.538-6', '', '', 'Tomas Herzfeld', 'tomas.herzfeld@gestionsolar.cl', '56223441024', 'Malaga 85, of 216', 'Las Condes', 'Tomas Herzfeld', 'Piquero SpA', 'PMGD');
INSERT INTO public.reuc VALUES (98, 'Hidroeléctrica La Confluencia', '76.350.250-3', 'Registro segun carta DE06334', '', 'JAVIER EDUARDO CARRASCO BRIONES', 'JCARRASCO@tenergia.cl', '56225194368', 'Avenida Cerro El Plomo 5630, Oficina 1702, Las Condes, Santiago', 'Las Condes', 'Javier Emilio Sepúlveda Saavedra', 'Hidroeléctrica La Confluencia S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (99, 'KDM', '76.059.578-0', '', '8580644.0', 'Rodrigo Pardo Feres', 'rpardof@kdm.cl', '56223893201', 'Alcalde Guzmán 0180', 'Quilicura', 'Pablo Bustos Arriagada', 'KDM Energía S.A.', 'Transmisor Dedicado,Generador,PMG');
INSERT INTO public.reuc VALUES (100, 'Tecnored', '77.302.440-5', '', '1000000.0', 'Sergio De Paoli Botto', 'sdepaoli@tecnored.cl', '56322452580', 'Cerro El Plomo 3819, Parque Ind. Curauma Placilla', 'Valparaíso', 'Fiorella Roncagliolo', 'TecnoRed S.A.', 'Generador,PMG,PMGD');
INSERT INTO public.reuc VALUES (101, 'HIDRO LAS FLORES', '76.210.842-9', '', '1000000.0', 'Martin Riesco', 'm.riesco@mantosdelaluna.cl', '56226767500', 'Los Conquistadores 1700 p-13', 'Providencia', 'Martin Riesco', 'Hidroeléctrica Las Flores S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (102, 'Minera Cerro Negro', '91.614.000-2', '', '', 'Marcelo Bruit', 'marcelo.bruit@grupolosangeles.cl', '56332713900', 'Hacienda Los Angeles S/N, Pitipeumo', 'Cabildo', 'Maritza Baeza', 'Compañía Minera Cerro Negro S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (103, 'Parque fotovoltaico Javiera', '76.376.635-7', '', '', 'Luis Alfredo Solar Pinedo ', 'asolar@atlasren.com', '56226118300', 'Apoquindo 3472, piso 9', 'Las Condes', 'Tomás Ávila Araya', 'Javiera SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (104, 'CPP Planta San Pedro', '77.371.287-5', '', '', 'Ricardo Orellana Vidal', 'rorellana@cpp.cl', '56722208151', 'Longitudinal sur Km. 63 S/N, San Francisco de Mostazal, Sexta Regi{on', 'Mostazal', 'Jaime Cantero', 'Papelera Dos S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (105, 'Hidroeléctrica El Canelo', '76.136.655-6', '', '1000000.0', 'Marcelo Arriagada Uslar', 'marriagada@hidromanzano.cl', '56452921840', 'Arturo Prat 696, oficina 415', 'Temuco', 'Marcelo Arriagada Uslar', 'Hidroeléctrica El Canelo S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (106, 'Andes Generación', '76.203.788-2', '', '7580097.0', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Andes Generación SpA', 'Generador');
INSERT INTO public.reuc VALUES (107, 'Energía Cerro El Morado', '76.392.147-6', '', '', 'CARLOS FERNANDO GARDEWEG RIED', 'fgardewegr@wegcapital.cl', '56229491319', 'Los Conquistadores 1730, oficina 1001, piso 10', 'Providencia', 'Eliseo Lopez', 'Energía Cerro El Morado S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (108, 'Fundición Talleres', '99.532.410-5', '', '2841040.0', 'Jose Pablo Dominguez Bustamante', 'jpdoming@talleres.cl', '56722587500', 'Avda. Estación N° 01200 Rancagua', '', 'Nelson Salinas', 'Fundición Talleres Ltda.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (109, 'PSF Pama', '76.284.903-8', '', '7510574.0', 'Alfonso Izquierdo Irarrázaval', 'aizquierdo@menchaca.cl', '56223902200', 'Mar del Plata 2111, Providencia, Santiago, Chile', 'Providencia', 'Luis Ljubetic', 'PSF Pama S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (110, 'Hidroeléctrica San Andrés', '76.032.641-0', '', '', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'Hidroeléctrica San Andrés SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (111, 'Pacific Hydro Chacayes', '76.006.855-1', '', '7550071.0', 'Renzo Valentino', 'rvalentino@pacifichydro.cl', '56225194200', 'Av. Isidora Goyenechea 3520 piso 10', 'Las Condes', 'Luis Osvaldo Nuñez Herrera', 'Pacific Hydro Chacayes S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (112, 'Luzlinares', '96.884.450-4', '', '', 'Francisco Solis Ganga', 'fsolisg@luzlinares.cl', '56732634004', 'Chacabuco 675, Linares', 'Lineares', 'Jorge Antonio Valladares Muñoz', 'Luzlinares S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (113, 'Molinera Villarrica', '80.203.400-8', '', '1000000.0', 'Roland Weber', 'roland.weber@molineravillarrica.cl', '56452411192', 'Av. Presidente Juan Antonio Rios 1080', 'Villarica', 'Roland Weber', 'CIA Molinera Villarrica Ltda', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (114, 'Energía Atacama S.A. (ex EBCO Atacama S.A.)', '76.382.754-2', '', '', 'Felipe Baraona Undurraga', 'fbaraona@triplei.cl', '56227060380', 'Av. Las Condes 11400, of 101. Vitacura', 'Vitacura', 'David Riveros', 'Energía Atacama S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (115, 'Energía Pacífico', '76.004.531-4', '', '2890000.0', 'Ricardo Orellana Vidal', 'rorellana@cpp.cl', '56722208151', 'Longitudinal sur Km. 63 S/N, San Francisco de Mostazal, Sexta Regi{on', 'Mostazal', 'Roberto Aguilera', 'Energía Pacífico S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (116, 'Renovalia Chile Siete SpA', '76.327.574-4', '', '7561160.0', 'Santiago Rull Cullen', 'chapeana@disagrupo.es', '34922238700', 'Cerro el Plomo 5420 oficina 903', 'Las Condes', 'Joaquín Gurriarán Florido', 'La Chapeana SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (117, 'Norvind', '76.919.070-8', '', '7560742.0', 'Gustavo Adolfo Gomez Cerón', 'ggomez@colbun.cl', '56979111650', 'Apoquindo 4775, piso 11', '', 'Sebastián Ruiz-Tagle', 'Norvind S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (118, 'Santa Marta', '96.828.810-5', '', '8060713.0', 'Rodolfo Bernstein Guerrero ', 'rbernstein@csmarta.cl', '56225921234', 'Avda. General Velásquez 8990 San Bernardo', 'San Bernardo', 'Brunsley Oscar Elliot Stambuk', 'Consorcio Santa Marta S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (119, 'Eólica La Esperanza', '76.427.498-9', '', '', 'Santiago Alliende Gonzalez ', 'salliende@petroquim.cl', '56223516700', 'Hernando de Aguirre 268, of. 402, Providencia', 'Providencia', 'Luis Ljubetic', 'Eólica La Esperanza S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (120, 'Colbún', '96.505.760-9', '', '7580097.0', 'Jose Ignacio Escobar Troncoso', 'jescobart@colbun.cl', '56224604122', 'Apoquindo 4775, piso 11', 'Las Condes', 'Sebastián Ruiz-Tagle', 'Colbún S.A.', 'Generador,PMGD,Transmisor Zonal');
INSERT INTO public.reuc VALUES (121, 'Minera Ojos del Salado', '96.635.170-5', '', '', 'Juan Carlos Pino Escobar', 'juan.pino@lundinmining.com', '56522461074', 'Avda. El Bosque Norte #500, Oficina 1102, Santiago', 'Las Condes', 'Victor Chaura Pérez', 'Compañía Contractual Minera Ojos del Salado', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (122, 'Enel Green Fusión Almeyda Solar SpA/PE Taltal SpA /E Panguipulli / Valle de los Vientos', '76.412.562-2', 'Fusión por absorción Parque Solar Caracoles SpA carta https://correspondencia.coordinador.cl/correspondencia/show/recibido/62ab53b7356357143f41db75(10 marzo 2022)', '7561127.0', 'Ali Shakhtur', 'Ali.Shakhtur@enel.com', '', '', '', 'Miguel Buzunariz Ramos', 'Enel Green Power Chile S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (123, 'Agrosuper', '77.805.520-1', '', '1630000.0', 'Felipe Ortíz', 'fortiz@agrosuper.com', '56512575700', 'Ruta C-46 km 18 Bodeguilla, Freirina', 'Freirina', 'Alejandro Sánchez Jaramillo', 'Agrocomercial A.S. Ltda.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (124, 'ENAMI Paipote', '61.703.000-4', '', '', 'Ernesto Ortiz Ayala', 'eortiz@enami.cl', '56522533307', 'Camino Publico s/n', '', 'Rodrigo Lara', 'Empresa Nacional de Minería, Fundición Hernán Videla Lira', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (125, 'HBS Energía', '76.856.480-9', '', '', 'Jose Manuel Carvallo Munita', 'jcarvallo@hbsenergia.cl', '56222157731', 'Estoril 50 Oficina 601, Las Condes', 'Las Condes', 'Jose Manuel Carvallo Munita', 'HBS Energía S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (126, 'Generhom', '77.412.850-6', '', '5312350.0', 'Ricardo Mohr Rioseco', 'ricardo@generhom.com', '56642239001', 'Av Juan Mackenna 716 Oficina  D', 'Osorno', 'Camila Nail Barría', 'Generadora Eléctrica Rhom Ltda', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (127, 'Tamm', '86.579.500-9', '', '', 'Andres Tamm Plesch ', 'andres.tamm@tammfruit.cl', '56722720862', 'Fundo Rinconada S/N Tinguiririca', 'San Fernando', 'Andres Tamm Plesch ', 'Roberto Tamm y Cia Ltda.', 'PMGD');
INSERT INTO public.reuc VALUES (128, 'AJTE', '76.100.121-3', '', '7580125.0', 'Alan Heinen Alves Da Silva', 'alan.heinen@celeogroup.com', '56232024300', 'Apoquindo 4501, Oficina 1902', 'Las Condes', 'David Zamora Mesias', 'Alto Jahuel Transmisora de Energía S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (129, 'Hidroeléctrica El Manzano', '76.803.940-2', '', '1000000.0', 'Marcelo Arriagada Uslar', 'marriagada@hidromanzano.cl', '56452921840', 'Arturo Prat 696, oficina 415', 'Temuco', 'Marcelo Arriagada Uslar', 'Hidroeléctrica el Manzano S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (130, 'EEPA', '80.313.300-K', '', '', 'Mauricio Infante Esquerra', 'mauricio.infante@eepa.cl', '56223450005', '21 de Mayo 0164, Puente Alto', 'Puente Alto', 'Guillermo Eduardo Guerra Godoy', 'Empresa Eléctrica Puente Alto S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (131, 'Ucuquer', '76.152.252-3', '', '1000000.0', 'Vicente Izquierdo', 'cgalaz@alimarstgo.cl', '56223902200', 'Mar del Plata 2111, Providencia, Santiago, Chile', '', 'Luis Ljubetic', 'Energías Ucuquer S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (132, 'Luz del Norte', '76.319.477-9', '', '7560742.0', 'José Manuel Infante', 'jose.infante@toesca.com', '56226462038', 'Magdalena 140, Piso 22, Las Condes', 'Las Condes', 'Alejandro Reyes', 'Parque Solar Fotovoltaico Luz del Norte SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (133, 'GENPAC', '76.010.367-5', '', '7560742.0', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Generadora del Pacífico SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (134, 'Energías del Futuro', '76.272.689-0', '', '', 'Daniel Gustavo Espinoza Leoz', 'd.espinoza@energiasdelfuturo.cl', '56224268510', 'Los Presidentes 8912 casa 95 Condominio Los Parques de Peñalolen', 'Peñalolén', 'Daniel Gustavo Espinoza Leoz', 'EERM Energías del Futuro S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (135, 'Guacolda', '76.418.918-3', '', '', 'Marco Arrospide', 'marco.arrospide@eguacolda.cl', '56998711084', 'Avenida Apoquindo 3472, piso 7, oficina 701', 'Las Condes', 'Felipe Antonio Valdés Aránguiz', 'Guacolda Energía SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (136, 'Cemento Polpaico', '91.337.000-7', '', '7550100.0', 'Felipe Orfali', 'felipe.orfali@polpaico.cl', '56223376397', 'Av El Bosque Norte 0177, Piso 5', 'Las Condes', 'Hernan Bahamondes Castro', 'Cemento Polpaico S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (137, 'Anglo American Sur', '77.762.940-9', '', '7500524.0', 'Rodrigo Subiabre Valdes', 'rodrigo.subiabre@angloamerican.com', '56222306257', 'Isidora Goyenechea 2800, piso 46 Las Condes/ Santiago CP 7550647', '', 'Ariel Cáceres Riquelme', 'Anglo American Sur S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (138, 'Parque Solar Los Loros', '76.247.976-1', 'Cambia razón social de Solairedirect Generación V SpA a Solar Los Loros SpA carta DE01164-22', '7550108.0', 'Rosaline Corinthien', 'anais.munier@engie.com', '56223533200', 'Isidora Goyenechea 2800, piso 16', 'Las Condes', 'Pablo Jorquera Riquelme', 'Solar Los Loros SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (139, 'SPV P4', '76.201.449-1', 'Reemplazo Sonnedix Taranto SpA carta https://correspondencia.coordinador.cl/correspondencia/show/envio/61cc6bf435635750ba94314c', '1000000.0', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'SPV P4 SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (140, 'Hidroeléctrica Lleuquereo', '76.281.947-3', '', '1000000.0', 'Andrea Zunino Besnier', 'azunino@mcondor.cl', '56998499864', 'Av. Andres Bello 2777 oficina 2004', '', 'Felipe Aceituno Arroyo', 'Hidroeléctrica Lleuquereo S.A.', 'Transmisor Dedicado,PMG,Generador');
INSERT INTO public.reuc VALUES (141, 'Coelcha', '80.238.000-3', '', '', 'Boris Ludgardo Figueroa Henriquez', 'boris.figueroa@coelcha.cl', '432410384', 'Osvaldo Cruz Muñoz 160, Monte Aguila', 'Cabrero', 'Alberto Sánchez Polanco', 'Cooperativa Eléctrica Charrúa Ltda.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (142, 'EFE Valparaíso', '96.766.340-9', '', '', 'Miguel Saavedra', 'miguel.saavedra@efevalparaiso.cl', '56991974928', 'Viana 1685', 'Viña del Mar', 'Juan Hector Rodo Rodas', 'EFE Valparaíso S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (143, 'Colmito', '76.326.949-3', '', '7560742.0', 'Victoria Salinas', 'victoria.salinas@inkiaenergy.com', '56228207100', 'Cerro el Plomo 5680, Of 1501', 'Las Condes', 'Javier Pujol', 'Central Colmito S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (144, 'Enlasa', '76.009.328-9', '', '', 'Jorge Brahm', 'jbrahm@enlasa.cl', '56229632900', 'Los Militares 5001 Piso 10, Santiago', 'Las Condes', 'Gustavo Venegas', 'Enlasa Generación Chile S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (145, 'Crell', '81.106.900-0', '', '', 'Franco Rafael Aceituno Gandolfo', 'autoridad@crell.cl', '5652200420', 'Ruta 5 Sur, Km 1.006,85 Caletera Poniente, Puerto Varas', 'Puerto Varas', 'Manuel Saavedra', 'Cooperativa Regional Eléctrica Llanquihue Ltda', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (146, 'Parque Eólico Talinay', '76.126.507-5', '', '7561127.0', 'Ali Shakhtur', 'Ali.Shakhtur@enel.com', '', '', '', 'Miguel Buzunariz Ramos', 'Parque Talinay Oriente S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (147, 'Besalco Energía', '76.249.099-4', '', '7550594.0', 'Guillermo García Cano', 'guillermo.garcia@besalco.cl', '56223312200', 'Av Nueva Tajamar 183, Las Condes', '', 'Jonathan Cardenas Parra', 'Besalco Energía Renovable S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (148, 'Cemin', '89.274.000-3', '', '8340420.0', 'Horacio Bruna Orchard', 'hbruna@cemin.com', '56224713633', 'Miraflores 178 piso 7, Edificio Fundación', '', 'Alejandro Lagos Mardones', 'Compañía Explotadora de Minas S.C.M.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (149, 'AES Andes (ex Aes Gener)', '94.272.000-9', '', '7561185.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'AES Andes S.A.', 'Transmisor Dedicado,Generador,Transmisor Zonal');
INSERT INTO public.reuc VALUES (150, 'El Raso', '76.426.029-5', '', '', 'Javier Antonio Alemany Martinez', 'jalemany@fyrmob.cl', '56224479348', 'Santa Alejandra 03480, Barrio Industrial, San Bernardo, Santiago', 'San Bernardo', 'Javier Antonio Alemany Martinez', 'Eléctrica Raso Power Ltda.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (151, 'EMELDA', '76.004.337-0', '', '7560742.0', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Empresa Eléctrica Diego de Almagro SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (152, 'Collil', '76.246.882-4', '', '', 'Martín Bruna', 'martinbruna@gmail.com', '56981365401', 'Sector Melleico alto s/n', 'Chonchi', 'Martín Bruna', 'Energía Collil S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (153, 'Hidroeléctrica Trueno', '76.834.000-5', '', '1000000.0', 'Tomas Fahrenkrog', 'tfahrenkrog@gpe.cl', '56229168200', 'Félix de Amesti 90. Oficina 201', 'Las Condes', 'María Luisa Orellana', 'Hidroeléctrica Trueno S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (154, 'Carbomet Energía', '91.066.000-4', '', '1000000.0', 'Pablo Javier Herrera Nuñez', 'pablo.herrera@carbomet.cl', '56229376429', 'Avenida Portales Oriente 3499', 'San Bernardo', 'Pablo Javier Herrera Nuñez', 'Carbomet Energía S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (155, 'Elektragen', '76.594.660-3', '', '7550159.0', 'Alejandro Larenas', 'alarenas@elektragen.cl', '56222287775', 'Alcántara 44, Piso 11', 'Las Condes', 'Alejandro Larenas', 'Elektra Generación S.A.', 'Generador,Transmisor Dedicado,PMG');
INSERT INTO public.reuc VALUES (156, 'Imelsa Energía', '76.472.262-0', 'Desde 01-12-2015 reemplaza a PMGD TER El Canelo II, propiedad de El Canelo SpA.', '8370410.0', 'Rodrigo Moya Lorenzini', 'rodrigo.moya@ie.cl', '56226893300', 'Av. España 795', 'Santiago', 'Sebastian Bernstein', 'Imelsa Energía SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (157, '', '', 'https://correspondencia.coordinador.cl/correspondencia/show/envio/636a89343563570388b3de2e: desde 01-12-2022 reemplaza a PMGD TER El Canelo I propiedad de El Canelo SpA', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (158, 'CGE', '76.411.321-7', 'Fusión con Empresa Eléctrica de Arica S.A., Empresa Eléctrica de Iquique S.A. y Empresa Eléctrica de Antofagasta S.A. (EMELARI, ELIQSA, ELECDA, respectivamente) en carta DE02269-18', '7561127.0', 'Iván Arístides Quezada Escobar', 'iquezadae@grupocge.cl', '56226807204', 'Presidente riesco 5561 piso 14', 'Las Condes', 'Victor Gutierrez Gonzalez', 'Compañía General de Electricidad S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (159, 'SGA', '99.528.750-1', '', '', 'Francisco Alliende A.', 'sga@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Kandinsky Dintrans Perez', 'Sociedad Generadora Austral S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (160, 'Conejo Solar', '76.376.829-5', '', '7561210.0', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Conejo Solar SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (161, 'Nueva Energía', '76.045.612-8', '', '', 'Cristián Muñoz Elgueta', 'cmunoz@enesa.cl', '56412906522', 'Parque Industrial Escuadrón N°2. km. 17,5 Camino a Coronel', 'Coronel', 'Cristián Muñoz Elgueta', 'Eléctrica Nueva Energía S.A.', 'Generador');
INSERT INTO public.reuc VALUES (162, 'FPC', '96.528.420-6', '', '', 'Gonzalo Andres Pacheco  Achondo', 'gpacheco@fpc.cl', '56412885000', 'Parque Industrial Escuadrón II, km 17,5, Coronel, Chile', '', 'Gastón Alejandro Retamal Retamal', 'Forestal y Papelera Concepción  S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (163, 'Pichilonco', '76.257.412-8', '', '7520425.0', 'Felipe Oettinger', 'fod@ebcoenergia.cl', '56224644705', 'Av. Santa María 2450, Piso 2', 'Providencia', 'Juan León Obrecht', 'Hidroeléctrica Pichilonco S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (164, 'Energía León', '76.166.356-9', '', '3970000.0', 'Antonio Viñuela Miranda', 'antoniovinuela@forestalleon.cl', '56422510025', 'Lo Pinto Lote B 5.2 Sector Tropezón', 'Coelemu', 'Raul Flores', 'Energía León S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (165, 'Codiner', '78.397.530-0', '', '4791178.0', 'Fredy Barbieri Giacomozzi', 'fbarbieri@inverluz.cl', '56452210037', 'General Aldunate 0380', 'Temuco', 'Pablo Juan Roberto Leal Vester ', 'Compañía Distribuidora de Energía Eléctrica CODINER S.A.', 'Distribuidoras (Concesionarias de Distribución),Transmisor Zonal');
INSERT INTO public.reuc VALUES (166, 'Comasa', '96.546.010-1', '', '4860000.0', 'Francisco Rodrigo Izquierdo Valdes', 'comasa@comasageneracion.cl', '56452992800', 'Ruta 5 Sur km m645, Camino a Colonia km 0,5 S/N', 'Lautaro', 'Hector Saavedra', 'Comasa SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (167, 'Neomas', '76.112.774-8', '', '4470000.0', 'Antonio Cortés Ruiz', 'acortes@neoelectra.es', '56978506464', 'Cerro el Plomo 5931, Oficina 407', 'Las Condes', 'Noemi Ayesa', 'Neomas SpA', 'Generador');
INSERT INTO public.reuc VALUES (168, 'STS', '77.312.201-6', 'Fusión STS - Nuevo RUT https://correspondencia.coordinador.cl/correspondencia/show/recibido/61a79fb73563575aff0ce4f4', '1000000.0', 'Francisco Alliende A.', 'sts.reg@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Juan Alfonso Veloso Molina', 'Sistema de Transmisión del Sur S.A.', 'Transmisor Nacional,Transmisor Dedicado,Transmisor Zonal');
INSERT INTO public.reuc VALUES (169, 'Parque Eólico El Arrayán', '76.068.557-7', '', '7561210.0', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Parque Eólico El Arrayán SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (170, 'San Juan', '76.319.883-9', '', '7550107.0', 'Gustavo Adolfo Gomez Cerón', 'ggomez@colbun.cl', '56979111650', 'Apoquindo 4775, piso 11', '', 'Sebastián Ruiz-Tagle', 'San Juan S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (171, 'Frontel', '76.073.164-1', '', '', 'Francisco Alliende A.', 'frontel@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Kandinsky Dintrans Perez', 'Empresa Eléctrica de la Frontera S.A.', 'Transmisor Zonal,Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (172, 'Central Cardones', '76.550.580-1', '', '1000000.0', 'Victoria Salinas', 'victoria.salinas@inkiaenergy.com', '56228207100', 'Cerro el Plomo 5680, Of 1501', 'Las Condes', 'Javier Pujol', 'Central Cardones S.A.', 'PMG,Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (173, 'Trailelfu', '76.392.022-4', '', '', 'Bautista Bosch Ostale', 'bautista.bosch@enerbosch.cl', '56222455946', 'Manquehue Sur 520, of 320', 'Las Condes', 'Bautista Bosch Ostale', 'Hidroeléctrica Trailelfu SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (174, 'Carrán', '87.886.600-2', '', '1000000.0', 'Alvaro Flaño', 'alvaroflano@carran.cl', '56229154900', 'José Victorino Lastarria 333', 'Santiago', 'Alvaro Flaño', 'Ganadera y Forestal Carran Limitada', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (175, 'Arauco Bioenergía', '96.547.510-9', '', '', 'Leonardo Bastidas Almarza', 'leonardo.bastidas@arauco.cl', '56944932354', 'El Golf 150, piso 7', 'Las Condes', 'Leonardo Bastidas Almarza', 'Arauco Bioenergía SpA', 'Cliente Libre,Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (176, 'Teck-Carmen de Andacollo', '78.126.110-6', '', '', 'Angelica Cabrera', 'angelica.cabrera@teck.com', '56512330498', 'CAMINO CHEPIQUILLA S/N, ANDACOLLO', 'Andacollo', 'Cristian Alejandro Delgado Gajardo', 'Compañía Minera Teck Carmen de Andacollo', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (177, 'Capullo', '96.637.520-5', 'Reemplaza a PMGD HP LOS CORRALES I entre al 1 de junio de 2013 y el 20 de noviembre de 2020', '', 'Pablo Benario', 'pbenario@eleonera.cl', '56224410155', 'Alfredo Barros Errázuriz 1954, Of. 702, Providencia.', 'Providencia', 'Víctor Manuel Salinas Barrera', 'Empresa Eléctrica Capullo S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (178, '', '', 'Reemplaza a PMGD HP LOS CORRALES II desde el 1 de junio de 2013.', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (179, 'Cooprel', '81.388.600-6', '', '5240568.0', 'CHRISTIAN ARTURO EGLI ANFRUNS', 'CHRISTIAN.EGLI@cooprel.cl', '56642341284', 'COMERCIO ESQ INDEPENDENCIA , 569, SEGUNDO PISO', 'Río Bueno', 'Lienthur Juan SILVA MENDEZ', 'Cooperativa Rural Eléctrica Río Bueno Ltda.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (180, 'Hidroeléctrica La Higuera', '96.990.050-5', '', '', 'JAVIER EDUARDO CARRASCO BRIONES', 'JCARRASCO@tenergia.cl', '56225194368', 'Avenida Cerro El Plomo 5630, Oficina 1702, Las Condes, Santiago', 'Las Condes', 'Javier Emilio Sepúlveda Saavedra', 'Hidroeléctrica La Higuera S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (181, 'María Elena Ltda', '76.188.603-7', '', '5312350.0', 'Ricardo Mohr Rioseco', 'amohr@boquial.com', '56642239001', 'Av Juan Mackenna 716 Oficina  D', 'Osorno', 'Ricardo Mohr Rioseco', 'Generadora Eléctrica María Elena Ltda', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (182, 'Saesa', '76.073.162-5', '', '', 'Francisco Alliende A.', 'saesa@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Kandinsky Dintrans Perez', 'Sociedad Austral de Electricidad S.A.', 'Transmisor Zonal,Distribuidoras (Concesionarias de Distribución),Generador SSMM,Distribuidoras SSMM (Concesionarias de Distribución),Generador,Transmisor Zonal SSMM');
INSERT INTO public.reuc VALUES (183, 'EMR', '76.019.239-2', '', '', 'Rosaline Corinthien', 'anais.munier@engie.com', '56223533200', 'Isidora Goyenechea 2800, piso 16', 'Las Condes', 'Pablo Jorquera Riquelme', 'Eólica Monte Redondo SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (184, 'La Montaña 1', '76.157.465-5', '', '1000000.0', 'Victor Rioseco Pino', 'vrioseco@rioseco-auditores.cl', '56752327995', 'Estado 213, of 306', 'Curicó', 'Victor Rioseco Pino', 'Hidroeléctrica Puma S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (185, 'Central Hidroeléctrica Río Mulchén', '76.089.965-8', '', '7580150.0', 'Juan León Obrecht', 'jlo@agrosonda.cl', '56223765202', 'Carretera General San Martin 16.500 15A', 'Colina', 'Juan León Obrecht', 'Central Hidroeléctrica Río Mulchén S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (186, 'Sunenergreen (Altos del Paico)', '76.205.368-3', '', '', 'Cristian Rillon Kolbach ', 'crillonk@gmail.com', '56232454710', 'Ruta G608, km 4.5, Lote 4', 'El Monte', 'Cristian Rillon Kolbach ', 'Sunenergreen S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (187, 'Minera Zaldívar', '85.758.600-K', '', '1270237.0', 'Leonardo Emilio Gonzalez Alcayaga', 'lgonzalez@antucoya.cl', '56227987000', 'Av. Apoquindo 4001 piso 18', 'Las Condes', 'José Rodrigo Lucero Chilovitis', 'Compañía Minera Zaldívar LTDA', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (188, 'STLL', '76.024.633-6', '', '7500521.0', 'Pablo Benario', 'pbenario@eleonera.cl', '56224410155', 'Alfredo Barros Errázuriz 1954, Of. 702, Providencia.', 'Providencia', 'Javier Chamorro Valdés', 'Sistema de Transmisión de Los Lagos S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (189, 'Transmisora del Melado', '76.538.831-7', '', '1000000.0', 'Paulo Bezanilla Saavedra ', 'op.energia@besalco.cl', '56223312200', 'Av. Tajamar N°183, oficina 301, Las Condes', '', 'María José Reveco', 'Transmisión del Melado SpA', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (190, 'Eléctrica Ventanas', '96.814.370-0', '', '', 'CARLOS FERNANDO GARDEWEG RIED', 'fgardewegr@wegcapital.cl', '56229491319', 'Los Conquistadores 1730, oficina 1001, piso 10', 'Providencia', 'Marcelo Rubio Sekul', 'Empresa Eléctrica Ventanas SpA', 'Generador');
INSERT INTO public.reuc VALUES (191, 'EL PASO', '76.032.642-9', '', '', 'René Ilabaca', 'rilabaca@hidroelpaso.cl', '5627630479', 'Américo Vespucio Norte 1090', 'Vitacura', 'René Ilabaca', 'Hidroeléctrica El Paso SpA', 'Generador');
INSERT INTO public.reuc VALUES (192, 'Agrícola Ancalí', '79.757.460-0', '', '', 'Miguel Aparicio M.', 'miguel.aparicio@ancali.cl', '56432401523', 'Rancho RM Ruta 5 Sur Km.521 San Carlos Purén', 'Los Ángeles', 'Pablo Martin', 'Agrícola Ancalí Limitada', 'PMGD');
INSERT INTO public.reuc VALUES (193, 'Antilhue', '76.009.904-K', '', '', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Generadora Antilhue Spa', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (194, 'SCM', '70.009.410-3', '', '', 'Alejandro Gómez Vidal', 'agomez@electricapuntilla.cl', '56225922300', 'ORINOCO 90, PISO 11', 'Las Condes', 'Karen Beltran Cerda', 'Asoc. de Canal. Sociedad del Canal de Maipo', 'Generador');
INSERT INTO public.reuc VALUES (195, 'RTS ENERGY', '76.117.591-2', '', '', 'Antonio Ramón Torres Rodriguez', 'antonio.torres@solar-energy.cl', '56222484883', 'Santa Elena 2362, of 504', '', 'Jean Claude Le-Cerf', 'RTS Energía S.A.', 'PMG');
INSERT INTO public.reuc VALUES (196, 'Latinoamericana', '79.709.410-2', '', '', '', '', '', '', '', '', 'Latinoamericana S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (197, 'Besalco Transmisión', '76.975.911-5', '', '', 'Paulo Bezanilla Saavedra ', 'op.energia@besalco.cl', '56223312200', 'Av. Tajamar N°183, oficina 301, Las Condes', '', 'Hector Castillo Bustamante', 'Besalco Transmisión SpA', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (198, 'Interchile S.A.', '76.257.379-2', '', '', 'Luis Llano', 'lllano@interchilesa.com', '56229456850', 'Cerro el Plomo 5630, Oficina 1802', 'Las Condes', 'Eduardo Sáez', 'Interchile S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (199, 'ELP', '76.389.157-7', '', '7550188.0', 'Matias Concha', 'mconcha@elp.cl', '56224413710', 'Hendaya 60, piso 15, Las Condes', 'Las Condes', 'Matias Concha', 'Eólico Las Peñas SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (200, 'Energías Renovables Holding', '77.324.593-2', 'Reemplazo Parque Fotovoltaico Peñaflor SpA en carta DE00450-22', '', 'Martin Valenzuela Hitschfeld', 'martinvalenzuela@andes-solar.com', '56967275006', 'Av. del Parque 4160, Torre A, oficina 701', '', 'Carlos Bravo Ramirez', 'Energías Renovables Holding S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (201, 'GM Holdings (ex Central el Campesino S.A.)', '76.240.103-7', '', '', 'Diego Hollweck', 'dhollweck@generadora.cl', '56223911100', 'Apoquindo 3472, Oficina 1301', 'Las Condes', 'Carolina Vélez', 'GM Holdings S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (202, 'Eletrans II S.A.', '76.306.442-5', '.', '', 'Álvaro Arturo Alarcón Molina', 'aalarcom@eletrans.cl', '56939140144', 'Av. Argentina N° 1', 'Valparaíso', 'Álvaro Arturo Alarcón Molina', 'Eletrans II S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (203, 'Gestel', '76.219.458-9', '', '7510307.0', 'Fabián Soto Ortega', 'fabian.soto@gestel.cl', '56229735473', 'Eliodoro Yañez 2979, oficina 101', 'Providencia', 'Fabián Soto Ortega', 'Gestel Ingeniería Limitada', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (204, 'Hidro Munilque SpA', '76.411.212-1', '', '', 'Luis Eugenio Olfos El Moro', 'eolfos@eic.cl', '56226829800', 'Presidente Errázuriz 3113', '', 'Rodrigo Acosta Searle', 'Hidro Munilque SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (205, 'Embalse Ancoa', '76.264.025-2', '', '', 'Tomas Fahrenkrog', 'tfahrenkrog@gpe.cl', '56229168200', 'Félix de Amesti 90. Oficina 201', 'Las Condes', 'María Luisa Orellana', 'Hidroeléctrica Embalse Ancoa SpA', 'Generador');
INSERT INTO public.reuc VALUES (206, 'Quinta Solar SpA', '76.470.584-K', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Quinta Solar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (207, 'San Francisco Solar SpA', '76.470.581-5', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'San Francisco Solar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (208, 'Santiago Solar S.A.', '76.378.017-1', '', '', 'Gabriela Melgar', 'melgar@ame.cl', '56228968900', 'Apoquindo 3472, piso 14, of. 1401', '', 'Francis Martinez', 'Santiago Solar S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (209, 'Sociedad Concesionaria Embalse Convento Viejo S.A.', '76.338.870-0', '', '', 'Alex Galleguillos Dubó', 'agalleguillos@ecv.cl', '', 'Puerta del Sol 55, Of. 51', '', 'Alex Galleguillos Dubó', 'Sociedad Concesionaria Embalse Convento Viejo S.A.', 'Generador');
INSERT INTO public.reuc VALUES (210, 'TEN', '76.787.690-4', '', '', 'David Lopez Cortón', 'david.lopez@redinter.company', '56227833338', 'Isidora Goyenechea 2800, Oficina 1601', 'Las Condes', 'Carlos Figueroa Montesinos', 'Transmisora Eléctrica del Norte S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (211, 'Valle de la Luna II', '76.477.447-7', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Valle de la Luna II SpA', 'PMGD');
INSERT INTO public.reuc VALUES (212, 'WPD Duqueco SpA', '76.560.824-4', '', '', 'Lutz Kindermann', 'l.kindermann@wpd.cl', '56227520570', 'Augusto Leguía Sur 160 Of 32', 'Las Condes', 'Felipe Rodriguez Chacón', 'WPD Duqueco SpA', 'Generador');
INSERT INTO public.reuc VALUES (213, 'WPD Malleco SpA', '76.311.929-7', '', '', 'Lutz Kindermann', 'l.kindermann@wpd.cl', '56227520570', 'Augusto Leguía Sur 160 Of 32', 'Las Condes', 'Felipe Rodriguez Chacón', 'WPD Malleco SpA', 'Generador');
INSERT INTO public.reuc VALUES (214, 'WPD Negrete SpA', '76.311.926-2', '', '', 'Lutz Kindermann', 'l.kindermann@wpd.cl', '56227520570', 'Augusto Leguía Sur 160 Of 32', 'Las Condes', 'Felipe Rodriguez Chacón', 'WPD Negrete SpA', 'Generador');
INSERT INTO public.reuc VALUES (215, 'Aguas Antofagasta', '76.418.976-0', '', '1240431.0', 'Mario Corvalan Neira', 'mcorvalan@aguasantofagasta.cl', '56552356700', 'Pedro Aguirre Cerda 6496', 'Antofagasta', 'Ivan Aballay', 'Aguas Antofagasta S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (216, 'Algorta', '76.000.957-1', '', '7550125.0', 'Juan Jose Besa Prieto ', 'jbesa@algortanorte.cl', '56225730600', 'Av. El Golf 99, Oficina 703', 'Las Condes', 'Juan Jose Besa Prieto ', 'Algorta Norte S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (217, 'Atacama Solar', '76.055.134-1', '', '7550248.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Atacama Solar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (218, 'Codelco', '61.704.000-K', '', '1394393.0', 'María Gabriela Campos Cereceda', 'mcamp044@codelco.cl', '56226903000', 'Huérfanos 1270', 'Santiago', 'Carolina Valderrama Campos', 'Codelco (Corporación Nacional del Cobre)', 'Transmisor Dedicado,Transmisor Nacional,Cliente Libre');
INSERT INTO public.reuc VALUES (219, 'Minera Cerro Colorado', '94.621.000-5', '', '', 'Cesar Gaete Alvarado', 'cesar.gaete@bhp.com', '56958175942', 'Camino a Mamiña S/N', 'Pozo Almonte', 'Francisco Allende Ramírez', 'Compañía Minera Cerro Colorado Ltda', 'Cliente Libre');
INSERT INTO public.reuc VALUES (220, 'Minera Collahuasi', '89.468.900-5', '', '', 'Jorge Gomez Diaz ', 'meyanez@collahuasi.cl', '56223626510', 'Av. Andrés Bello 2457, piso 39, Providencia', 'Santiago', 'Hero Morales Mancilla', 'Compañía Doña Inés de Collahuasi SCM', 'Generador,Cliente Libre,Transmisor Zonal');
INSERT INTO public.reuc VALUES (221, 'Minera Quebrada Blanca', '96.567.040-8', '', '1100324.0', 'Karl Hroza', 'karl.hroza@teck.com', '56224645704', 'Av. Apoquindo 3885, piso 7', 'Las Condes', 'Patricio Celis Morales', 'Compañía Minera Teck Quebrada Blanca S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (222, 'Minera Lomas Bayas', '78.512.520-7', '', '', 'Pablo Andrés Carvallo Quezada', 'pablo.carvallo@glencore.cl', '56552628712', 'Camino Minsal s/n Km. 36', '', 'Carlos Correa Recabal', 'Compañía Minera  Lomas Bayas', 'Cliente Libre');
INSERT INTO public.reuc VALUES (223, 'Minera Zaldívar', '76.485.762-3', '', '', 'Leonardo Emilio Gonzalez Alcayaga', 'lgonzalez@antucoya.cl', '56227987000', 'Av. Apoquindo 4001 piso 18', 'Las Condes', 'Bernardo Espina Adasme', 'Compañía Minera Zaldívar SpA', 'Cliente Libre');
INSERT INTO public.reuc VALUES (224, 'ECOMETALES', '59.087.530-9', '', '7510078.0', 'Oscar Augusto Castañeda Calderon', 'ocast024@ecometales.cl', '56223784100', 'Nueva de Lyon 72, piso 17, oficina 1701', 'Providencia', 'Javier Gonzalez Calderón', 'EcoMetales Limited, Agencia en Chile', 'Cliente Libre');
INSERT INTO public.reuc VALUES (686, 'PMGD Cauce Solar', '77.285.274-6', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Cauce Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (225, 'ETSA', '76.046.791-K', '', '', 'Rosaline Corinthien', 'anais.munier@engie.com', '56223533200', 'Isidora Goyenechea 2800, piso 16', 'Las Condes', 'Pablo Jorquera Riquelme', 'Edelnor Transmisión S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (226, 'Transemel', '96.893.220-9', '', '7561127.0', 'Rodrigo Andrés Guerrero Valenzuela', 'rodrigo.guerrero@transemel.cl', '56998795766', 'Av. Presidente Riesco 5561, piso 14', 'Las Condes', 'Camilo Sanhueza Bravo', 'Empresa de Transmisión Eléctrica Transemel S.A.', 'Transmisor Nacional,Transmisor Zonal');
INSERT INTO public.reuc VALUES (227, 'Angamos', '76.004.976-K', '', '7561185.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Empresa Eléctrica Angamos SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (228, 'Cochrane', '76.085.254-6', '', '7561185.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Empresa Eléctrica Cochrane SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (229, 'Enaex', '90.266.000-3', '', '', 'Juan Andes Errazuriz Dominguez ', 'ggeneral@enaex.cl', '56552353504', 'Av. Costanera Norte 300', 'Las Condes', 'German Lamas', 'Enaex S.A.', 'Transmisor Dedicado,Generador,Cliente Libre');
INSERT INTO public.reuc VALUES (230, 'Enernuevas', '76.045.491-5', '', '', 'Salvador Villarino Krumm ', 'carmen.orellana@aguasnuevas.cl', '56227334600', 'Isidora Goyenechea 3600, Piso 4, Santiago', 'Las Condes', 'Mauricio Contreras', 'Enernuevas S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (231, 'ENGIE', '88.006.900-4', '', '7550177.0', 'Rosaline Corinthien', 'anais.munier@engie.com', '56223533200', 'Isidora Goyenechea 2800, piso 16', 'Las Condes', 'Pablo Jorquera Riquelme', 'Engie Energía Chile S.A.', 'Transmisor Zonal,Generador,Transmisor Dedicado,Transmisor Nacional');
INSERT INTO public.reuc VALUES (232, 'Generación Solar SpA', '76.183.075-9', '', '1000000.0', 'CARLOS FERNANDO GARDEWEG RIED', 'fgr@agfweg.com', '56229491319', 'Los Conquistadores 1730, oficina 1001, piso 10', 'Providencia', 'Eliseo Lopez', 'Generación Solar SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (233, 'Grace', '99.565.400-8', '', '', 'Gonzalo Diestre', 'gonzalo.diestre@mantosdelaluna.cl', '56226767502', 'Av.Los Conquistadores 1700 Piso #13 Of.A Providencia', 'Providencia', 'Domingo Larrain Schacht', 'Grace S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (234, 'Haldeman', '96.955.560-3', '', '7550147.0', 'Jose Miguel Ibañez Anrique', 'jmibanez@haldeman.cl', '56228969121', 'Asturias 280, Oficina 401', 'Las Condes', 'Jorge Sougarret Larroquete', 'Haldeman Mining Company S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (235, 'Hornitos', '76.009.698-9', '', '1000000.0', 'Rosaline Corinthien', 'anais.munier@engie.com', '56223533200', 'Isidora Goyenechea 2800, piso 16', 'Las Condes', 'Pablo Jorquera Riquelme', 'Inversiones Hornitos SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (236, 'Minera Antucoya', '76.079.669-7', '', '', 'Leonardo Emilio Gonzalez Alcayaga', 'lgonzalez@antucoya.cl', '56227987000', 'Av. Apoquindo 4001 piso 18', 'Las Condes', 'Marelf Andres Reyes Faundez', 'Minera Antucoya', 'Cliente Libre');
INSERT INTO public.reuc VALUES (237, 'Minera Escondida', '79.587.210-8', '', '1271075.0', 'Ramon Cifuentes ', 'Ramon.a.cifuentes@bhpbilliton.com', '56552503560', 'Av La Mineria 501', 'Antofagasta', 'Ariel Leal', 'Minera Escondida Ltda.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (238, 'Minera Meridian', '96.508.670-6', '', '1240000.0', 'Sergio Castro Veas', 'sergio.castro@cl.panamericansilver.com', '56973770985', 'Av. Balmaceda 2472, piso 5', '', 'Eduardo Bartolo', 'Minera Meridian Ltda.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (239, 'Minera Spence', '86.542.100-1', '', '', 'Cristian Sandoval Gonzalez ', 'cristian.ca.sandoval@bhpbilliton.com', '56572404152', 'Esmeralda 340, piso 3', 'Iquique', 'Daniel Hoffmann', 'Minera Spence S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (240, 'Noracid', '76.858.530-K', '', '', 'Werner Watznauer ', 'wwatznauer@noracid.cl', '56552883801', 'Av EL Bosque Norte 500', 'Las Condes', 'Elio Barraza', 'Noracid S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (241, 'On-Group', '96.827.870-3', '', '7510006.0', 'Rene Valdes Aburto', 'rene.valdes@on-energy.cl', '56224815050', 'Holanda 099, Oficina 1202, Providencia', 'Providencia', 'Mauricio Esteban Gallardo Muñoz', 'On-Group S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (242, 'Los Puquios', '76.228.787-0', '', '7550206.0', 'Rolando Enrique Barreda Gallardo', 're.barreda@gmail.com', '56989697730', 'Camino de Pica km 27,9 La Huayca', '', 'Francisco Nadal Pastor', 'Parque Solar Los Puquios SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (243, 'PRM SpA', '76.255.054-7', '', '7561283.0', '', '', '', '', '', '', 'Planta Recuperadora de Metales SpA', 'Cliente Libre');
INSERT INTO public.reuc VALUES (244, 'Planta Solar San Pedro III', '76.175.454-8', '', '7560830.0', 'CARLOS FERNANDO GARDEWEG RIED', 'fgardewegr@wegcapital.cl', '56229491319', 'Los Conquistadores 1730, oficina 1001, piso 10', 'Providencia', 'Eliseo Lopez', 'Planta Solar San Pedro III SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (245, 'PAS1', '76.055.358-1', '', '7550024.0', 'Francisco Sebastián Méndez Cea', 'fsmendez@zelestra.energy', '56223358452', 'Isidora Goyenechea 2800', 'Las Condes', 'Ignacio León', 'Pozo Almonte Solar 1 SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (246, 'PAS2', '76.055.356-5', '', '7550024.0', 'Angel Francisco Truchero Angulo', 'atruchero@agr-am.com', '56223358452', 'Froilán Roa 6767, oficina 1305,', 'La Florida', 'Angel Francisco Truchero Angulo', 'Pozo Almonte Solar 2 S.A.', 'Generador');
INSERT INTO public.reuc VALUES (247, 'PAS3', '76.055.354-9', '', '7550024.0', 'Angel Francisco Truchero Angulo', 'atruchero@agr-am.com', '56223358452', 'Froilán Roa 6767, oficina 1305,', 'La Florida', 'Angel Francisco Truchero Angulo', 'Pozo Almonte Solar 3 S.A.', 'Generador');
INSERT INTO public.reuc VALUES (248, 'Sierra Gorda SCM', '76.081.590-K', '', '7550083.0', 'Tomasz Piwowarczyk', 'Tomasz.Piwowarczyk@sgscm.cl', '56552684383', 'Magdalena 140, Piso 10', 'Las Condes', 'Andrés Astudillo', 'Sierra Gorda SCM', 'Cliente Libre');
INSERT INTO public.reuc VALUES (249, 'STN S.A.', '76.410.374-2', '', '7550120.0', 'Francisco Alliende A.', 'rodrigo@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Juan Alfonso Veloso Molina', 'Sistema de Transmisión del Norte S.A.', 'Transmisor Nacional,Transmisor Zonal,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (250, 'Minera El Abra', '96.701.340-4', '', '1390000.0', 'Boris Medina Kirsten Medina Kirsten', 'bmedinak@fmi.com', '56552818713', 'Camino a Conchi Viejo Km 75, Calama', 'Calama', 'Cristian Figueroa', 'Sociedad Contractual Minera El Abra', 'Cliente Libre');
INSERT INTO public.reuc VALUES (251, 'GNLM', '76.775.710-7', '', '7550177.0', 'Gustavo Schettini', 'paulina.bown@gnlm.cl', '56223538806', 'Avda. Apoquindo 3721, piso 20', '', 'Daniel Garcia', 'Sociedad GNL Mejillones S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (252, 'SQM', '93.007.000-9', '', '7550081.0', 'Pablo Altimiras', 'Pablo.Altimiras@sqm.com', '56224252082', 'Los Militares 4290, Las Condes', 'Las Condes', 'Angelo Veroiza', 'Sociedad Química y Minera de Chile S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (253, 'Tamakaya Energía SpA', '76.349.223-0', '', '7560623.0', 'Christian Clavería Aliste', 'christian.claveria@bhpbilliton.com', '56225795000', 'Cerro El Plomo 6000, Piso 15, Las Condes', 'Las Condes', 'Carolina Andrea Hernández Díaz', 'Tamakaya Energía SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (254, 'Tecnet', '96.837.950-K', '', '1000000.0', 'Hernán Inostroza Godoy', 'hernan.inostroza@ezentis.cl', '56227702810', 'Las Hortensias 501', '', 'Javier Ignacio Alvarado Miranda', 'Tecnet S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (255, 'Transmisora Baquedano', '76.215.177-4', '', '8720046.0', 'Juan Carlos Albala', 'juan.albala@atlantica.com', '34618919091', 'Camino el Alba 9500, Torre B, 406', 'Santiago', 'Juan Carlos Albala', 'Transmisora Baquedano S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (256, 'Transmisora Mejillones', '76.215.036-0', '', '8720046.0', 'Juan Carlos Albala', 'juan.albala@atlantica.com', '34618919091', 'Camino el Alba 9500, Torre B, 406', 'Santiago', 'Juan Carlos Albala', 'Transmisora Mejillones S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (257, 'Altonorte', '88.325.800-2', '', '8330091.0', 'Juan Carrasco', 'juan.carrasco@glencore.cl', '56552628359', 'Calle 14 de Febrero N°2065, Piso N°7, Oficina 713, Edificio estudio 14, Antofagasta', 'Antofagasta', 'Marco Carrasco', 'Complejo Metalúrgico Altonorte S.A.', 'Transmisor Zonal,Cliente Libre,Transmisor Nacional');
INSERT INTO public.reuc VALUES (258, 'Divisadero', '76.438.021-5', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Divisadero SpA.', 'PMGD');
INSERT INTO public.reuc VALUES (259, 'Bio Energía Molina', '76.256.837-3', '', '7550173.0', 'Mauro Angel Aranda', 'mangel@biog.cl', '56932481403', 'Cerro El Plomo 5630, Of 1304', 'Las Condes', 'Bastián Osorio González', 'Bio Energía Molina SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (260, 'Parque Eólico Cabo Leones I', '76.166.466-2', '', '7561211.0', 'Roberto Sola Lacasa', 'rsl@grupoibereolica.com', '56223333540', 'Cerro El Plomo 5420, of. 1304', 'Las Condes', 'Héctor Andrés Astudillo Silva', 'Parque Eólico Cabo Leones I S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (261, 'RAGSA', '76.213.834-4', '', '5550000.0', 'Rosaline Corinthien', 'nora.calas@engie.com', '56223533200', 'Isidora Goyenechea 2800, piso 16', 'Las Condes', 'Pablo Jorquera Riquelme', 'Río Alto SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (262, 'El Arroyo', '76.362.268-1', '', '', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Empresa Eléctrica Tranquil SpA', 'PMGD');
INSERT INTO public.reuc VALUES (263, 'SATT', '76.519.747-3', '', '', 'Francisco Alliende A.', 'rodrigo@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Juan Alfonso Veloso Molina', 'Sociedad Austral de Transmisión Troncal S.A.', 'Transmisor Zonal,Transmisor Nacional,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (264, 'Enel Generación', '91.081.000-6', '', '', 'Maria Galainena De Carlos', 'maria.galainena@enel.com', '56973074210', 'Manuel Guzmán Maturana 1950', 'Lo Barnechea', 'Miguel Buzunariz Ramos', 'Enel Generación Chile S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (265, 'GR Araucaria', '76.461.936-6', '', '7550105.0', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'GR Araucaria SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (266, 'Hormiga Solar', '76.459.988-8', '', '1000000.0', 'Victor Rioseco Pino', 'vrioseco@auditcon.cl', '56752327995', 'Estado 213, of 306', 'Curicó', 'Victor Rioseco Pino', 'Hormiga Solar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (267, 'Bio Energía Los Pinos', '76.472.359-7', '', '', 'José Luis Navajas Rodriguez', 'jnavajas@cosemar.cl', '', 'Fundo El Laurel S/N KM 4 ruta Penco', '', 'Luis Alberto Wurth Olavarrieta', 'Bio Energía Los Pinos SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (268, 'Fotovoltaica Norte Grande 5', '76.213.045-9', '', '1000000.0', 'Carlos Salazar', 'carlos.salazar@x-elio.com', '56224344266', 'Calle Badajoz 130, Office 1401', 'Las Condes', 'Carlos Salazar', 'Fotovoltaica Norte Grande 5 SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (269, 'Aela Generación', '76.489.426-K', 'Reemplaza central PFV Salvador desde el 1 de octubre de 2022, según correspondencia DE04552-22, en repuesta a DE04102-22 ', '7560969.0', 'Jaime Pino', 'jpino@innergex.com', '56223787970', 'Isidora Goyenechea 3477, Of. 211, Piso 21', 'Las Condes', 'Carlos De la Fuente', 'Aela Generación S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (270, 'Generadora Piutel', '76.413.185-1', '', '', 'Michael Bregar', 'contacto@nanogener.cl', '', '', '', 'Claudio Carrasco Walker', 'Piutel Generación Eléctrica Limitada', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (271, 'Calama Solar 1', '76.044.597-5', '', '7550011.0', 'Francisco Sebastián Méndez Cea', 'fsmendez@zelestra.energy', '56223358452', 'Isidora Goyenechea 2800', 'Las Condes', 'Ignacio León', 'Calama Solar 1 SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (272, 'Bolero', '76.175.608-7', '', '7550105.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Bolero SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (273, 'Empresa Eléctrica Leonera', '76.427.560-8', '', '7500531.0', 'Pablo Benario', 'pbenario@eleonera.cl', '56224410155', 'Alfredo Barros Errázuriz 1954, Of. 702, Providencia.', 'Providencia', 'Víctor Manuel Salinas Barrera', 'Empresa Eléctrica La Leonera S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (274, 'Enerkey', '76.468.419-2', '', '7630329.0', 'Rodrigo Ackermann', 'rackermann@abrenergy.com', '56229536816', 'Eliodoro Yañez 2979, of. 709', 'Providencia', 'Alberto Chaigneau Alliende', 'Enerkey SpA', 'PMGD');
INSERT INTO public.reuc VALUES (275, 'Compañía Transmisora La Cebada (ex EPM Transmisión Chile S.A.)', '76.729.711-4', '', '1000000.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Juan Pablo Kindermann', 'Compañía Transmisora La Cebada S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (276, 'GR Canelo', '76.464.278-3', '', '7550105.0', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'GR Canelo SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (277, 'Río Colorado', '76.189.274-6', '', '7580124.0', 'Tomas Fahrenkrog', 'tfahrenkrog@gpe.cl', '56229168200', 'Félix de Amesti 90. Oficina 201', 'Las Condes', 'María Luisa Orellana', 'Hidroeléctrica Río Colorado S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (278, 'Portones (ex Hidroriñinahue S.A.)', '76.306.881-1', '', '1000000.0', 'Felipe Baraona Undurraga', 'fbarahona@triplei.cl', '56227060380', 'Av. Las Condes 11400, of 101. Vitacura', 'Vitacura', 'Cristian Del Sante', 'Los Portones S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (279, 'PMGD Chile Generación', '76.642.937-8', '', '8241801.0', 'Carlos Hernan Valledor Cavieres', 'cvalledor@pmgdchile.cl', '56942304537', 'García Hurtado de Mendoza 8266. La Florida', 'La Florida', 'Carlos Valledor Soto', 'PMGD Chile Generación Ltda.', 'PMGD');
INSERT INTO public.reuc VALUES (280, 'GDN', '96.971.330-6', '', '7561127.0', 'Viviana Meneses', 'viviana.meneses@enel.com', '', '', '', 'Miguel Buzunariz Ramos', 'Geotérmica del Norte S.A.', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (281, 'Minera Guanaco', '78.097.950-K', '', '', 'Patricio Illanes', 'patricio.illanes@australgold.com', '', '', '', 'Jorge Rojas', 'Guanaco Compañía Minera SpA', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (282, 'CYT Operaciones SpA', '76.248.725-K', '', '', 'Arturo Le Blanc Cerda', 'aleblanc@transelec.cl', '56224677001', 'Orinoco 90, piso 14', 'Las Condes', 'María José Reveco', 'CYT Operaciones SpA', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (283, 'Cleanairtech Sudamerica S.A.', '76.399.400-7', '', '', 'Hernán Patricio Aravena Noemí', 'hparavena@aguascap.cl', '56966063668', 'Ruta 5 norte Km 905', 'Caldera', 'Pablo Raúl Lorca Bruna', 'Cleanairtech Sudamérica S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (284, 'Minera Centinela', '76.727.040-2', '', '', 'Carlos Espinoza Durán', 'cespinozad@mineracentinela.cl', '56227988071', 'Apoquindo 4001, piso 18, Las Condes, Santiago.', '', 'Patricio Gutiérrez', 'Minera Centinela', 'Cliente Libre');
INSERT INTO public.reuc VALUES (285, 'Zaldívar Transmisión', '76.618.735-8', '', '', 'Leonardo Emilio Gonzalez Alcayaga', 'lgonzalez@antucoya.cl', '56227987000', 'Av. Apoquindo 4001 piso 18', 'Las Condes', 'Bernardo Espina Adasme', 'Zaldívar Transmisión S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (286, 'Don Goyo Transmisión S.A.', '76.695.118-K', 'Modificación de razón social de Don Goyo Transmisión S.A.  a Sonnedix Don Goyo Transmisión S.A según carta DE02293-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Don Goyo Transmisión S.A.', 'Transmisor Nacional,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (287, 'Dos Valles', '76.495.341-K', '', '7630479.0', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'Hidroelectrica Dos Valles SpA', 'PMG');
INSERT INTO public.reuc VALUES (288, 'Chester Solar IV', '76.440.337-1', '', '', 'Andres Yoon-Jung Ha Chun', 'a.hachun@s-energy.com', '56229935580', 'Cerro El Plomo 5420, oficina 402, Las Condes', 'Las Condes', 'Andres Yoon-Jung Ha Chun', 'Chester Solar IV SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (289, 'La Montaña2', '76.208.775-8', '', '', 'Victor Rioseco Pino', 'vrioseco@auditcon.cl', '56752327995', 'Estado 213, of 306', 'Curicó', 'Victor Rioseco Pino', 'Hidroeléctrica Río Claro S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (290, 'Socer S.A.', '76.475.862-5', '', '', 'Hector Sanhueza', 'hsanhueza@canalistasdellaja.cl', '56992217613', 'Av. Alemania 245', 'Los Ángeles', 'Juan Aranguiz', 'Socer S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (291, 'KELTI S.A.', '76.454.918-K', '', '', 'Christian Clavería Aliste', 'christian.claveria@bhpbilliton.com', '56225795000', 'Cerro El Plomo 6000, Piso 15, Las Condes', 'Las Condes', 'Carolina Andrea Hernández Díaz', 'KELTI S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (292, 'El Pelícano Solar Company', '76.337.599-4', '', '', 'Pablo Ceppi', 'pceppib@outlook.com', '56988392164', 'Los Militares 5885 Depto. 503,', 'Las Condes', 'Luis Elgueta', 'El Pelícano Solar Company SpA', 'Generador');
INSERT INTO public.reuc VALUES (293, 'Puerto Seco Solar', '76.044.602-5', '', '', 'Francisco Sebastián Méndez Cea', 'fsmendez@zelestra.energy', '56223358452', 'Isidora Goyenechea 2800', 'Las Condes', 'Ignacio León', 'Calama Solar 2 SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (294, 'CHATE', '76.260.825-1', '', '', 'Alan Heinen Alves Da Silva', 'alan.heinen@celeogroup.com', '56232024300', 'Apoquindo 4501, Oficina 1902', 'Las Condes', 'David Zamora Mesias', 'Charrúa Transmisora de Energía S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (295, 'El Manzano SpA', '76.459.845-8', '', '', 'Julio Lavín Retamal', 'jlavin@canalmaule.cl', '56712261661', 'Tres 1/2 Sur 2250, Of. 2', 'Talca', 'Julio Lavín Retamal', 'Central Hidroeléctrica El Manzano SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (296, 'La Manga Energy SpA', '76.505.372-2', '', '', 'Oscar Sanchez', 'ingenieria@valfortec.com', '34964062901', 'La Concepcion 81, oficina 608', 'Providencia', 'Oscar Sanchez', 'La Manga Energy SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (297, 'El Campesino I', '76.596.827-5', '-- Sin Comentarios --', '', 'Jaime Bascuñan', 'Jaime.Bascunan@aasa.cl', '56228323645', 'Viña el Campesino, parcela 6, S/N', 'Melipilla', 'Raul Flores', 'AASA Energía S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (298, 'Lipigas', '96.928.510-K', '', '', 'Angel Mafucci Solimano', 'alefort@lipigas.cl', '56226503506', 'Apoquindo 5400, piso 14', 'Las Condes', 'Rodrigo Garcia', 'Empresas Lipigas S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (299, 'DATE', '76.536.654-2', '', '', 'Alan Heinen Alves Da Silva', 'alan.heinen@celeogroup.com', '56232024300', 'Apoquindo 4501, Oficina 1902', 'Las Condes', 'David Zamora Mesias', 'Diego de Almagro Transmisora de Energía S.A.', 'Transmisor Zonal,Transmisor Nacional');
INSERT INTO public.reuc VALUES (300, 'QUEMCHI', '76.130.285-K', '', '', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Quemchi Generadora de Electricidad S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (301, 'El Sauce Chester Solar V', '76.466.854-5', '', '', 'Andres Yoon-Jung Ha Chun', 'a.hachun@s-energy.com', '56229935580', 'Cerro El Plomo 5420, oficina 402, Las Condes', 'Las Condes', 'Andres Yoon-Jung Ha Chun', 'Chester Solar V SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (302, 'CTNG', '76.680.107-2', '', '', 'Cristián Martínez Vergara', 'camartin@chilquinta.cl', '56322452026', 'Av. Argentina N° 1 Piso 7 Valparaiso', 'Valparaíso', 'Jaime Acevedo Salinas', 'Compañía Transmisora del Norte Grande S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (303, 'Amparo del Sol', '76.727.584-6', 'Cambio razón social según carta DE 06743-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Parque Solar Amparo del Sol SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (304, 'Central Hidroeléctrica Palacios', '76.585.842-9', '', '', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'Hidroeléctrica Palacios SpA', 'PMG');
INSERT INTO public.reuc VALUES (305, 'CH Santa Elena', '76.409.936-2', '', '7591092.0', 'Matías Guzman Honorato', 'mguzman@inverges.cl', '56999399015', 'Las Condes 9460', 'Las Condes', 'José Tomás Urzúa González', 'Central Hidroeléctrica Santa Elena S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (306, 'La Acacia', '76.503.259-8', '', '', 'Sin Young Han', 'hans@s-energy.com', '56999669388', 'Los Militares 6191, Of 32', '', 'Sin Young Han', 'La Acacia SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (307, 'Edelmag S.A.', '88.221.200-9', '', '', 'RODRIGO PARRAGUEZ CÓRDOVA', 'rmparraguezc@edelmag.cl', '+56 61271401', 'Croacia 444', 'Punta Arenas', 'Karen Isabel Chavez Arteaga', 'Empresa Eléctrica de Magallanes S.A.', 'Transmisor Zonal SSMM,Generador SSMM,Distribuidoras SSMM (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (308, 'Parque Eólico Cabo Negro', '76.180.803-6', '', '', 'Pablo Benario', 'pbenario@eleonera.cl', '56224410155', 'Alfredo Barros Errázuriz 1954, Of. 702, Providencia.', 'Providencia', 'Víctor Manuel Salinas Barrera', 'Pecket Energy S.A.', 'Generador SSMM');
INSERT INTO public.reuc VALUES (309, 'Central Trincao', '76.335.523-3', '', '', 'Enrique Ramírez Díaz', 'enrique.ramirez@mbi.cl', '56226553700', 'Av. Presidente Riesco 5711, Of, 401', 'Las Condes', 'Felipe Ignacio Martínez Illanes', 'Energía Siete SpA', 'Generador');
INSERT INTO public.reuc VALUES (310, 'PFV Nuevo Quillagua', '76.137.696-9', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Miguel Ángel Alarcón González', 'Parque Fotovoltaico Nuevo Quillagua SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (311, 'MINICENTRALES ARAUCANÍA', '76.470.281-6', '', '', 'Nikolaus Thomas Reisky Von Dubnitz', 'nr@araucaniapower.com', '56985810143', 'Casilla 59 Villarrica  (Camino Villarrica - Pucón km 4,5 P21)', 'Villarica', 'Nikolaus Thomas Reisky Von Dubnitz', 'Minicentrales Araucanía S.A.', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (312, 'Transelec Concesiones', '76.524.463-3', '', '', 'Arturo Le Blanc Cerda', 'aleblanc@transelec.cl', '56224677001', 'Orinoco 90, piso 14', 'Las Condes', 'María José Reveco', 'Transelec Concesiones S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (313, 'Energen', '76.683.713-1', '', '', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Energía Generación SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (314, 'Rigel', '76.786.225-3', '', '7510121.0', 'Felipe Cosmelli', 'fcosmelli@orion-power.com', '56222332463', 'Av. Providencia 2133, of. 710', 'Providencia', 'Ismael Mena Valdés', 'Rigel SpA', 'PMGD');
INSERT INTO public.reuc VALUES (315, 'Parque Fotovoltaico Ocoa', '76.451.022-4', '', '7630713.0', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Parque Fotovoltaico Ocoa SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (316, 'Parque Solar Santa Laura', '76.727.583-8', '', '', 'Jorge Leal', 'leal@pvpower.cz', '56993325627', 'Tabancura 1091, Of 324', 'Vitacura', 'Lorenzo Urrutia Parra', 'Parque Solar Santa Laura SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (317, 'Transrucatayo', '76.083.665-6', '', '7550000.0', 'María Teresa Gonzalez', 'contacto@statkraft.com', '56225929200', 'Vitacura 2969, Oficina 701', 'Las Condes', 'CARLOS MANTE', 'Transrucatayo S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (318, 'Central Cortes', '76.618.676-9', '', '', 'Dylan Rudney', 'dylan@veranocapital.com', '56227239441', 'Av. Andrés Bello 2687, oficina 1004', 'Las Condes', 'Rodrigo Daza Ibar', 'Mocho Energy SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (319, 'La Calera', '76.267.761-K', '', '', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Generadora la Calera SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (320, 'PMGD Catan Solar', '76.416.516-0', '', '', 'Frederic Nuñez', 'f.nunez@langa-international.com', '', '', '', 'Andrés Caviedes Arévalo', 'Planeta Investments SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (321, 'Transmisora Angamos', '76.680.114-5', '', '', 'Vicente Javier Giorgio', 'javier.giorgio@aes.com', '56226868900', 'Rosario Norte 532, Piso 19', 'Las Condes', '', 'Compañía Transmisora Angamos SpA', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (322, 'Hidroelectrica Maisan', '76.319.759-K', '', '', 'Bautista Bosch Ostale', 'bautista.bosch@enerbosch.cl', '56222455946', 'Manquehue Sur 520, of 320', 'Las Condes', 'Bautista Bosch Ostale', 'Hidroeléctrica Maisán SpA', 'PMGD');
INSERT INTO public.reuc VALUES (323, 'Línea Cabo Leones', '76.429.813-6', '', '', 'Charles Naylor Del Río', 'charles.naylor@saesa.cl', '56224147500', 'Av. La Dehesa 1822, oficina 611', '', 'Juan Alfonso Veloso Molina', 'Línea de Transmisión Cabo Leones S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (324, 'Atria', '76.827.288-3', 'Reemplaza a EBCO Energía S.A. c/r PMGD Quillaileo', '', 'José Balta', 'jbalta@atriacorp.com', '56229521802', 'Cerro el Plomo 5260, Torre B, Of 1101', 'Las Condes', 'Christian Flores Rubilar', 'Atria Energía SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (325, 'PMGD Alicahue', '76.813.197-K', '', '', 'María Eugenia Orellana', 'maria-eugenia.orellana@totalenergies.com', '56962188290', 'Av Apoquindo 4820, piso 11', 'Las Condes', 'Jose Chahuan', 'Parque Fotovoltaico Alicahue Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (327, 'ENTEL PCS S.A.', '96.806.980-2', '', '', 'Antonio Büchi Buc', 'rrgarcia@entel.cl', '56223651000', 'Avda. Costanera Sur Río Mapocho 2760, Piso 22, Torre C', 'Santiago', 'Antonio Büchi Buc', 'ENTEL PCS Telecomunicaciones S.A.', 'Transmisor Dedicado,Cliente Libre');
INSERT INTO public.reuc VALUES (328, 'Parque Eólico Punta Sierra', '76.547.592-9', '', '', 'Renzo Valentino', 'rvalentino@pacifichydro.cl', '56225194200', 'Av. Isidora Goyenechea 3520 piso 10', 'Las Condes', 'Luis Osvaldo Nuñez Herrera', 'Pacific Hydro Punta Sierra SpA', 'Generador');
INSERT INTO public.reuc VALUES (329, 'PMGD Diego de Almagro', '76.071.634-0', '', '', 'Andres Yoon-Jung Ha Chun', 'a.hachun@s-energy.com', '56229935580', 'Cerro El Plomo 5420, oficina 402, Las Condes', 'Las Condes', 'Andres Yoon-Jung Ha Chun', 'Diego de Almagro Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (330, 'Generadora Metropolitana', '76.538.731-0', '', '', 'Diego Hollweck', 'dhollweck@generadora.cl', '56223911100', 'Apoquindo 3472, Oficina 1301', 'Las Condes', 'Carolina Vélez', 'Generadora Metropolitana SpA', 'Generador');
INSERT INTO public.reuc VALUES (331, 'Red Eléctrica del Norte 2 S.A.', '76.896.732-6', '', '', 'David Lopez Cortón', 'david.lopez@redinter.company', '56227833338', 'Isidora Goyenechea 2800, Oficina 1601', 'Las Condes', 'José Gastón Muñoz Cabezas', 'Red Eléctrica del Norte 2 S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (332, 'PMGD Fotovolt Solar I', '77.320.900-6', '', '', 'Christian Kast Rist', 'mkast@bavaria.cl', '56223553930', 'Estado 42, oficina 405', 'Santiago', 'Raul Flores', 'Fotovolt Energía Ltda', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (333, 'Coopersol', '74.379.600-4', '', '', 'Nemesio Alejandro Bolaños Gutierrez', 'nbolanos@coopersol.cl', '56582258161', 'Cristobal Colon N° 779', 'Arica', 'Nemesio Alejandro Bolaños Gutierrez', 'Cooperativa de Abastecimiento de Energía Eléctrica Socoroma Ltda', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (334, 'Safira Energia', '76.832.212-0', '', '', 'Vantuil Ribeiro', 'ribeiro@safiraenergia.cl', '56922145994', 'Orinoco 90, piso 21, oficina 2145', 'Las Condes', 'Juan Pablo Tapia Rojas', 'Safira Energía Chile SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (335, 'Empresa de prueba REUC', '11.111.110-3', 'Empresa de prueba, para uso interno', '', '', '', '', '', '', 'Brigida Fernandez', 'Empresa de prueba REUC', 'PMGD');
INSERT INTO public.reuc VALUES (336, 'EPASA', '76.679.610-9', '', '', 'Jose Arosa', 'jose.arosa@enfragen.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Empresa Eléctrica Cuchildeo SpA', 'Generador SSMM');
INSERT INTO public.reuc VALUES (337, 'Abastible', '91.806.000-6', '', '', 'Joaquín Cruz Sanfiel', 'area.electrica@abastible.cl', '56226939000', 'Av. Apoquindo 5550, Piso 11', 'Las Condes', 'Jorge Bustamante', 'Abastible S.A.', 'Generador');
INSERT INTO public.reuc VALUES (338, 'Tacora Energy', '76.618.682-3', '', '', 'Dylan Rudney', 'racevedo@veranocapital.com', '56227239441', 'Av. Andrés Bello 2687, oficina 1004', 'Las Condes', 'Rodrigo Daza Ibar', 'Tacora Energy SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (339, 'PMGD Mimbre', '76.761.555-8', '', '', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Generadora Mimbre SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (340, 'Punta Baja', '76.383.031-4', 'Cambio razón social según carta DE 06746-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Parque Solar Punta Colorada SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (341, 'PMGD Talhuén (ex propiedad de Rigel SpA)', '76.948.177-K', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Reden Talhuen Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (342, 'PMGD Cabildo (ex propiedad de Rigel SpA)', '76.948.169-9', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Reden Cabildo Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (343, 'PMGD Luna', '76.522.004-1', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Luna Energy SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (344, 'Calle Larga', '76.863.375-4', '', '', 'Sven Gysling Brinkmann', 'sven@ienergiagroup.com', '56226241971', 'Américo Vespucio 2680, oficina 111', 'Conchalí', 'Sven Gysling Brinkmann', 'PMGD Calle Larga SpA', 'PMGD');
INSERT INTO public.reuc VALUES (345, 'PMGD Mauco', '76.450.335-K', '', '', 'David Orellana', 'david.orellana@aedilestalinay.com', '56229951065', 'Alonso de Córdova 5670, Oficina 503', 'Las Condes', 'Gonzalo Menares', 'PMGD Mauco SpA', 'PMGD');
INSERT INTO public.reuc VALUES (346, 'Zapallar', '76.780.597-7', '', '', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Generadora Zapallar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (347, 'PMGD Santa Clara', '76.513.574-5', '', '', 'Santiago Rull Cullen', 'chapeana@disagrupo.es', '34922238700', 'Cerro el Plomo 5420 oficina 903', 'Las Condes', 'Joaquín Gurriarán Florido', 'Impulso Solar Las Lloysas SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (348, 'Parque Fotovoltaico Pirque', '76.574.682-5', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Solar TI Cuatro SpA', 'PMGD');
INSERT INTO public.reuc VALUES (349, 'Fotovoltaica Ariztía', '76.727.409-2', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Fotovoltaica Ariztía SpA', 'PMGD');
INSERT INTO public.reuc VALUES (350, 'Torino', '76.756.795-2', '', '', 'Robinson Paz Grez', 'r.paz@siedchile.cl', '56232038980', 'Av. Vitacura 2969, of. 901', 'Las Condes', 'Carlos Alejandro Galaz Springer', 'Torino SpA', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (351, 'PMGD El Laurel', '76.519.771-6', '', '', 'Andres Yoon-Jung Ha Chun', 'a.hachun@s-energy.com', '56229935580', 'Cerro El Plomo 5420, oficina 402, Las Condes', 'Las Condes', 'Andres Yoon-Jung Ha Chun', 'Laurel SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (352, 'H6', '76.795.518-9', '', '', 'Oscar Sanchez', 'ingenieria@valfortec.com', '34964062901', 'La Concepcion 81, oficina 608', 'Providencia', 'Oscar Sanchez', 'Parque Solar H6 SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (353, 'Eléctrica El Arrebol', '76.415.299-9', '', '', 'Paulo Bezanilla Saavedra ', 'op.energia@besalco.cl', '56223312200', 'Av. Tajamar N°183, oficina 301, Las Condes', '', 'Jonathan Cardenas Parra', 'Empresa Eléctrica El Arrebol SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (354, 'GR Santa Rosa', '76.461.944-7', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'GR Chaquihue SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (355, 'Santa Adriana', '76.813.193-7', '', '', 'María Eugenia Orellana', 'maria-eugenia.orellana@totalenergies.com', '56962188290', 'Av Apoquindo 4820, piso 11', 'Las Condes', 'Jose Chahuan', 'Parque Fotovoltaico Santa Adriana SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (356, 'El Nogal', '76.430.139-0', '', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Parque Eólico el Nogal SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (357, 'Tricahue Solar SpA', '76.136.448-0', '', '7550011.0', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Tricahue Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (358, 'Huatacondo', '76.337.593-5', '', '', 'Yukihiro Funamoto', 'es-americas@sojitz.com', '56932326693', 'Magdalena 140, oficina 1301', 'Las Condes', 'Gustavo Reina', 'AustrianSolar Chile Cuatro SpA', 'Generador');
INSERT INTO public.reuc VALUES (359, 'Casuto', '76.585.782-1', '', '7550011.0', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Solar TI Diez SpA', 'PMGD');
INSERT INTO public.reuc VALUES (360, 'PMGD Solar Los Perales I', '76.786.344-6', '', '', 'Luis Daniel Palma Peñaloza', 'dpalma@grupodyg.cl', '56222724742', 'Eduardo Castillo Velasco 4890', 'Ñuñoa', 'Carlos Carmona', 'PMGD Solar Los Perales I SpA', 'PMGD');
INSERT INTO public.reuc VALUES (361, 'Hidroenersur', '76.003.174-7', 'Reemplazo Cumbres SpA en carta DE00420-22', '', 'Robinson Paz Grez', 'r.paz@siedchile.cl', '56232038980', 'Av. Vitacura 2969, of. 901', 'Las Condes', 'Carlos Alejandro Galaz Springer', 'Hidroenersur SpA', 'PMGD,PMG,Generador');
INSERT INTO public.reuc VALUES (362, '', '', 'Cambio razón social según carta DE05232-24', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (363, 'RLA Solar', '76.738.882-9', '', '', 'María Eugenia Orellana', 'maria-eugenia.orellana@totalenergies.com', '56962188290', 'Av Apoquindo 4820, piso 11', 'Las Condes', 'Jose Chahuan', 'RLA Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (364, 'La Lajuela', '76.948.175-3', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Reden La Lajuela Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (365, 'Hidropalmar', '76.065.092-7', 'Cambio razón social según carta DE05110-24', '', 'Robinson Paz Grez', 'r.paz@siedchile.cl', '56232038980', 'Av. Vitacura 2969, of. 901', 'Las Condes', 'Carlos Alejandro Galaz Springer', 'Hidropalmar SpA', 'PMG');
INSERT INTO public.reuc VALUES (366, 'PMGD Talca', '76.466.857-K', '', '', 'Andres Yoon-Jung Ha Chun', 'a.hachun@s-energy.com', '56229935580', 'Cerro El Plomo 5420, oficina 402, Las Condes', 'Las Condes', 'Andres Yoon-Jung Ha Chun', 'Santa Catalina Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (367, 'Parsosy Illapel 5', '76.557.855-8', 'Cambio razón social según carta DE 06747-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Parsosy Illapel 5 SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (368, 'Las Codornices', '76.937.187-7', 'Cambio razón social según carta DE 06741-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Las Codornices SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (369, 'Joaquín Solar', '76.528.804-5', 'Cambio razón social según carta DE06738-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Joaquín Solar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (370, 'Ángela Solar', '76.503.519-8', 'Cambio razón social según carta DE06961-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Ángela Solar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (371, 'PFV José Soler Mallafré', '76.954.708-8', '', '', 'Luis Alejandro Toledo Moreno', 'alejandro.toledo@gencec.cl', '56752310389', 'Avda. Camilo Henríquez 153', 'Curicó', 'Luis Alejandro Toledo Moreno', 'FV Santa Laura SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (372, 'Tucúquere', '76.815.726-K', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Tucuquere SpA', 'PMGD');
INSERT INTO public.reuc VALUES (373, 'PFV Las Perdices', '76.945.275-3', 'Cambio razón social según carta DE 00201-25', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Las Perdices SpA', 'PMGD');
INSERT INTO public.reuc VALUES (374, 'PMGD Luce Solar', '76.515.795-1', '', '', 'María Eugenia Orellana', 'maria-eugenia.orellana@totalenergies.com', '56962188290', 'Av Apoquindo 4820, piso 11', 'Las Condes', 'Jose Chahuan', 'Luce Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (375, 'Doña Javiera Valledor', '77.027.333-1', '', '', 'Carlos Hernan Valledor Cavieres', 'carlosvalledor@gmail.com', '56942304537', 'García Hurtado de Mendoza 8266. La Florida', 'La Florida', 'Carlos Hernan Valledor Cavieres', 'Doña Javiera Valledor SpA', 'PMGD');
INSERT INTO public.reuc VALUES (376, 'Calfuco', '76.780.605-1', '', '', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Generadora Azul SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (377, 'Las Lechuzas', '76.948.419-1', '', '', 'José Patricio Lagos Cisterna', 'plagos@copelec.cl', '56422204412', '18 de Septiembre 688, Chillán', 'Chillán', 'Iván Fuentealba Carrasco', 'PFV Las Lechuzas SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (378, 'INERSA (Central Teno)', '76.616.538-9', '', '', 'Vicente Ariztia Leniz', 'variztia@gasco.cl', '56222222222', 'Santo Domingo 1061', 'Santiago', 'José Nicolás Arroyo Sáez', 'Innovación Energía S.A.', 'Generador');
INSERT INTO public.reuc VALUES (379, 'PMGD LA LIGUA', '76.419.748-8', '', '', 'Luis Alberto Akel Valech', 'alberto@pkr.cl', '56229190786', 'Av. Las Tranqueras 285', '', 'Ricardo Sylvester Zapata', 'Illalolen S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (380, 'Cerro Dominador CSP S.A. (Fusión con Atacama Generación Chile)', '76.237.256-8', '', '', 'Pablo Lisandro Cavallaro', 'pablo.cavallaro@grupocerro.com', '56224887300', 'Isidora Goyenechea 2800 Oficina 2501', 'Las Condes', 'Sebastián Parra', 'Cerro Dominador CSP S.A.', 'Generador');
INSERT INTO public.reuc VALUES (381, 'Fotovoltaica Algarrobo', '76.850.028-2', 'Cambio razón social según carta DE06739-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Fotovoltaica Algarrobo SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (382, 'COPIULEMU 1', '76.732.233-K', '', '7550260.0', 'Gonzalo Rojas López', 'gonzalo.rojas@encenergy.com', '56974518625', 'Isidora Goyenechea 3000 Of.2302', 'Las Condes', 'Gonzalo Rojas López', 'Duero Energía Copiulemu SpA', 'PMGD');
INSERT INTO public.reuc VALUES (383, 'PE El Maitén', '76.460.012-6', '', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Parque Eólico El Maitén SpA', 'Generador');
INSERT INTO public.reuc VALUES (384, 'Vientos de Renaico', '76.266.502-6', '', '', 'Patricio Javier Guzmán Henzi', 'pguzmanh@agrosisa.cl', '56432363302', 'San Martín 495', '', 'Luis Ljubetic', 'Vientos de Renaico SpA', 'Generador');
INSERT INTO public.reuc VALUES (385, 'Bellavista 1', '76.055.368-9', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Tamarugal Solar 1 S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (386, 'PFV Ñiquén', '76.683.541-4', '', '', 'Frederic Nuñez', 'f.nunez@langa-international.com', '', '', '', 'Andrés Caviedes Arévalo', 'Maitén SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (387, 'Tolchen', '76.389.448-7', '', '', 'Francisco Alliende A.', 'francisco.alliende@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Juan Alfonso Veloso Molina', 'Tolchén Transmisión SpA', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (388, 'Citrino', '76.727.518-8', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Solar TI Once SpA', 'PMGD');
INSERT INTO public.reuc VALUES (389, 'Pilpilén', '76.738.655-9', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Pilpilén SpA', 'PMGD');
INSERT INTO public.reuc VALUES (390, 'Eclipse Solar', '76.505.367-6', '', '', 'María Eugenia Orellana', 'maria-eugenia.orellana@totalenergies.com', '56962188290', 'Av Apoquindo 4820, piso 11', 'Las Condes', 'Jose Chahuan', 'Eclipse Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (391, 'PMGD EL ESTERO', '76.404.001-5', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Fotovoltaica El Manzano SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (392, 'Calafate', '76.920.956-5', '', '', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Generadora Calafate SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (393, 'Fotovoltaica Acacia SpA', '76.810.311-9', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Fotovoltaica Acacia SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (394, 'PMGD El Cóndor', '76.967.538-8', '', '', 'Luis Alejandro Toledo Moreno', 'alejandro.toledo@gencec.cl', '56752310389', 'Avda. Camilo Henríquez 153', 'Curicó', 'Kadir Andres Ruiz Novoa', 'PFV El Cóndor SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (395, 'GR Tamarugo (Rinconada)', '76.451.219-7', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'GR Tamarugo SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (396, 'EELC SpA', '76.493.739-2', '', '', 'Jose Luis Mandiola', 'jlmandiola@mcapital.cl', '56995105747', 'Cruz del Sur 399 - depto 305', 'Las Condes', 'Jose Luis Mandiola', 'Empresa Eléctrica La Compañía SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (397, 'Moncuri', '76.729.924-9', '', '', 'Felipe Roberto Sepúlveda Lepe', 'contacto@moncuri.cl', '', '', '', 'Matías Alejandro Burton Hormazabal', 'Konda Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (398, 'Fotovoltaica Mañio SpA', '76.863.475-0', '', '', 'Tomas Herzfeld', 'tomas.herzfeld@gestionsolar.cl', '56223441024', 'Malaga 85, of 216', 'Las Condes', 'Tomas Herzfeld', 'Fotovoltaica Mañio SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (399, 'PMGD Catemu', '76.576.597-8', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Parque Solar Catemu SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (400, 'Las Chacras Energy SpA', '76.863.481-5', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Las Chacras Energy SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (401, 'Planta FV María Pinto', '76.979.116-7', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'PFV María Pinto SpA', 'PMGD');
INSERT INTO public.reuc VALUES (402, 'Fotovoltaica La Ligua SpA', '76.758.664-7', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Fotovoltaica La Ligua SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (403, 'Trica-Dos', '76.902.134-5', '', '7550011.0', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Tricahue SpA', 'PMGD');
INSERT INTO public.reuc VALUES (404, 'Planta FV El Chucao', '76.982.022-1', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'PFV El Chucao SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (405, 'PMGD Jahuel', '76.440.329-0', '', '', 'Andres Yoon-Jung Ha Chun', 'a.hachun@s-energy.com', '56229935580', 'Cerro El Plomo 5420, oficina 402, Las Condes', 'Las Condes', 'Andres Yoon-Jung Ha Chun', 'Chester Solar I SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (406, 'MGM Innova', '76.686.377-9', '', '', 'Catalina Botero Garcia', 'contabilidadchile@mgminnovacap.com', '56963571809', 'Suecia 1818, Dpto 601', 'Providencia', 'Catalina Botero Garcia', 'MGM Innova Capital Chile SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (407, 'Covadonga', '76.866.361-0', '', '7561211.0', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Chungungo Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (408, 'Energía Eólica Mesamávida SpA', '76.868.991-1', '', '', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Energía Eólica Mesamávida SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (409, 'Don Mariano Energy', '76.807.996-K', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Don Mariano Energy SpA', 'PMGD');
INSERT INTO public.reuc VALUES (410, 'EMOAC', '76.208.888-6', '', '', 'Vannia Toro Blanca', 'vannia@emoac.cl', '56229860979', 'Isidora Goyenechea 2800, Oficina 2301', 'Las Condes', 'César Smith', 'EMOAC SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (411, 'La Chimba Bis', '76.242.067-8', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'La Chimba Bis SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (412, 'Tolpán Sur', '76.412.275-5', '', '', 'Jaime Toledo Ruiz', 'jatoledor@acciona.com', '56226308319', 'Av. Santa Rosa 76, Piso 11', 'Santiago', 'Javier Toro Cabrera', 'Tolpán Sur SpA', 'PMGD');
INSERT INTO public.reuc VALUES (413, 'ISER', '76.825.044-8', '', '', 'Luz Elena Noé Valencia', 'luz.noe@atco.com', '525578229121', 'Av. El Bosque Central 92, Piso 8', 'Las Condes', 'Luz Elena Noé Valencia', 'Impulso Solar El Resplandor SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (414, 'Energy Asset', '76.996.007-4', '', '', 'Miguel Iglesias Hurtubia', 'miguel.iglesias@energyasset.cl', '56981824935', 'Av. José Alcalde Délano 10545, Oficina 413.', 'Lo Barnechea', 'Miguel Iglesias Hurtubia', 'Energy Asset SpA', 'PMGD');
INSERT INTO public.reuc VALUES (415, 'Alto Cautín', '76.044.129-5', '', '', 'Bernhard Stohr ', 'bernhard.stohr@agrisol.cl', '56223554900', 'Monseñor Sotero Sanz 267, Providencia', 'Providencia', 'Jordan Perez', 'Alto Cautín SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (416, 'Hidromocho', '76.376.443-5', '', '', 'Robinson Paz Grez', 'r.paz@siedchile.cl', '56232038980', 'Av. Vitacura 2969, of. 901', 'Las Condes', 'Robinson Paz Grez', 'Hidromocho S.A.', 'Generador');
INSERT INTO public.reuc VALUES (417, 'Betel', '77.050.429-5', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Betel SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (418, 'Parque Eólico Cabo Leones III', '76.202.069-6', '', '', 'Guillermo David Dunlop Llorens', 'gdl@grupoibereolica.com', '56223333540', 'Cerro el Plomo 5420, Oficina 1305', 'Las Condes', 'Héctor Andrés Astudillo Silva', 'PE Cabo Leones III SpA', 'Generador');
INSERT INTO public.reuc VALUES (419, 'GR Guindo', '76.722.031-6', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'GR Guindo SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (420, 'Sonnedix La Serena', '77.131.323-K', '', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix La Serena SpA', 'PMGD');
INSERT INTO public.reuc VALUES (421, 'Sol de Septiembre', '76.719.826-4', '', '', 'Ana Ruiz Portillo', 'ana.ruiz@nextenergycapital.com', '34919613784', 'Avenida de Vitacura, 1201', 'Las Condes', 'Adriana Barua', 'Sol de Septiembre SpA', 'PMGD');
INSERT INTO public.reuc VALUES (422, 'Granada', '76.727.405-K', '', '', 'Frederic Nuñez', 'f.nunez@langa-international.com', '', '', '', 'Andrés Caviedes Arévalo', 'Granada SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (423, 'PMGD Victoria Solar', '76.503.514-7', 'Cambio razón social según carta DE 06748-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Victoria Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (424, 'Cocharcas', '76.807.947-1', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Fotovoltaica Alfa SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (425, 'PFV Las Tortolas', '77.047.895-2', '', '', 'José Patricio Lagos Cisterna', 'plagos@copelec.cl', '56422204412', '18 de Septiembre 688, Chillán', 'Chillán', 'Iván Fuentealba Carrasco', 'PFV Las Tortolas SpA', 'PMGD');
INSERT INTO public.reuc VALUES (426, 'REDENOR', '76.766.227-0', '', '', 'David Lopez Cortón', 'david.lopez@redinter.company', '56227833338', 'Isidora Goyenechea 2800, Oficina 1601', 'Las Condes', 'José Gastón Muñoz Cabezas', 'Red Eléctrica del Norte S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (427, 'Dataluna', '76.117.026-0', '', '', 'Eduardo Nusser', 'enusser@google.com', '56226187170', 'El molino 2130', 'Quilicura', 'Eduardo Nusser', 'Inversiones y Servicios Dataluna LTDA', 'Cliente Libre');
INSERT INTO public.reuc VALUES (428, 'Playero', '77.084.483-5', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Playero SpA', 'PMGD');
INSERT INTO public.reuc VALUES (429, 'Pelequén Sur', '76.579.092-1', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Pelequén Sur SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (430, 'Lirio de Campo Solar', '76.462.043-7', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Lirio de Campo Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (431, 'Parque Eólico Cabo Leones II', '76.202.178-1', '', '', 'JOSE ANTONIO OSORIO DEL OLMO', 'jaosoriod@globalpower-generation.com', '56988223371', 'Avenida Los Militares 5830 OF 1103', 'Las Condes', 'JOSE ANTONIO OSORIO DEL OLMO', 'Ibereólica Cabo Leones II S.A.', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (432, 'Quillay Solar', '76.462.053-4', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Quillay Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (433, 'Incahuasi Energy', '76.618.674-2', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Incahuasi Energy SpA', 'PMGD');
INSERT INTO public.reuc VALUES (434, 'Bluegate SpA', '77.084.667-6', '', '', 'Luis Alfonso Llanos Collado', 'luis.llanos@matrizenergia.cl', '', '', '', 'Javier Rojas H.', 'Bluegate Energía SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (435, 'Vientos Patagónicos', '76.942.837-2', '-- Sin Comentarios --', '', 'Mario Tellez', 'mtellez@enap.cl', '56222803523', 'Apoquindo 2929, Piso 5', 'Las Condes', 'David Labra', 'Vientos Patagónicos SpA', 'Generador SSMM');
INSERT INTO public.reuc VALUES (436, 'Candelaria Solar', '76.522.139-0', '', '', 'José Luis Barrientos', 'jlbarrientos@greenvestment.cl', '56944966044', 'Camino Turístico Sur 11908. D 47', 'Lo Barnechea', 'José Luis Barrientos', 'Candelaria Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (437, 'PMGD Los Tilos', '76.957.549-9', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Parque Fotovoltaico Ocoa II SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (438, 'Prime Energía Quickstart', '76.452.055-6', '', '', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Prime Energía Quickstart SpA', 'Generador');
INSERT INTO public.reuc VALUES (439, 'STC', '76.440.111-5', '', '', 'Francisco Alliende A.', 'rodrigo@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Juan Alfonso Veloso Molina', 'Sistema de Transmisión del Centro S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (440, 'Puente Solar', '77.084.987-K', '', '', 'Sven Gysling Brinkmann', 'sven@ienergiagroup.com', '56226241971', 'Américo Vespucio 2680, oficina 111', 'Conchalí', 'Sven Gysling Brinkmann', 'PMGD Puente SpA', 'PMGD');
INSERT INTO public.reuc VALUES (441, 'PFV Las Torcazas', '77.011.978-2', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'PFV Las Torcazas SpA', 'PMGD');
INSERT INTO public.reuc VALUES (442, 'Parque Solar Bicentenario', '76.879.366-2', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Fotovoltaica Solar Laurel SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (443, 'PSF El Salitral', '76.284.904-6', '', '', 'Alfonso Izquierdo Irarrázaval', 'aizquierdo@menchaca.cl', '56223902200', 'Mar del Plata 2111, Providencia, Santiago, Chile', 'Providencia', 'Luis Ljubetic', 'PSF El Salitral S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (444, 'Entel', '92.580.000-7', '', '', 'Antonio Büchi Buc', 'rrgarcia@entel.cl', '56223651000', 'Avda. Costanera Sur Río Mapocho 2760, Piso 22, Torre C', 'Santiago', 'Antonio Büchi Buc', 'Empresa Nacional de Telecomunicaciones S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (445, 'Agrosolar IV', '76.363.219-9', '', '7550099.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Agrosolar IV SpA', 'PMGD');
INSERT INTO public.reuc VALUES (446, 'Agrosolar V', '76.363.218-0', '', '7550099.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Agrosolar V SpA', 'PMGD');
INSERT INTO public.reuc VALUES (447, 'Pampa Camarones', '76.085.153-1', '', '', 'Fernando Alvarez Castro', 'falvarez@pampacamarones.cl', '56229642000', 'Avenida Presidente Riesco 5335, oficina 2104', 'Vitacura', 'Jaime Veas Lopez', 'Pampa Camarones SpA', 'Cliente Libre');
INSERT INTO public.reuc VALUES (448, 'Mantoverde', '77.020.457-7', '', '', 'Oscar Flores Lemaire', 'oscar.flores@capstonecopper.com', '56522204201', 'Andres Bello 660, chañaral', 'Chañaral', 'Leonel Araya', 'Mantoverde S.A.', 'Cliente Libre');
INSERT INTO public.reuc VALUES (449, 'Minera Mantos Blancos (Mantos Copper)', '77.418.580-1', '', '', '', '', '', '', '', 'David Dimitri Perez Navarro', 'Mantos Copper S.A.', 'Transmisor Dedicado,Cliente Libre,Generador');
INSERT INTO public.reuc VALUES (450, 'MLP TRANSMISION S.A.', '77.107.802-8', '', '', 'Mauricio Larraín', 'mlarrain@pelambres.cl', '56227984500', 'Av. Apoquindo 4001 piso 18', 'Las Condes', 'Hermógenes Zepeda', 'MLP TRANSMISION S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (451, 'Santa Inés Solar', '76.766.027-8', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'CVE Proyecto Seis SpA', 'PMGD');
INSERT INTO public.reuc VALUES (452, 'Pitra', '76.827.359-6', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Pitra SpA', 'PMGD');
INSERT INTO public.reuc VALUES (453, 'GR Power Chile SpA', '77.209.283-0', '', '', 'Juan Francisco Friedl Larenas', 'jfriedl@grenergy.eu', '56952161706', 'Isidora Goyenechea 2800 Of 3702', 'Las Condes', 'Victor Gabriel Pavez Soto', 'GR Power Chile SpA', 'Generador');
INSERT INTO public.reuc VALUES (454, 'TSGF', '76.493.358-3', '', '', 'María Eugenia Orellana', 'maria-eugenia.orellana@totalenergies.com', '56962188290', 'Av Apoquindo 4820, piso 11', 'Las Condes', 'Jose Chahuan', 'TSGF SpA', 'Generador');
INSERT INTO public.reuc VALUES (455, 'OPDENERGY Generación', '77.053.873-4', 'Reemplazo AustrianSolar Chile Uno SpA - https://correspondencia.coordinador.cl/correspondencia/show/envio/605c6fee35635722a937d8a2', '', 'Carlos Ortiz Gajardo', 'raparedes@opdeenergy.com', '56942377864', 'Los Militares 5953, oficina 1803', 'Las Condes', 'Carlos Ortiz Gajardo', 'OPDENERGY Generación SpA', 'Generador');
INSERT INTO public.reuc VALUES (456, 'Central El Atajo', '77.032.394-0', '', '', 'José Tomás Urzúa González', 'turzua@inverges.cl', '56222973607', 'Avenida Las Condes 9460, oficina 1205', 'Las Condes', 'José Tomás Urzúa González', 'Central El Atajo SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (457, 'Cóndor Energía', '76.580.921-5', 'AR Alena SpA → Reemplazo en carta DE06429-20', '', 'Manuel Tagle', 'manuel.tagle@mainstreamrp.com', '56225923100', '', '', 'Pablo Marcos', 'Cóndor Energía SpA', 'Generador');
INSERT INTO public.reuc VALUES (458, '', '', 'AR Tchamma SpA → Reemplazo en carta DE00914-22', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (459, '', '', 'AR Cerro Tigre SpA → Reemplazo en carta DE00963-22', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (460, '', '', 'AR Escondido SpA → Reemplazo en carta DE06432-20', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (461, 'Huemul Energía', '76.580.849-9', 'Reemplazos en carta https://correspondencia.coordinador.cl/correspondencia/show/recibido/6075c9c63563575c463ac6f3', '', 'Manuel Tagle', 'manuel.tagle@mainstreamrp.com', '56225923100', '', '', 'Pablo Marcos', 'Huemul Energía SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (462, 'Fusión con Minera Michilla SpA', '76.102.677-1', '', '', 'Jose Miguel Ibañez Anrique', 'jmibanez@haldeman.cl', '56228969121', 'Asturias 280, Oficina 401', 'Las Condes', 'Jorge Sougarret Larroquete', 'Minera HMC S.A.', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (463, 'Cipresillos', '76.282.509-0', '', '', 'Francisco Gutiérrez Philippi', 'fgutierrezph@cipresillos.cl', '56227536410', 'Magdalena 140, piso 19', 'Las Condes', 'Juan Carlos Larenas Díaz', 'Eléctrica Cipresillos SpA', 'PMG,Generador');
INSERT INTO public.reuc VALUES (464, 'Parque Solar Meco', '76.905.638-6', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Meco Chillan SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (465, 'Taltal Solar', '76.264.543-2', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Taltal Solar S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (466, 'PMGD Cipres', '76.592.224-0', '', '', 'Frederic Nuñez', 'f.nunez@langa-international.com', '', '', '', 'Andrés Caviedes Arévalo', 'Ciprés SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (467, 'Parque Solar Ovalle Norte', '76.967.835-2', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Ovalle Norte SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (468, 'PMGD Lingue', '76.805.352-9', '', '', 'Carlos Ortiz Gajardo', 'raparedes@opdeenergy.com', '56942377864', 'Los Militares 5953, oficina 1803', 'Las Condes', 'Carlos Ortiz Gajardo', 'Lingue SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (469, 'TEC', '77.282.314-2', '', '', 'Mauricio Infante Esquerra', 'mauricio.infante@eepa.cl', '56223450005', '21 de Mayo 0164, Puente Alto', 'Puente Alto', 'Guillermo Eduardo Guerra Godoy', 'Transmisora Eléctrica Cordillera SpA', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (470, 'Paine', '76.618.685-8', 'Cambio razón social según carta DE 06742-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Paine Energy SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (471, 'Eléctrica Pinares', '77.053.312-0', '', '', 'Javier Antonio Alemany Martinez', 'jalemany@fyrmob.cl', '56224479348', 'Santa Alejandra 03480, Barrio Industrial, San Bernardo, Santiago', 'San Bernardo', 'Javier Antonio Alemany Martinez', 'Eléctrica Pinares Limitada', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (472, 'Nueva Atacama Solar', '77.009.353-8', 'Reemplazo Atacama Solar S.A. en carta DE00564-22', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Nueva Atacama Solar S.A.', 'Generador');
INSERT INTO public.reuc VALUES (473, 'CINERGIA', '77.285.492-7', '', '', 'Marco Bramante', 'mbramante@cinergia.cl', '', '', '', 'Daniel Soto Enrich', 'Cinergia Chile SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (474, 'Don Andrónico', '76.936.976-7', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Parque Solar Cancha SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (475, 'CGE-C SpA', '77.316.204-2', '', '', 'Iván Arístides Quezada Escobar', 'iquezadae@grupocge.cl', '56226807204', 'Presidente riesco 5561 piso 14', 'Las Condes', 'Hector Mauricio Lagos Rivera', 'CGE Comercializadora SpA', 'Generador,PMG');
INSERT INTO public.reuc VALUES (476, 'SxET', '77.257.713-3', '', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Energy Trading Chile SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (477, 'EDELAYSEN', '88.272.600-2', '', '', 'Francisco Alliende A.', 'rodrigo@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Kandinsky Dintrans Perez', 'Empresa Eléctrica de Aysén S.A.', 'Generador SSMM,Distribuidoras SSMM (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (478, 'PARQUE ROMERIA', '76.939.917-8', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar el Sauce SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (479, 'Parque Solar Membrillo', '76.891.081-2', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Fotovoltaica Avellano SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (480, 'Villa Solar', '76.581.786-2', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Villaprat SpA', 'PMGD');
INSERT INTO public.reuc VALUES (481, 'Faro Corona', '77.290.255-7', '', '', 'Rafael Cox', 'rcox@hidroelpaso.cl', '56232511253', 'Avenida Américo Vespucio 1090, oficina 1401-A', 'Vitacura', 'Rafael Cox', 'Faro Corona SpA', 'PMGD');
INSERT INTO public.reuc VALUES (482, 'La Huella', '76.362.257-6', '', '7561156.0', 'Italo Repetto', 'i.repetto@cc-energy.com', '56939492587', 'Burgos 80, oficina 702', 'Las Condes', 'Italo Repetto', 'AustrianSolar Chile Seis SpA', 'Generador');
INSERT INTO public.reuc VALUES (483, 'Energía Morro Guayacán', '77.160.709-8', '', '', 'Emilio Pellegrini Munita', 'epm@decapital.cl', '56224245770', 'Rosario Norte 555, oficina 1601', 'Las Condes', 'Alfredo Fernández F', 'Energía Morro Guayacán SpA', 'PMGD');
INSERT INTO public.reuc VALUES (484, 'Don Pedro', '76.860.292-1', 'Cambio razón social según carta DE 06740-24', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Don Pedro SpA', 'PMGD');
INSERT INTO public.reuc VALUES (485, 'Los Libertadores Solar', '76.553.447-K', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Los Libertadores Solar Spa', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (486, 'Campo Lindo', '76.337.585-4', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Campo Lindo SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (487, 'GR Pilo', '76.885.331-2', '', '', 'Catarina Azevedo Maia', 'catarina.maia@nextenergycapital.com', '34911986003', 'Av. Vitacura 2939, Oficina:1201', 'Santiago', 'Adriana Barua', 'GR Pilo SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (488, 'Hidroeléctrica Las Juntas', '76.281.948-1', '', '', 'Andrea Zunino Besnier', 'azunino@mcondor.cl', '56998499864', 'Av. Andres Bello 2777 oficina 2004', '', 'Felipe Aceituno Arroyo', 'Hidroeléctrica Las Juntas S.A.', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (489, 'PMGD Llay Llay', '76.466.222-9', '', '', 'Carlos Ortiz Gajardo', 'cortiz@opdenergy.com', '56942377864', 'Los Militares 5953, oficina 1803', 'Las Condes', 'Carlos Ortiz Gajardo', 'Xue Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (490, 'Parque Solar Porvenir', '76.967.845-K', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Parque Solar Porvenir SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (491, 'SLK 808', '76.359.635-4', '', '', 'Tomas Herzfeld', 'tomas.herzfeld@gestionsolar.cl', '56223441024', 'Malaga 85, of 216', 'Las Condes', 'Tomas Herzfeld', 'FV Rinconada SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (492, 'SCL III', '77.244.808-2', '', '', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'SCL III SpA', 'PMGD');
INSERT INTO public.reuc VALUES (493, 'PFV EL PIUQUEN', '77.044.668-6', '', '', 'José Patricio Lagos Cisterna', 'plagos@copelec.cl', '56422204412', '18 de Septiembre 688, Chillán', 'Chillán', 'Iván Fuentealba Carrasco', 'PFV El Piuquen SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (494, 'Farmdo', '77.125.459-4', '', '', 'Javier Campos', 'javier.campos@las-energy.com', '56998736074', 'Fuenzalida Comas 1763', 'Vitacura', 'Jorge Leal', 'Farmdo Energy Chile SpA', 'PMGD');
INSERT INTO public.reuc VALUES (495, 'Las Cabras', '76.547.418-3', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'RCL Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (496, 'Los Lagos', '76.515.883-4', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Los Lagos SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (497, 'Avilés', '76.585.762-7', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Avilés SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (498, 'GR Pitao', '76.885.335-5', '', '', 'Catarina Azevedo Maia', 'catarina.maia@nextenergycapital.com', '34911986003', 'Av. Vitacura 2939, Oficina:1201', 'Santiago', 'Adriana Barua', 'GR Pitao SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (499, 'Tamarugo', '76.217.288-7', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Baobab Energías Renovables SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (500, 'PMGD FV Moya', '76.879.476-6', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Suvan Solar SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (501, 'Transquinta S.A.', '76.954.578-6', '', '', 'Cristián Martínez Vergara', 'camartin@chilquinta.cl', '56322452026', 'Av. Argentina N° 1 Piso 7 Valparaiso', 'Valparaíso', 'Jaime Acevedo Salinas', 'Transquinta S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (502, 'Los Molinos', '77.218.608-8', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Los Molinos SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (503, 'PHAM', '76.170.761-2', '', '', 'Luis Urrejola Martelli', 'luis.urrejola@aes.com', '56954060271', 'Los Conquistadores 1730, piso 10', '', 'Eduardo Verdugo', 'Alto Maipo SpA', 'Generador,Transmisor Zonal');
INSERT INTO public.reuc VALUES (504, 'Membrillo Solar SpA', '77.101.924-2', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Membrillo Solar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (505, 'Parque Solar Alcaldesa', '76.902.203-1', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Parque Solar Alcaldesa SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (506, 'Sol del Desierto', '76.364.344-1', '', '', 'Luis Alfredo Solar Pinedo ', 'asolar@atlasren.com', '56226118300', 'Apoquindo 3472, piso 9', 'Las Condes', 'Tomás Ávila Araya', 'Parque Solar Fotovoltaico Sol del Desierto SpA', 'Generador');
INSERT INTO public.reuc VALUES (507, 'PFV El Flamenco', '76.979.123-K', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'PFV El Flamenco SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (508, 'Aguas Andinas', '61.808.000-5', '', '8340083.0', 'Daniel Tugues Andres', 'dtugues@aguasandinas.cl', '56225692001', 'Av. Presidente Balmaceda 1398', '', 'Christian Delgado Canseco', 'Aguas Andinas S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (509, 'Subian', '76.746.454-1', '', '7560969.0', 'Francisco Javier Ybarra Moreno', 'javier.ybarra@suez.com', '56929285601', 'Avenida Apoquindo, 4800. Torre 2. Piso 19.', 'Las Condes', 'Oscar Gonzalez', 'Suez Biofactoría Andina SpA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (510, 'Vicente Solar', '76.477.296-2', '', '', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Solar TI Dos SpA', 'PMGD');
INSERT INTO public.reuc VALUES (511, 'Parque Solar La Muralla', '76.939.909-7', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Parque Solar La Muralla SpA', 'PMGD');
INSERT INTO public.reuc VALUES (512, 'Chilquinta Transmisión', '77.402.187-6', '', '', 'Cristián Martínez Vergara', 'camartin@chilquinta.cl', '56322452026', 'Av. Argentina N° 1 Piso 7 Valparaiso', 'Valparaíso', 'Jaime Acevedo Salinas', 'Chilquinta Transmisión S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (513, 'Hidroeléctrica Los Corrales SpA', '76.381.159-K', '', '', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'Hidroeléctrica Los Corrales SpA', 'PMG');
INSERT INTO public.reuc VALUES (514, 'Esfena', '76.766.025-1', '', '7550011.0', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'CVE Proyecto Nueve SpA', 'PMGD');
INSERT INTO public.reuc VALUES (515, 'PMGD FV El Castaño', '76.503.252-0', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'El Castaño SpA', 'PMGD');
INSERT INTO public.reuc VALUES (516, 'La Foresta', '76.792.807-6', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Sociedad de Energías Renovables Los Lirios SpA', 'PMGD');
INSERT INTO public.reuc VALUES (517, 'PMGD Los Magnolios Solar (Ex. PMGD Litre)', '76.805.351-0', '', '', 'Carlos Ortiz Gajardo', 'cortiz@opdenergy.com', '56942377864', 'Los Militares 5953, oficina 1803', 'Las Condes', 'Carlos Ortiz Gajardo', 'Litre SpA', 'PMGD');
INSERT INTO public.reuc VALUES (518, 'Central El Pinar', '76.282.829-4', '', '', 'Juan León Obrecht', 'jlo@agrosonda.cl', '56223765202', 'Carretera General San Martin 16.500 15A', 'Colina', 'Cristobal Renard', 'Empresa Eléctrica El Pinar SpA', 'Generador');
INSERT INTO public.reuc VALUES (519, 'PMGD FV Cortijo', '76.879.473-1', '', '7550011.0', 'Pierre Boulestreau', 'cvechile@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Apolo Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (520, 'Fotovoltaica Peumo', '76.891.098-7', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Fotovoltaica Peumo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (521, 'Andes Solar II', '77.423.682-1', '', '7561185.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Andes Solar II SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (522, 'Acierta Energía', '77.333.033-6', '', '', 'Daniel Canales Valenzuela', 'daniel.canales@atriaenergia.com', '56226118300', 'Avenida Apoquindo 3472 oficina 901', 'Las Condes', 'Tomás Ávila Araya', 'Acierta Energía SpA', 'PMGD');
INSERT INTO public.reuc VALUES (523, 'Parque Solar Quetena', '77.050.568-2', '', '', 'Francisco Javier Baeza', 'fbaezas@icafal.cl', '56223519321', 'Augusto Leguía Sur 160, Of 22, Las Condes', 'Las Condes', 'Alberto Falcone Assler', 'Parque Solar Quetena S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (524, 'Energía Eólica Los Olmos SpA', '76.868.988-1', '', '', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Energía Eólica Los Olmos SpA', 'Generador');
INSERT INTO public.reuc VALUES (525, 'CGE TRANSMISIÓN', '77.465.741-K', '', '', 'Iván Arístides Quezada Escobar', 'iquezadae@grupocge.cl', '56226807204', 'Presidente riesco 5561 piso 14', 'Las Condes', 'Victor Gutierrez Gonzalez', 'CGE Transmisión S.A.', 'Transmisor Zonal,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (526, 'Luciano Solar SpA', '77.044.754-2', 'Empresa', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Luciano Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (527, 'Los Andes', '76.106.987-K', '', '7630000.0', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Fotovoltaica de Los Andes SpA', 'PMGD');
INSERT INTO public.reuc VALUES (528, 'Del Desierto', '76.741.285-1', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Fotovoltaica Del Desierto SpA', 'PMGD');
INSERT INTO public.reuc VALUES (529, 'SDN', '76.098.234-2', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Fotovoltaica Sol del Norte SpA', 'PMGD,PMG');
INSERT INTO public.reuc VALUES (530, 'GR Ciprés', '76.748.889-0', '', '', 'Catarina Azevedo Maia', 'catarina.maia@nextenergycapital.com', '34911986003', 'Av. Vitacura 2939, Oficina:1201', 'Santiago', 'Adriana Barua', 'GR Ciprés SpA', 'PMGD');
INSERT INTO public.reuc VALUES (531, 'Corcovado de Verano', '76.876.862-5', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Corcovado de Verano SpA', 'PMGD');
INSERT INTO public.reuc VALUES (532, 'Luzparral Transmisión', '77.470.427-2', '', '', 'Francisco Solis Ganga', 'fsolisg@luzlinares.cl', '56732634004', 'Chacabuco 675, Linares', 'Lineares', 'Jaime Acevedo Salinas', 'Luzparral Transmisión S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (533, 'Fotovoltaica Norte Grande 1 SpA', '76.213.013-0', '', '7560908.0', 'Carlos Salazar', 'carlos.salazar@x-elio.com', '56224344266', 'Calle Badajoz 130, Office 1401', 'Las Condes', 'Carlos Salazar', 'Fotovoltaica Norte Grande 1 SpA', 'Generador');
INSERT INTO public.reuc VALUES (534, 'Parque Solar Colina SpA', '77.324.535-5', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Colina SpA', 'PMGD');
INSERT INTO public.reuc VALUES (535, 'PMGD GUADALUPE', '76.440.334-7', '', '', 'Andres Yoon-Jung Ha Chun', 'a.hachun@s-energy.com', '56229935580', 'Cerro El Plomo 5420, oficina 402, Las Condes', 'Las Condes', 'Andres Yoon-Jung Ha Chun', 'Guadalupe Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (536, 'Mataquito Transmisora de Energía S.A.', '76.951.331-0', '', '', 'Alan Heinen Alves Da Silva', 'alan.heinen@celeogroup.com', '56232024300', 'Apoquindo 4501, Oficina 1902', 'Las Condes', 'David Zamora Mesias', 'Mataquito Transmisora de Energía S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (537, 'Anumar Chile', '76.547.685-2', '', '', 'Stefan Fritz', 'stefan.fritz@anumar.com', '56932661868', 'Andrés de Fuenzalida 17, of. 41', 'Providencia', 'Stefan Fritz', 'Anumar Energía del Sol 1 SpA', 'PMGD');
INSERT INTO public.reuc VALUES (538, 'Litoral Transmisión S.A.', '77.470.446-9', 'División de Compañía Eléctrica del Litoral S.A. en 2 sociedades: (i) Compañía Eléctrica del Litoral S.A., sociedad de giro exclusivo de distribución y continuadora legal de la sociedad dividida; (ii) Litoral Transmisión S.A. (nueva sociedad), a la cual se le asignaron los activos de transmisión. Carta DE06406-21', '', 'Cristian Candia', 'ccandia@chilquintadx.cl', '56352205003', 'Avda. Peñablanca 540, Algarrobo', 'Algarrobo', 'Jaime Acevedo Salinas', 'Litoral Transmisión S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (539, 'PFV Las Tencas', '77.054.026-7', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV Las Tencas SpA', 'PMGD');
INSERT INTO public.reuc VALUES (540, 'Cuenca Solar', '76.879.478-2', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Cuenca Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (541, 'Energía First', '76.416.503-9', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Energía First SpA', 'PMGD');
INSERT INTO public.reuc VALUES (542, 'Socompa de Verano', '77.088.008-4', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Socompa de Verano SpA', 'PMGD');
INSERT INTO public.reuc VALUES (543, 'Sonnedix Cox Energy Chile', '76.475.504-9', 'Coordinado según carta DE04463-21', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Cox Energy Chile SpA', 'Transmisor Zonal,Generador');
INSERT INTO public.reuc VALUES (544, 'Santa Francisca', '76.986.616-7', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'CVE Proyecto Diecisiete SpA', 'PMGD');
INSERT INTO public.reuc VALUES (545, 'Enerquinta', '77.402.185-K', 'Reemplazo Generadora Eléctrica Sauce Los Andes S.A aprobado en carta https://correspondencia.coordinador.cl/correspondencia/show/envio/619fb38f3563575aff0ce117', '', 'Francisco Mualim Tietz ', 'fmualim@chilquinta.cl', '56322452280', 'Av. Argentina N° 1 piso 9', 'Valparaíso', 'Francisco Karmy Escobar', 'Enerquinta S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (546, 'Copihue Energía', '76.582.515-6', 'Comunicación enviada en carta OP00007-22', '', 'Manuel Tagle', 'manuel.tagle@mainstreamrp.com', '56225923100', '', '', 'Pablo Marcos', 'Copihue Energía SpA', 'Generador');
INSERT INTO public.reuc VALUES (547, 'CASTE', '76.951.335-3', 'alan.heinen@celeogroup.com', '', 'Alan Heinen Alves Da Silva', 'alan.heinen@celeogroup.com', '56232024300', 'Apoquindo 4501, Oficina 1902', 'Las Condes', 'David Zamora Mesias', 'Casablanca Transmisora de Energía S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (548, 'Meli', '76.780.277-3', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Meli SpA', 'PMGD');
INSERT INTO public.reuc VALUES (549, 'Parque Solar Aurora SpA', '76.930.373-1', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Parque Solar Aurora SpA', 'PMGD');
INSERT INTO public.reuc VALUES (550, 'PDV', '76.803.153-3', '', '', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'Hidroeléctrica Punta del Viento SpA', 'PMG');
INSERT INTO public.reuc VALUES (551, 'PMGD PFV El Zorzal', '77.044.669-4', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'PFV El Zorzal SpA', 'PMGD');
INSERT INTO public.reuc VALUES (552, 'Calbuco de Verano', '76.876.842-0', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Calbuco de Verano SpA', 'PMGD');
INSERT INTO public.reuc VALUES (553, 'Callaqui de Verano', '76.876.872-2', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Callaqui de Verano SpA', 'PMGD');
INSERT INTO public.reuc VALUES (554, 'Puelche Flux Sphera', '77.275.106-0', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'Paula Domínguez', 'Puelche Flux Sphera SpA', 'PMGD');
INSERT INTO public.reuc VALUES (555, 'Salerno Solar', '77.183.912-6', '', '', 'Sven Gysling Brinkmann', 'sven@ienergiagroup.com', '56226241971', 'Américo Vespucio 2680, oficina 111', 'Conchalí', 'Sven Gysling Brinkmann', 'PMGD Salerno SpA', 'PMGD');
INSERT INTO public.reuc VALUES (556, 'Toesca Renovables', '77.428.039-1', 'Reemplazo Parque Fotovoltaico Santa Rita Solar SpA carta https://correspondencia.coordinador.cl/correspondencia/show/envio/61f3ddbb3563574c52753d7a', '', 'José Manuel Infante', 'jose.infante@toesca.com', '56226462038', 'Magdalena 140, Piso 22, Las Condes', 'Las Condes', 'Alejandro Reyes', 'Toesca Renovables SpA', 'PMGD');
INSERT INTO public.reuc VALUES (557, '', '', 'Reemplazo Sanbar Solar SpA carta https://correspondencia.coordinador.cl/correspondencia/show/envio/61f3df8e3563574c517c3d9d', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (558, '', '', 'Reemplazo Impulso Solar San José SpA carta https://correspondencia.coordinador.cl/correspondencia/show/envio/621501aa35635720aec73535', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (559, '', '', 'Reemplazo Parque Fotovoltaico Curacaví SpA carta https://correspondencia.coordinador.cl/correspondencia/show/envio/6216497e3563574034956f68', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (560, '', '', 'Reemplazo Santa Elvira Energy SpA carta https://correspondencia.coordinador.cl/correspondencia/show/envio/6216553e3563574034956f7d', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (561, '', '', 'Reemplazo Santa Luisa Energy SpA carta https://correspondencia.coordinador.cl/correspondencia/show/envio/6216566c3563574034956f83', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (562, '', '', 'Reemplazo  PMGD Albor II, propiedad de Parque Solar Albor SpA, según carta https://correspondencia.coordinador.cl/correspondencia/show/envio/6477482b35635723dc62022a', '', '', '', '', '', '', '', '', '');
INSERT INTO public.reuc VALUES (563, 'PFV Los Tordos', '77.044.673-2', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV Los Tordos SpA', 'PMGD');
INSERT INTO public.reuc VALUES (564, 'Eléctrica Moka', '77.513.675-8', '', '', 'Rosa Maria Villagra Moreno', 'rosa.villagra@rizomaenergy.cl', '56229273932', 'Nueva Costanera 3445, Of 64', '', 'Rodrigo Danus Laucirica', 'Eléctrica Moka SpA', 'Generador');
INSERT INTO public.reuc VALUES (565, 'Los Tauretes', '76.766.021-9', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'CVE Proyecto Ocho SpA', 'PMGD');
INSERT INTO public.reuc VALUES (566, 'PMGD San Carlos Solar', '77.050.739-1', '', '', 'José Manuel Infante', 'jose.infante@toesca.com', '56226462038', 'Magdalena 140, Piso 22, Las Condes', 'Las Condes', 'Matías Alejandro Burton Hormazabal', 'San Carlos Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (567, 'IEH', '76.775.253-9', 'Reemplazos informados en cartas DE00684-22, DE00685-22, DE00686-22, DE00687-22, DE00688-22, DE00689-22, DE00690-22, DE00691-22, DE00692-22, DE00693-22, DE00694-22, DE006945-22, DE00696-22', '', 'Jaime Zuazagoitia', 'jaime@interenergy.com', '56229511925', 'Av. Kennedy 4700, Of. 901', 'Vitacura', 'Johanny Asenjo', 'IEH Solar Chile SpA', 'PMGD');
INSERT INTO public.reuc VALUES (568, 'Alfa Transmisora', '77.337.345-0', 'Fusión por absorción de Alfa Transmisión S.A. en Alfa Transmisora de Energía S.A. (ex Colbún Transmisión S.A.) carta OP00411-22', '', 'Alan Heinen Alves Da Silva', 'alan.heinen@celeogroup.com', '56232024300', 'Apoquindo 4501, Oficina 1902', 'Las Condes', 'David Zamora Mesias', 'Alfa Transmisora de Energía S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (569, 'Aggreko', '76.625.330-K', '', '', 'Carlos Grez', 'carlos.grez@aggreko.com', '56991512157', 'Galvarino 9450', 'Quilicura', 'Hugo Alvarado', 'Aggreko Chile Limitada', 'PMGD');
INSERT INTO public.reuc VALUES (570, 'SALADO ENERGY', '76.618.672-6', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Salado Energy SpA', 'PMGD');
INSERT INTO public.reuc VALUES (571, 'GR Ruil', '76.885.337-1', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'GR Ruil SpA', 'PMGD');
INSERT INTO public.reuc VALUES (572, 'PMGD Guaraná', '77.011.891-3', '', '', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'Solar TI Dieciséis SpA', 'PMGD');
INSERT INTO public.reuc VALUES (573, 'Fardela Negra SpA', '77.253.134-6', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Fardela Negra SpA', 'PMGD');
INSERT INTO public.reuc VALUES (574, 'Transmisora Melipeuco S.A.', '77.509.835-K', 'Compraventa de activos Transmisora Valle Allipén S.A. carta OP00261-22', '', 'Juan Carlos Albala', 'juan.albala@atlantica.com', '34618919091', 'Camino el Alba 9500, Torre B, 406', 'Santiago', 'Juan Carlos Albala', 'Transmisora Melipeuco S.A.', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (575, 'Solar E', '77.257.259-K', '', '', 'David Orellana', 'david.orellana@aedilestalinay.com', '56229951065', 'Alonso de Córdova 5670, Oficina 503', 'Las Condes', 'Gonzalo Menares', 'Solar E SpA.', 'PMGD');
INSERT INTO public.reuc VALUES (576, 'PMGD Trebo', '77.011.882-4', '', '', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'Solar TI Diecisiete SpA', 'PMGD');
INSERT INTO public.reuc VALUES (577, 'PMGD Manao', '76.727.519-6', '', '', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'Solar TI Doce SpA', 'PMGD');
INSERT INTO public.reuc VALUES (578, 'Energía Renovable Encino SpA', '77.084.792-3', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Energía Renovable Encino SpA', 'PMGD');
INSERT INTO public.reuc VALUES (579, 'EnfraGen Chile', '77.042.032-6', 'Cambio razón social según carta DE 00252-25', '', 'Jose Arosa', 'jose.arosa@prime-energia.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'EnfraGen Chile Solar SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (580, 'Parque Solar Retiro SpA', '76.871.349-9', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Parque Solar Retiro SpA', 'PMGD');
INSERT INTO public.reuc VALUES (581, 'Parque Fotovoltaico Faramalla SpA', '77.201.711-1', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Parque Fotovoltaico Faramalla SpA', 'PMGD');
INSERT INTO public.reuc VALUES (582, 'Parque Solar Tabolango SpA.', '76.930.382-0', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Tabolango SpA.', 'PMGD');
INSERT INTO public.reuc VALUES (583, 'GR Carza', '76.885.333-9', '', '', 'Catarina Azevedo Maia', 'catarina.maia@nextenergycapital.com', '34911986003', 'Av. Vitacura 2939, Oficina:1201', 'Santiago', 'Adriana Barua', 'GR Carza SpA', 'PMGD');
INSERT INTO public.reuc VALUES (584, 'PFV Las Catitas', '77.044.654-6', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV Las Catitas SpA', 'PMGD');
INSERT INTO public.reuc VALUES (585, 'Parque Solar Lo Chacón SpA', '77.223.374-4', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Lo Chacón SpA', 'PMGD');
INSERT INTO public.reuc VALUES (586, 'Carbon Free Chile', '76.727.466-1', '', '', 'Michael Dawson Minnes', 'mminnes@carbonfree.com', '56941164592', 'Reyes Lavalle 3340 of 1104', 'Las Condes', 'Jose Cubillo Cordero', 'Carbon Free Chile SpA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (587, 'Parque Solar Fulgor', '77.110.566-1', 'Termino de reemplazo seún carta DE 00447-25', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Parque Fulgor SpA', 'PMGD');
INSERT INTO public.reuc VALUES (588, 'Tecnocap S.A.', '76.369.130-6', '', '', 'Andrés Sepúlveda Alcaíno', 'agsepulveda@cap.cl', '56228186000', 'Gertrudis Echeñique N°220', 'Las Condes', 'Nicolas Gonzalez', 'Tecnocap S.A.', 'Transmisor Zonal,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (589, 'Bepatagonia Generación', '77.535.535-2', 'Se aplico termino de reemplazo debido a puesta en servicio NUP 5055 PMGD Diesel Colaco Pargua', '', 'Augusto Alvarez-Salamanca', 'aalvarez@bepatagonia.cl', '', 'Rosario Norte 4071 of 1201', 'Las Condes', 'José Tomás Alvarez-Salamanca Troncoso', 'Bepatagonia Generación S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (590, 'Andina Solar 6', '76.549.716-7', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Andina Solar 6 SpA', 'PMGD');
INSERT INTO public.reuc VALUES (591, 'Parque Solar Convento SpA', '76.930.379-0', '', '', 'David Orellana', 'david.orellana@aedilestalinay.com', '56229951065', 'Alonso de Córdova 5670, Oficina 503', 'Las Condes', 'Gonzalo Menares', 'Parque Solar Convento SpA', 'PMG');
INSERT INTO public.reuc VALUES (592, 'Parque Eólico Campo Lindo SpA', '76.363.072-2', '', '', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Parque Eólico Campo Lindo SpA', 'Generador');
INSERT INTO public.reuc VALUES (593, 'Parque Solar Itihue SpA', '77.324.548-7', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Itihue SpA', 'PMGD');
INSERT INTO public.reuc VALUES (594, 'GPGGD', '77.266.105-3', '', '', 'Rafael Guzmán Alonso', 'rguzmana@globalpower-generation.com', '56993287442', 'Los Militares 5890 piso 11 of. 1103', 'Las Condes', 'JOSE ANTONIO OSORIO DEL OLMO', 'GPG Generación Distribuida SpA', 'PMGD');
INSERT INTO public.reuc VALUES (595, 'GR Lleuque', '76.885.321-5', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'GR Lleuque SpA', 'PMGD');
INSERT INTO public.reuc VALUES (596, 'DAS3', '76.264.541-6', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'Diego de Almagro Solar 3 S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (597, 'PMGD FV Mandinga', '77.029.455-K', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Mandinga Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (598, 'Parque Solar Cantillana SpA', '77.324.533-9', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Cantillana SpA', 'PMGD');
INSERT INTO public.reuc VALUES (599, 'CE CENTINELA SOLAR', '77.070.574-6', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'CE Centinela Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (600, 'Parque Solar Salamanca SpA', '76.967.849-2', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Salamanca SpA', 'PMGD');
INSERT INTO public.reuc VALUES (601, 'PSF Santa Isabel SpA', '77.346.233-K', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'PSF Santa Isabel SpA', 'PMGD');
INSERT INTO public.reuc VALUES (602, 'Empresa Eléctrica San Víctor SpA', '76.363.971-1', '', '', 'Jose Arosa', 'jose.arosa@enfragen.com', '56232105200', 'Av. Cerro El Plomo N° 5630, Piso 14', 'Las Condes', 'Veronica Bustos', 'Empresa Eléctrica San Víctor SpA', 'Generador SSMM');
INSERT INTO public.reuc VALUES (603, 'SLK CB9', '76.337.882-9', '', '', 'Tomas Herzfeld', 'tomas.herzfeld@gestionsolar.cl', '56223441024', 'Malaga 85, of 216', 'Las Condes', 'Tomas Herzfeld', 'SLK CB Nueve SpA', 'PMGD');
INSERT INTO public.reuc VALUES (604, 'PFV Las Cachañas', '77.060.669-1', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV Las Cachañas SpA', 'PMGD');
INSERT INTO public.reuc VALUES (605, 'Cocharcas Solar', '77.020.498-4', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Cocharcas Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (606, 'Hidroner SpA', '76.378.725-7', '', '', 'Camilo Sebastián Ruiz Ulloa', 'camilo.ruiz@icantera.com', '56990896516', 'Av. Kennedy 5600 of 805', 'Vitacura', 'Camilo Sebastián Ruiz Ulloa', 'Compañía Hidroeléctrica Hidroner SpA', 'Generador SSMM,PMGD');
INSERT INTO public.reuc VALUES (607, 'CE Uribe de Antofagasta Solar', '77.266.042-1', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'CE Uribe de Antofagasta Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (608, 'PMGD Loica', '77.101.958-7', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Loica SpA', 'PMGD');
INSERT INTO public.reuc VALUES (609, 'Indura', '76.150.343-K', '', '', 'Marcelo Torres Bruce', 'mtorres@indura.net', '56992220877', 'Av Apoquindo 6750 piso 8', 'Las Condes', 'Andrea Francisca Torneria Torres', 'Indura S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (610, 'Pingüino Emperador', '77.470.122-2', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'Pingüino Emperador SpA', 'PMGD');
INSERT INTO public.reuc VALUES (611, 'GR Torres del Paine', '77.130.983-6', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'GR Torres del Paine SpA', 'PMGD');
INSERT INTO public.reuc VALUES (612, 'Santa Ester Solar SpA', '77.218.642-8', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Santa Ester Solar SpA', 'PMG');
INSERT INTO public.reuc VALUES (613, 'Sonnedix Metro Exp', '77.122.684-1', '', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Sonnedix Metro Expansion SpA', 'PMGD');
INSERT INTO public.reuc VALUES (614, 'AS Energía', '77.029.514-9', '', '', 'Adel Yahad Sukni Catalán', 'asukni@asenergia.cl', '56225253790', 'Berlioz 5776', 'San Joaquín', 'Adel Yahad Sukni Catalán', 'AS Energía Ltda.', 'PMGD');
INSERT INTO public.reuc VALUES (615, 'Pacific Hydro Transmisión', '77.447.475-7', '', '', 'Renzo Valentino', 'rvalentino@pacifichydro.cl', '56225194200', 'Av. Isidora Goyenechea 3520 piso 10', 'Las Condes', 'Luis Osvaldo Nuñez Herrera', 'Pacific Hydro Transmisión S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (616, 'Palpana de Verano', '77.088.011-4', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Palpana de Verano SpA', 'PMGD');
INSERT INTO public.reuc VALUES (617, 'Newentun', '76.477.299-7', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Newentun SpA', 'PMGD');
INSERT INTO public.reuc VALUES (618, 'Capurata del Verano', '77.275.114-1', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Capurata del Verano SpA', 'PMGD');
INSERT INTO public.reuc VALUES (619, 'GR Alerce Andino', '77.130.986-0', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'GR Alerce Andino SpA', 'PMGD');
INSERT INTO public.reuc VALUES (620, 'Linzon Verano', '77.088.006-8', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Linzor de Verano SpA', 'PMGD');
INSERT INTO public.reuc VALUES (621, 'Piedras Negras', '76.803.155-K', '', '', 'Juan José Chavéz', 'juanjose.chavez@grupocerro.com', '56224887300', 'Rosario Norte 555, Edificio Neruda, Piso 22', 'Las Condes', 'Ronny Muñoz Muñoz', 'Hidroeléctrica Piedras Negras SpA', 'PMG');
INSERT INTO public.reuc VALUES (622, 'PFV Lo Chacón', '77.163.616-0', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'PFV Lo Chacón SpA', 'PMGD');
INSERT INTO public.reuc VALUES (623, 'PMGD HOLDCO SpA', '77.498.289-2', '', '', 'David Orellana', 'david.orellana@aedilestalinay.com', '56229951065', 'Alonso de Córdova 5670, Oficina 503', 'Las Condes', 'Gonzalo Menares', 'PMGD HOLDCO SpA', 'PMGD');
INSERT INTO public.reuc VALUES (624, 'San Alfonso Solar SpA', '76.888.208-8', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'San Alfonso Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (625, 'CMN', '85.306.000-3', '', '', 'Gonzalo Montes Astaburuaga', 'gomontes@barrick.com', '56223402022', 'Avenida Ricardo Lyon N°222, Piso 9', 'Providencia', 'Guillermo Bolados', 'Compañía Minera Nevada SpA', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (626, 'Parque Solar Fotovoltaico La Victoria', '77.044.758-5', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Magdalena Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (627, 'Nueva Esperanza Solar', '76.911.689-3', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Nueva Esperanza Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (628, 'Nueva Atacama S.A.', '76.850.128-9', '', '', 'Salvador Villarino', 'sergio.munoz@nuevaatacama.cl', '56522203302', 'Av. Copayapu N°2970', 'Copiapó', 'Sergio Antonio Muñoz Guzmán', 'Nueva Atacama S.A.', 'Cliente Libre,Transmisor Zonal');
INSERT INTO public.reuc VALUES (629, 'Parque Eólico Atacama', '76.852.769-5', '', '', 'Guillermo David Dunlop Llorens', 'gdl@grupoibereolica.com', '56223333540', 'Cerro el Plomo 5420, Oficina 1305', 'Las Condes', 'Héctor Andrés Astudillo Silva', 'Parque Eólico Atacama SpA', 'Transmisor Dedicado,Generador');
INSERT INTO public.reuc VALUES (630, 'INSTAPRO', '77.617.773-3', '', '', 'Eugenio Enrique Vasquez Lopez', 'eugenio.vasquez@instapro.cl', '56978876731', '1 Sur 690, Oficina 815 Edificio Plaza Talca', 'Talca', 'Eugenio Enrique Vasquez Lopez', 'Proyectos Eléctricos y de Construcción INSTA&PRO SpA', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (631, 'Samo Bajo SpA', '76.328.792-0', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Samo Bajo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (632, 'PFV Las Golondrinas', '77.060.673-K', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV Las Golondrinas SpA', 'PMGD');
INSERT INTO public.reuc VALUES (633, 'Liquidambar', '76.766.028-6', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'CVE Proyecto Siete SpA', 'PMGD');
INSERT INTO public.reuc VALUES (634, 'Chacabuco Solar SpA', '76.724.672-2', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Chacabuco Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (635, 'Tórtola SpA', '77.184.227-5', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Tórtola SpA', 'PMGD');
INSERT INTO public.reuc VALUES (636, 'Mytilineos Energy Chile', '77.677.158-9', 'Reemplazo  Bepatagonia Generación S.A. no se refleja en REUC, pero sigue activo y debe continuar reflejado en infotecnica', '', 'Luis Fredes', 'lfredes@veranocapital.com', '56227000239', 'Rosario Norte 407 Oficina 1201', 'Las Condes', 'Luis Fredes', 'Mytilineos Energy Trading Chile SpA', 'PMGD');
INSERT INTO public.reuc VALUES (637, 'PFV El Gaviotín', '77.131.288-8', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV El Gaviotín SpA', 'PMGD');
INSERT INTO public.reuc VALUES (638, 'PFV Ayla Solar', '77.160.557-5', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV Ayla Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (639, 'SQM Salar', '79.626.800-K', '', '', 'Ricardo Ramos', 'ricardo.ramos@sqm.com', '56224252484', 'Los Militares #4290, piso 6', '', 'Larry Acevedo', 'SQM Salar S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (640, 'NPIII Holdco II', '77.542.606-3', '', '', 'Catarina Azevedo Maia', 'catarina.maia@nextenergycapital.com', '34911986003', 'Av. Vitacura 2939, Oficina:1201', 'Santiago', 'Adriana Barua', 'Nextpower III Chile Holdco II SpA', 'PMGD');
INSERT INTO public.reuc VALUES (641, 'Parque Solar Pueblo Seco SpA', '77.450.369-2', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Parque Solar Pueblo Seco SpA', 'PMGD');
INSERT INTO public.reuc VALUES (642, 'Los Hibiscos', '76.975.928-K', '', '', 'Javier Rojas H.', 'javier.rojas@matrizenergia.cl', '56224141440', 'La Concepción 141, Oficina 705', 'Providencia', 'Javier Rojas H.', 'Generadora Los Hibiscos SpA', 'PMGD');
INSERT INTO public.reuc VALUES (643, 'Planta Solar Peñaflor', '77.262.056-K', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'Planta Solar Peñaflor II SpA', 'PMGD');
INSERT INTO public.reuc VALUES (644, 'Pelumpen', '76.697.264-0', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'CVE Proyecto Dieciocho SpA', 'PMGD');
INSERT INTO public.reuc VALUES (645, 'Cabrero', '76.967.751-8', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Cabrero Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (646, 'La Higuera Transmisión', '77.708.626-K', '', '', 'JAVIER EDUARDO CARRASCO BRIONES', 'JCARRASCO@tenergia.cl', '56225194368', 'Avenida Cerro El Plomo 5630, Oficina 1702, Las Condes, Santiago', 'Las Condes', 'Javier Emilio Sepúlveda Saavedra', 'La Higuera Transmisión S.A.', 'Transmisor Dedicado,Transmisor Nacional');
INSERT INTO public.reuc VALUES (647, 'Pomerape SpA', '77.110.463-0', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Pomerape SpA', 'PMGD');
INSERT INTO public.reuc VALUES (648, 'Parque Solar El Conquistador SpA', '76.871.324-3', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Parque Solar El Conquistador SpA', 'PMGD');
INSERT INTO public.reuc VALUES (649, 'PMGD Rimini', '77.137.575-8', '', '7550099.0', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'Rimini Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (762, 'PMGD Turquía', '77.470.399-3', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Tedlar Luna SpA', 'PMGD');
INSERT INTO public.reuc VALUES (650, 'Solar Elena', '76.545.701-7', '', '', 'Felipe Pezo', 'fpezo@grenergy.eu', '56227515160', 'Av Isidora 2800 Of 3702 Las Condes Santiago', 'Las Condes', 'Miguel Ángel Alarcón González', 'Solar Elena SpA', 'Generador,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (651, 'Eletrans III', '76.763.747-0', '', '', 'Álvaro Arturo Alarcón Molina', 'aalarcom@eletrans.cl', '56939140144', 'Av. Argentina N° 1', 'Valparaíso', 'Álvaro Arturo Alarcón Molina', 'Eletrans III S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (652, 'PMGD PSF Coyunche', '77.359.447-3', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Per Parinacota SpA', 'PMGD');
INSERT INTO public.reuc VALUES (653, 'Millaray Fotovoltaica SpA', '77.018.086-4', '', '', 'Ignacio Andrés Fernández Orellana', 'ignacio.fernandez@enerside.com', '56992802587', 'Paseo Apoquindo 4499, Of 802', 'Las Condes', 'Ignacio Andrés Fernández Orellana', 'Millaray Fotovoltaica SpA', 'PMGD');
INSERT INTO public.reuc VALUES (654, 'Clementina', '76.697.248-9', '', '', 'Pierre Boulestreau', 'pierre.boulestreau@cvegroup.com', '56229428773', 'Vitacura 2939, Oficina 1901', 'Las Condes', 'Victor Ramos Tapia', 'CVE Proyecto Veintiuno SpA', 'PMGD');
INSERT INTO public.reuc VALUES (655, 'La Gloria', '76.574.649-3', '', '', 'José Ignacio Montenegro Pacheco', 'joseignacio@grupobiba.cl', '56995241461', 'Avenida Andrés Bello 2777, Oficina 2302', '', 'Cristián Pablo Espinosa Ábalos', 'La Gloria S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (656, 'D.E.S.A.', '77.504.335-0', '', '', 'Miriam Beatriz Gonzalez Moreno', 'mgonzalez@distribuidoraelectricasa.cl', '56978890842', 'Valle de Chaca, parcela 1 -B14', 'Arica', 'Edgardo Edmundo Sepúlveda Gallardo', 'Distribuidora Eléctrica S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (657, 'Chapiquina Solar', '77.287.935-0', '', '', 'Felipe Pezo', 'fpezo@grenergy.eu', '56227515160', 'Av Isidora 2800 Of 3702 Las Condes Santiago', 'Las Condes', 'Ana Cuevas Esteban', 'Chapiquina Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (658, 'Distribuidora de Energia Electrica Mataquito S.A.', '76.808.157-3', '', '', 'Rubén Salinas Aguero', 'rubensalinas@ingmataquito.cl', '56977656825', '', '', 'Tomás Pablo Reyes Vidal', 'Distribuidora de Energia Electrica Mataquito S.A.', 'Distribuidoras (Concesionarias de Distribución)');
INSERT INTO public.reuc VALUES (659, 'Planta Solar Lo Miguel', '77.262.075-6', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'Planta Solar Lo Miguel II SpA.', 'PMGD');
INSERT INTO public.reuc VALUES (660, 'EMELVA S.A.', '76.026.342-7', '', '', 'Enrique Ramírez Díaz', 'enrique.ramirez@mbi.cl', '56226553700', 'Av. Presidente Riesco 5711, Of, 401', 'Las Condes', 'Felipe Ignacio Martínez Illanes', 'Empresa Eléctrica Vallenar S.A.', 'Generador');
INSERT INTO public.reuc VALUES (661, 'Yahutela', '76.511.671-6', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'Catemu Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (662, 'BTG Pactual Chile SpA', '76.209.165-8', 'Nuevo coordinado de PMGD TER DAGOBERTO, propiedad de EBCO ENERGIA, desde el 1 de junio de 2023, segpun carta https://correspondencia.coordinador.cl/correspondencia/show/envio/6491d533356357201a66a2b1', '', 'David Alejandro Peñaloza Catalán', 'david.penaloza@btgpactual.com', '56225875379', 'Av. Costanera Sur 2730, piso 19', 'Las Condes', 'David Alejandro Peñaloza Catalán', 'BTG Pactual Chile SpA', 'PMGD');
INSERT INTO public.reuc VALUES (663, 'PMGD Independencia', '77.337.343-4', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'La Independencia Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (664, 'PFV Los Cisnes', '77.270.817-3', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV Los Cisnes SpA', 'PMGD');
INSERT INTO public.reuc VALUES (665, 'PFV El Chercan', '77.074.332-K', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV El Chercan SpA', 'PMGD');
INSERT INTO public.reuc VALUES (666, 'Fenix Solar SpA', '76.951.371-K', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Fenix Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (667, 'Chilener', '76.724.674-9', '', '', 'Oscar Sanchez', 'ingenieria@valfortec.com', '34964062901', 'La Concepcion 81, oficina 608', 'Providencia', 'Oscar Sanchez', 'Chilener II SpA', 'PMGD');
INSERT INTO public.reuc VALUES (668, 'Siete Colores SpA', '77.142.066-4', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Siete Colores SpA', 'PMGD');
INSERT INTO public.reuc VALUES (669, 'PFV El Rayador', '77.089.197-3', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV El Rayador SpA', 'PMGD');
INSERT INTO public.reuc VALUES (670, 'Parque Fotovoltaico Maitenlahue', '77.342.169-2', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Fotovoltaica Santa Rosario SpA', 'PMGD');
INSERT INTO public.reuc VALUES (671, 'Maimalican', '77.087.842-K', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'PS Maimalican SpA', 'PMGD');
INSERT INTO public.reuc VALUES (672, 'Don Matías', '77.346.339-5', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Parque Fotovoltaico Don Matías SpA', 'PMGD');
INSERT INTO public.reuc VALUES (673, 'Energy Partners', '77.410.232-9', '', '', 'Gonzalo Martin', 'gonzalomartin911@gmail.com', '56991596488', 'Av. Del Parque 5275, Of 104', 'Huechuraba', 'John Daly', 'Energy Partners SpA', 'PMGD');
INSERT INTO public.reuc VALUES (674, 'Neoelectra Energía', '77.081.321-2', '', '7561160.0', 'Antonio Cortés Ruiz', 'acortes@neoelectra.es', '56978506464', 'Cerro el Plomo 5931, Oficina 407', 'Las Condes', 'Eduardo Rodriguez', 'Neoelectra Energía Chile SpA', 'PMGD');
INSERT INTO public.reuc VALUES (675, 'Parque Fotovoltaico Doña Igna', '77.367.441-8', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Parque Fotovoltaico Doña Igna SpA', 'PMGD');
INSERT INTO public.reuc VALUES (676, 'PFV Willka', '76.319.461-2', '', '', 'Juan Ignacio Alarcón', 'juanignacio.alarcon@mytilineos.com', '56973888892', 'rosario norte 407 oficina 1201', '', 'Luis Fredes', 'Inversiones Fotovoltaicas SpA', 'Generador');
INSERT INTO public.reuc VALUES (677, 'PFV Las Taguas', '77.160.552-4', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV Las Taguas SpA', 'PMGD');
INSERT INTO public.reuc VALUES (678, 'STK Eolico', '76.138.789-8', '', '', 'María Teresa Gonzalez', 'contacto@statkraft.com', '56225929200', 'Vitacura 2969, Oficina 701', 'Las Condes', 'CARLOS MANTE', 'Statkraft Eolico S.A.', 'Generador');
INSERT INTO public.reuc VALUES (679, 'PMGD Pellín', '77.060.897-K', '', '', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'Solar Ti Quince SpA', 'PMGD');
INSERT INTO public.reuc VALUES (680, 'PSF Elizabeth SpA', '77.798.766-6', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'PSF Elizabeth SpA', 'PMGD');
INSERT INTO public.reuc VALUES (681, 'Caldera', '77.125.606-6', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Caldera Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (682, 'PFV Las Arboledas', '77.163.625-K', '', '', 'Erwin Eduardo Thieme Neira', 'Erwin.Thieme@gestiongerencial.cl', '56993424002', 'La concepción 81 Of.608', 'Providencia', 'Oscar Sanchez', 'Teno III SpA', 'PMGD');
INSERT INTO public.reuc VALUES (683, 'Ailin Fotovoltaica SpA', '77.018.069-4', '', '7580575.0', 'Ignacio Andrés Fernández Orellana', 'ignacio.fernandez@enerside.com', '56992802587', 'Paseo Apoquindo 4499, Of 802', 'Las Condes', 'Ignacio Andrés Fernández Orellana', 'Ailin Fotovoltaica SpA', 'PMGD');
INSERT INTO public.reuc VALUES (684, 'Parque Fotovoltaico Cara de Gallo', '77.213.663-3', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Parque Fotovoltaico El Loreto SpA', 'PMGD');
INSERT INTO public.reuc VALUES (685, 'Andina Solar 17 Este SpA', '76.772.373-3', '', '', 'Claudio Alemany Rojas', 'claudio.alemany@goldbecksolar.com', '56977852668', 'Vitacura 3900, of 909', 'Vitacura', 'Alejandro Albornoz Cruz', 'Andina Solar 17 Este SpA', 'PMGD');
INSERT INTO public.reuc VALUES (687, 'EA Maitén', '77.084.789-3', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'Energia Renovable Olmo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (688, 'PMGD Blu', '76.985.186-0', '', '', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'Blu Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (689, 'Andina Solar 10 SpA', '76.772.357-1', '', '', 'Claudio Alemany Rojas', 'claudio.alemany@goldbecksolar.com', '56977852668', 'Vitacura 3900, of 909', 'Vitacura', 'Alejandro Albornoz Cruz', 'Andina Solar 10 SpA', 'PMGD');
INSERT INTO public.reuc VALUES (690, 'Transelec Holdings Rentas Ltda', '76.560.200-9', '', '7560970.0', 'Arturo Le Blanc Cerda', 'aleblanc@transelec.cl', '56224677001', 'Orinoco 90, piso 14', 'Las Condes', 'María José Reveco', 'Transelec Holdings Rentas Ltda', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (691, 'Pacana del Verano', '77.275.157-5', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Pacana del Verano SpA', 'PMGD');
INSERT INTO public.reuc VALUES (692, 'San Eugenio Solar', '77.398.338-0', '', '', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'San Eugenio Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (693, 'Santa Cecilia Solar', '77.180.723-2', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Santa Cecilia Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (694, 'Inm Agua Marina', '76.168.769-7', '', '9361432.0', 'Ignacio Wahr Rivas', 'iwahr@amarina.cl', '56998736018', 'Los Arrayanes 650', 'Colina', 'Ignacio Wahr Rivas', 'Inmobiliaria Agua Marina S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (695, 'Orquídea Solar', '76.986.619-1', '', '7550011.0', 'Luis Meersohn García-Huidobro', 'luis.meersohn@cvegroup.com', '56974170699', '', '', 'Victor Ramos Tapia', 'CVE Proyecto Quince SpA', 'PMGD');
INSERT INTO public.reuc VALUES (696, 'PFV El Cuervo', '77.060.521-0', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'PFV El Cuervo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (697, 'Arcadia', '77.696.828-5', '', '', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Arcadia Generación Solar S.A.', 'Generador');
INSERT INTO public.reuc VALUES (698, 'Planta Solar La Paz', '77.262.077-2', '', '', 'Felipe Pezo', 'felipeantonio.pezo.pena@acciona.com', '56227515160', 'Av Isidora 2800 Of 3702 Las Condes Santiago', 'Las Condes', 'Ana Cuevas Esteban', 'Planta Solar La Paz II SpA.', 'PMGD');
INSERT INTO public.reuc VALUES (699, 'Andina Solar 13 SpA', '76.771.804-7', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Andina Solar 13 SpA', 'PMGD');
INSERT INTO public.reuc VALUES (700, 'GPE', '99.566.950-1', '', '7580124.0', 'Tomas Fahrenkrog', 'tfahrenkrog@gpe.cl', '56229168200', 'Félix de Amesti 90. Oficina 201', 'Las Condes', 'María Luisa Orellana', 'Gestión de Proyectos Eléctricos S.A', 'PMGD');
INSERT INTO public.reuc VALUES (701, 'PMGD Corso', '77.116.741-1', '', '7550104.0', 'Sergio del Campo Fayet', 'sergio.delcampo@sonnedix.com', '56931854812', 'Magdalena 140 Oficina 601', 'Las Condes', 'Francisco José Yévenes Márquez', 'Corso Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (702, 'Factor Luz', '77.676.939-8', '', '', 'Ricard Antonijoan', 'ricard@agg.cat', '56225910100', 'Avenida Apoquindo 3500, piso 11', 'Las Condes', 'Ricard Antonijoan', 'Factor Luz SpA', 'PMGD');
INSERT INTO public.reuc VALUES (703, 'PMGD Hornopirén Ltda', '76.704.549-2', '', '', 'Michael Bregar', 'contacto@nanogener.cl', '', '', '', 'Juan Carlos Aravena Triviño', 'Pequeño Medio de Generación Distribuida Hornopirén Limitada', 'PMGD,Generador SSMM');
INSERT INTO public.reuc VALUES (704, 'FNC', '96.584.160-1', '', '', 'Ivan Medel Herrera', 'IVAN.MEDEL@huilohuilo.cl', '56982884256', 'O´HIGGINS 457, of 3, VALDIVIA', 'Valdivia', 'Mauricio Javier Vargas Villarroel', 'Forestal Neltume Carranco S.A.', 'PMGD');
INSERT INTO public.reuc VALUES (705, 'PFV El Mirlo', '77.131.296-9', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV El Mirlo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (706, 'Macarena Solar', '77.032.338-K', '', '7550011.0', 'Luis Meersohn García-Huidobro', 'luis.meersohn@cvegroup.com', '56974170699', '', '', 'Victor Ramos Tapia', 'CVE Proyecto Veintiséis SpA', 'PMGD');
INSERT INTO public.reuc VALUES (707, 'Centauro', '76.972.761-2', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Centauro Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (708, 'Energía Renovable Rucapaine SpA', '77.147.239-7', '', '7510048.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Energía Renovable Rucapaine SpA', 'PMGD');
INSERT INTO public.reuc VALUES (709, 'PFV El Carpintero', '77.131.284-5', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV El Carpintero SpA', 'PMGD');
INSERT INTO public.reuc VALUES (710, 'Energía Eólica San Matías SPA', '77.116.491-9', '', '7520282.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Energía Eólica San Matías SPA', 'Generador');
INSERT INTO public.reuc VALUES (711, 'Parque Eólico Punta de Talca SpA', '76.414.434-1', '', '', 'Enrique Álvarez-Uría', 'Enrique.alvarez-uria@edp.com', '56985758929', 'Los Militares 4611, Piso 17, Las Condes.', 'Las Condes', 'Ricardo Rabié Durán', 'Parque Eólico Punta de Talca SpA', 'Generador');
INSERT INTO public.reuc VALUES (712, 'LASCAR ENERGY', '76.618.669-6', '', '', 'José Antonio Valdés Cobo', 'javaldes@solare.cl', '56988077810', 'Los Militares 5890, of 1604', 'Las Condes', 'José Antonio Valdés Cobo', 'LASCAR ENERGY SPA', 'PMGD,Generador');
INSERT INTO public.reuc VALUES (713, 'Estremera Energía', '76.920.632-9', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'Estremera Energía SpA', 'PMGD');
INSERT INTO public.reuc VALUES (714, 'Asesorías G-51', '76.105.907-6', '', '47630495.0', 'Rodrigo Danus Laucirica', 'rdanus@swc.cl', '56229273932', 'Alonso de Córdova 3827, Of. 801', 'Vitacura', 'Rodrigo Danus Laucirica', 'Asesorías G-51 SpA', 'Generador');
INSERT INTO public.reuc VALUES (715, 'FV Los Robles', '76.727.049-6', '', '', 'Oscar Sanchez', 'ingenieria@valfortec.com', '34964062901', 'La Concepcion 81, oficina 608', 'Providencia', 'Oscar Sanchez', 'Panguilemo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (716, 'ENAMI SOLAR SPA', '77.320.875-1', '', '75550000.0', 'Guillermo Hernández Martínez', 'ghernandez@biworenovables.com', '56944065850', 'Cerro el Plomo 5420, Zócalo -1', 'Las Condes', 'Luis Cid Diaz', 'ENAMI SOLAR SPA', 'PMGD');
INSERT INTO public.reuc VALUES (717, 'San Antonio SpA', '77.320.873-5', '', '', 'Guillermo Hernández Martínez', 'ghernandez@biworenovables.com', '56944065850', 'Cerro el Plomo 5420, Zócalo -1', 'Las Condes', 'Luis Cid Diaz', 'San Antonio SpA', 'PMGD');
INSERT INTO public.reuc VALUES (718, 'San Marino Solar', '77.337.635-2', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'San Marino Solar SpA', 'Generador');
INSERT INTO public.reuc VALUES (719, 'Parque Solar Don Flavio SpA', '76.871.337-5', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Don Flavio SpA', 'PMGD');
INSERT INTO public.reuc VALUES (720, 'Compañía Transmisora Sur', '77.733.308-9', '', '7520282.0', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Juan Pablo Kindermann', 'Compañía Transmisora Sur SpA', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (721, 'GR Algarrobo', '76.451.217-0', '', '', 'Felipe Pezo', 'fpezo@grenergy.eu', '56227515160', 'Av Isidora 2800 Of 3702 Las Condes Santiago', 'Las Condes', 'Ana Cuevas Esteban', 'GR Algarrobo SpA', 'Generador');
INSERT INTO public.reuc VALUES (722, 'Andes Solar IV', '76.625.173-0', '', '', 'Javier Federico Dib', 'javier.dib@aes.com', '56226868900', 'Los Conquistadores, piso 10', 'Providencia', 'Eduardo Verdugo', 'Andes Solar IV SpA', 'Generador');
INSERT INTO public.reuc VALUES (723, 'PFV El Caiquén', '77.122.294-3', '', '', 'Ricardo Sylvester Zapata', 'ricardo.sylvester@oenergy.cl', '56229695077', 'Av. Apoquindo 3910, oficina 201', 'Las Condes', 'Andrés Sylvester', 'PFV El Caiquén SpA', 'PMGD');
INSERT INTO public.reuc VALUES (724, 'Innergex', '76.097.069-7', '', '', 'Jaime Pino', 'jpino@innergex.com', '56223787970', 'Isidora Goyenechea 3477, Of. 211, Piso 21', 'Las Condes', 'Carlos De la Fuente', 'Innergex Energía Renovable SpA', 'Generador');
INSERT INTO public.reuc VALUES (725, 'Tralka', '76.780.504-7', '', '', 'David Orellana', 'david.orellana@aedilestalinay.com', '56229951065', 'Alonso de Córdova 5670, Oficina 503', 'Las Condes', 'Gonzalo Menares', 'Tralka SpA', 'PMGD');
INSERT INTO public.reuc VALUES (726, 'Ana María S.A.', '77.677.302-6', '', '', 'Olivia Heuts', 'oheuts@transelec.cl', '56224677202', 'Orinoco 90', 'Las Condes', 'María José Reveco', 'Ana María S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (727, 'Avenir', '76.237.387-4', '', '', 'Gustavo Riveros S.M', 'gustavo.riveros@matrizenergia.cl', '56224141440', 'La Concepción 141, oficina 705', 'Providencia', 'Cristián Aguayo Sanhueza', 'Avenir Solar Energy Chile SpA', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (728, 'PMGD Parque Farol Solar', '77.116.747-0', '', '8590594.0', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Farol Solar SpA', 'Generador');
INSERT INTO public.reuc VALUES (729, 'Energías Renovables El Boldo SpA', '77.110.485-1', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Energías Renovables El Boldo SpA', 'Generador');
INSERT INTO public.reuc VALUES (730, 'Patricia Solar SpA', '77.290.588-2', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Patricia Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (731, 'Transmisora Parinas S.A.', '77.244.437-0', '', '7560970.0', 'Arturo Le Blanc Cerda', 'aleblanc@transelec.cl', '56224677001', 'Orinoco 90, piso 14', 'Las Condes', 'María José Reveco', 'Transmisora Parinas S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (732, 'SAO PAULO SOLAR SPA', '77.029.464-9', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'SAO PAULO SOLAR SPA', 'Generador');
INSERT INTO public.reuc VALUES (733, 'PMGD Talagante', '77.470.143-5', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Tedlar Jupiter SpA', 'PMGD');
INSERT INTO public.reuc VALUES (734, 'Odata San Bernardo', '77.460.345-K', '', '8050000.0', 'Ignacio Larraín Echeverría', 'ignacio.larrain@odatacolocation.com', '56967613920', 'Camino San Esteban 01268', 'San Bernardo', 'Jorge León', 'Lo Espejo Data Center SpA', 'Cliente Libre,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (735, 'PMGD El Interlocutor', '77.213.669-2', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Parque Fotovoltaico Idahuillo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (736, 'Chequen', '77.044.651-1', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Chequen Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (737, 'Parque Solar Santa Cruz SpA', '76.939.914-3', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Santa Cruz SpA', 'PMGD');
INSERT INTO public.reuc VALUES (738, 'PFV El Trile', '76.979.064-0', '', '', 'Alessandro Di Falco', 'a.difalco@reden.solar', '56229299507', 'Los Militares 5953, Oficina 905', 'Las Condes', 'Lorenzo Urrutia Parra', 'PFV El Trile SpA', 'Generador');
INSERT INTO public.reuc VALUES (739, 'EA SF Pichilemu', '77.104.962-1', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'Energia Renovable Caoba SpA', 'PMGD');
INSERT INTO public.reuc VALUES (740, 'SOLAR TI TREINTA Y SIETE SPA', '77.290.267-0', '', '', 'Pablo Caerols Palma ', 'pcaerolspalma@vectorenewables.com', '56996263741', 'Los militares 4777, piso 21', 'Las Condes', 'Abel Huenchuñir', 'SOLAR TI TREINTA Y SIETE SpA', 'PMGD');
INSERT INTO public.reuc VALUES (741, 'SOLAR TI TREINTA Y SEIS SPA', '77.287.991-1', '', '', 'Pablo Caerols Palma ', 'pcaerolspalma@vectorenewables.com', '56996263741', 'Los militares 4777, piso 21', 'Las Condes', 'Abel Huenchuñir', 'SOLAR TI TREINTA Y SEIS SPA', 'PMGD');
INSERT INTO public.reuc VALUES (742, 'STM', '77.611.649-1', '', '', 'Francisco Alliende A.', 'francisco.alliende@saesa.cl', '56224147000', 'Bulnes 441', 'Osorno', 'Juan Alfonso Veloso Molina', 'Sociedad Transmisora Metropolitana S.A.', 'Transmisor Zonal,Transmisor Nacional,Transmisor Dedicado');
INSERT INTO public.reuc VALUES (743, 'CFC HOLDINGS', '77.092.712-9', '', '', 'Michael Dawson Minnes', 'mminnes@carbonfree.com', '56941164592', 'Reyes Lavalle 3340 of 1104', 'Las Condes', 'Jose Cubillo Cordero', 'CFC HOLDINGS SPA', 'Generador');
INSERT INTO public.reuc VALUES (744, 'Cabimas', '76.879.364-6', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'Fotovoltaica Arrayan SpA', 'Generador');
INSERT INTO public.reuc VALUES (745, 'SETF Energías Renovables', '77.447.115-4', '', '', 'Guillermo Hernández Martínez', 'ghernandez@biworenovables.com', '56944065850', 'Cerro el Plomo 5420, Zócalo -1', 'Las Condes', 'Luis Cid Diaz', 'SETF Energías Renovables SpA', 'Generador');
INSERT INTO public.reuc VALUES (746, 'CENTRAL EL PORTAL SPA', '77.622.635-1', '', '', 'José Tomás Urzúa González', 'turzua@inverges.cl', '56222973607', 'Avenida Las Condes 9460, oficina 1205', 'Las Condes', 'José Tomás Urzúa González', 'CENTRAL EL PORTAL SPA', 'Generador');
INSERT INTO public.reuc VALUES (747, 'Parque Fotovoltaico Pueblo Hundido', '77.270.737-1', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Fotovoltaica Pueblo Hundido SpA', 'PMGD');
INSERT INTO public.reuc VALUES (748, 'Draco', '77.139.383-7', '', '', 'Heon Bong Lee', 'tobong96@chilesolarjv.com', '56944521116', '1289 Luis Carrera', 'Vitacura', 'Seong Jin Kim', 'Draco Solar SpA', 'Generador');
INSERT INTO public.reuc VALUES (749, 'SEP', '77.504.635-K', '', '', 'Javier Moreno Hueyo', 'javier.morenoh@aguaspacifico.cl', '56229389456', 'Avda. Apoquindo 3472 piso 4', 'Las Condes', 'José Andrés San Martín Baeza', 'SUBESTACIÓN PUCHUNCAVÍ S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (750, 'SOLARITY', '76.378.413-4', '', '', 'Horacio Melo Torres', 'horacio@solarityenergia.com', '2222222', 'Cerro el Plomo 5855', 'Las Condes', '', 'SOLARITY SPA', 'PMGD');
INSERT INTO public.reuc VALUES (751, 'Chronos Solar', '77.152.866-K', '', '', 'Stefan Fritz', 'stefan.fritz@anumar.com', '56932661868', 'Andrés de Fuenzalida 17, of. 41', 'Providencia', 'Cristian Del Sante', 'Chronos Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (752, 'EDGECONNEX V', '77.394.032-0', '', '', 'Alfonso Ignacio Ugarte Cifuentes', 'tax1@puentesur.cl', '', '', '', 'Teresa Riveros', 'EDGECONNEX CHILE V SPA', 'Transmisor Zonal');
INSERT INTO public.reuc VALUES (753, 'Doña Rubena', '76.880.918-6', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'MVC Solar 48 SpA', 'PMGD');
INSERT INTO public.reuc VALUES (754, 'Planta Solar Santa Teresita', '77.262.079-9', '', '', 'Antonio Ros Mesa', 'rosantonio@grenergy.eu', '56222483253', 'Av Isidora Goyenechea 2800, of 3702', 'Las Condes', 'Ana Cuevas Esteban', 'Planta Solar Santa Teresita II SpA', 'PMGD');
INSERT INTO public.reuc VALUES (755, 'RTN SOLAR', '76.738.835-7', '', '', 'Pablo Caerols Palma ', 'pcaerols@enorchile.cl', '56996263741', 'Los militares 4777, piso 21', 'Las Condes', 'Abel Huenchuñir', 'RTN SOLAR SPA', 'PMGD');
INSERT INTO public.reuc VALUES (756, 'Parque Solar Unihue SpA', '77.454.461-5', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Parque Solar Unihue SpA', 'PMGD');
INSERT INTO public.reuc VALUES (757, 'Centella Transmisión', '76.930.823-7', '', '', 'Felipe Riquelme', 'friquelme@ferrovial.com', '56225606236', 'Av APoquindo 4700, Piso 13', 'Las Condes', 'Felipe Riquelme', 'Centella Transmisión S.A.', 'Transmisor Nacional');
INSERT INTO public.reuc VALUES (758, 'ANDINA SOLAR 1 SPA', '76.466.305-5', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'ANDINA SOLAR 1 SPA', 'PMGD');
INSERT INTO public.reuc VALUES (759, 'NITE', '77.324.794-3', '', '', 'Alan Heinen Alves Da Silva', 'alan.heinen@celeogroup.com', '56232024300', 'Apoquindo 4501, Oficina 1902', 'Las Condes', 'David Zamora Mesias', 'Nirivilo Transmisora de Energía S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (760, 'Pesaro Solar', '77.481.489-2', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Pesaro Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (761, 'Joel Solar SpA', '77.091.349-7', '', '', '', '', '', '', '', 'Sergio Mauricio Vogado Carvalho', 'Joel Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (763, 'RUBÉN SOLAR SPA', '77.084.907-1', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'RUBÉN SOLAR SPA', 'PMGD');
INSERT INTO public.reuc VALUES (764, 'Central Hidroeléctrica Quillaileo', '76.714.993-K', '', '', 'Juan León Obrecht', 'jlo@agrosonda.cl', '56223765202', 'Carretera General San Martin 16.500 15A', 'Colina', 'Juan León Obrecht', 'Central Hidroeléctrica Quillaileo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (765, 'PFV Doña Antonia', '76.464.074-8', '', '7561210.0', 'Juan Ignacio Alarcón', 'juanignacio.alarcon@mytilineos.com', '56973888892', 'rosario norte 407 oficina 1201', '', 'Luis Fredes', 'DOÑA ANTONIA SOLAR SPA', 'Generador');
INSERT INTO public.reuc VALUES (766, 'PMGD Río Lluta', '77.142.273-K', '', '', 'Emilio Pellegrini Munita', 'epm@decapital.cl', '56224245770', 'Rosario Norte 555, oficina 1601', 'Las Condes', 'Rodrigo Cabezas', 'El Peral SpA', 'PMGD');
INSERT INTO public.reuc VALUES (767, 'PMGD Loncura', '77.470.194-K', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Tedlar Diemos SpA', 'PMGD');
INSERT INTO public.reuc VALUES (768, 'PMGD Las Chilcas', '77.355.255-K', '', '7561211.0', 'Emilio Pellegrini Munita', 'epm@decapital.cl', '56224245770', 'Rosario Norte 555, oficina 1601', 'Las Condes', 'Rodrigo Cabezas', 'Las Chilcas Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (769, 'QUILMO SOLAR', '76.981.753-0', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'QUILMO SOLAR SPA', 'PMGD');
INSERT INTO public.reuc VALUES (770, 'Albemarle Limitada', '85.066.600-8', '', '', 'Roland Haemmerli', 'roland.haemmerli@albemarle.com', '', '', '', 'Ignacio Mehech Castellón', 'Albemarle Limitada', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (771, 'COPEC Renovables', '77.875.443-6', '', '', 'Javiera Belén Barcia Sir', 'jbarcia@copec.cl', '226907000', 'Isidora Goyenechea 2915, piso 20', 'Las Condes', 'Francisco Tobar', 'COPEC Renovables SpA', 'Generador');
INSERT INTO public.reuc VALUES (772, 'MACAO SOLAR', '76.972.535-0', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'MACAO SOLAR SPA', 'Generador');
INSERT INTO public.reuc VALUES (773, 'San Clemente Flor del Llano', '77.139.391-8', '', '7560994.0', 'Leonardo José León Orta', 'leon@akuoenergy.com', '56957403609', 'Américo Vespucio Norte 1090, of 203', 'Vitacura', 'Felipe Eduardo Domic Pérez', 'VESPA SOLAR SpA', 'PMGD');
INSERT INTO public.reuc VALUES (774, 'PFV El Loro Choroy', '77.131.289-6', '', '', 'Felipe Pezo', 'fpezo@grenergy.eu', '56227515160', 'Av Isidora 2800 Of 3702 Las Condes Santiago', 'Las Condes', 'Ana Cuevas Esteban', 'PFV El Loro Choroy SpA', 'PMGD');
INSERT INTO public.reuc VALUES (775, 'Verona Solar', '77.481.481-7', '', '', 'Sven Gysling Brinkmann', 'sven@ienergiagroup.com', '56226241971', 'Américo Vespucio 2680, oficina 111', 'Conchalí', 'Sven Gysling Brinkmann', 'Verona Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (776, 'GR Liun', '76.972.628-4', '', '', 'Felipe Pezo', 'fpezo@grenergy.eu', '56227515160', 'Av Isidora 2800 Of 3702 Las Condes Santiago', 'Las Condes', 'Ana Cuevas Esteban', 'GR Liun SpA', 'Generador');
INSERT INTO public.reuc VALUES (777, 'La Huerta', '76.723.809-6', '', '7560994.0', 'Leonardo José León Orta', 'leon@akuoenergy.com', '56957403609', 'Américo Vespucio Norte 1090, of 203', 'Vitacura', 'Felipe Eduardo Domic Pérez', 'La Huerta SPA', 'PMGD');
INSERT INTO public.reuc VALUES (778, 'SOLAR TI TREINTA Y OCHO SPA', '77.290.269-7', '', '', 'Pablo Caerols Palma ', 'pcaerolspalma@vectorenewables.com', '56996263741', 'Los militares 4777, piso 21', 'Las Condes', 'Abel Huenchuñir', 'SOLAR TI TREINTA Y OCHO SPA', 'PMGD');
INSERT INTO public.reuc VALUES (779, 'Hijuela 4', '76.879.361-1', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'Fotovoltaica Molle SpA', 'PMGD');
INSERT INTO public.reuc VALUES (780, 'PMG Venezia', '77.141.383-8', '', '', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Jose Ignacio Reid Tagle', 'Venezia Solar SpA', 'PMG');
INSERT INTO public.reuc VALUES (781, 'EURUS CHILE INVESTMENTS SPA', '77.324.657-2', '', '', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Jose Ignacio Reid Tagle', 'EURUS CHILE INVESTMENTS SPA', 'PMG');
INSERT INTO public.reuc VALUES (782, 'ANDINA SOLAR 2 SPA', '76.466.311-K', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'ANDINA SOLAR 2 SPA', 'Generador');
INSERT INTO public.reuc VALUES (783, 'Parque Solar La Rosa II', '77.324.561-4', '', '', 'David Orellana', 'david.orellana@aedilestalinay.com', '56229951065', 'Alonso de Córdova 5670, Oficina 503', 'Las Condes', 'Gonzalo Menares', 'Parque Solar La Rosa II SpA', 'PMGD');
INSERT INTO public.reuc VALUES (784, 'PUNTIAGUDO ENERGY', '76.618.666-1', '', '', 'José Antonio Valdés Cobo', 'javaldes@solare.cl', '56988077810', 'Los Militares 5890, of 1604', 'Las Condes', 'José Antonio Valdés Cobo', 'PUNTIAGUDO ENERGY SPA', 'Generador,PMGD');
INSERT INTO public.reuc VALUES (785, 'SANTA BARBARA ENERGY', '76.967.747-K', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'SANTA BARBARA ENERGY SPA', 'PMGD');
INSERT INTO public.reuc VALUES (786, 'Ravenna Solar', '77.137.574-K', '', '755019.0', 'Jose Ignacio Reid Tagle', 'jreid@eurusenergy.com', '56984191140', 'Nueva Tajamar 555, oficina 1102', 'Las Condes', 'Eduardo Antonio Astaburuaga Errázuriz', 'Ravenna Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (787, 'Pedro Solar SpA', '77.091.341-1', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Pedro Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (788, 'PSF Pataguilla', '77.011.973-1', '', '7550121.0', 'Michael Dawson Minnes', 'mminnes@carbonfree.com', '56941164592', 'Reyes Lavalle 3340 of 1104', 'Las Condes', 'Jose Cubillo Cordero', 'Pataguilla Solar SPA', 'Generador');
INSERT INTO public.reuc VALUES (789, 'Cox Energy Comercializadora SpA', '77.737.449-4', '', '', 'Emiliano Espinoza', 'e.espinoza@coxenergy.com', '56224029644', 'La Concepción 191 Oficina 1104', '', 'MAXIMIANO LETELIER LETELIER', 'Cox Energy Comercializadora SpA', 'Generador');
INSERT INTO public.reuc VALUES (790, 'PMGD Tortuga Solar', '77.214.128-9', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Tortuga Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (791, 'Cefalú Solar', '77.051.909-8', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Cefalú Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (792, 'Parque Solar  Tamarico', '76.359.632-K', '', '7561210.0', 'Juan Ignacio Alarcón', 'juanignacio.alarcon@mytilineos.com', '56973888892', 'rosario norte 407 oficina 1201', '', 'Luis Fredes', 'Tamarico Solar Dos SpA', 'Generador');
INSERT INTO public.reuc VALUES (793, 'Parque Solar Alianza SpA', '76.939.915-1', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Parque Solar Alianza SpA', 'Generador');
INSERT INTO public.reuc VALUES (794, 'PMGD Belén', '77.130.979-8', '', '', 'Catarina Azevedo Maia', 'catarina.maia@nextenergycapital.com', '34911986003', 'Av. Vitacura 2939, Oficina:1201', 'Santiago', 'Adriana Barua', 'GR Villarrica SpA', 'PMGD');
INSERT INTO public.reuc VALUES (795, 'Génova Solar SpA', '76.942.747-3', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Génova Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (796, 'PMGD BELENOS TIL TIL', '77.002.813-2', '', '', 'Michael Dawson Minnes', 'mminnes@carbonfree.com', '56941164592', 'Reyes Lavalle 3340 of 1104', 'Las Condes', 'Jose Cubillo Cordero', 'PARSOSY BELENOS SPA', 'PMGD');
INSERT INTO public.reuc VALUES (797, 'Planta FV Taira', '76.318.713-6', '', '7561210.0', 'Juan Ignacio Alarcón', 'juanignacio.alarcon@mytilineos.com', '56973888892', 'rosario norte 407 oficina 1201', '', 'Luis Fredes', 'Planta Solar Tocopilla SpA', 'Generador');
INSERT INTO public.reuc VALUES (798, 'Belén Solar SpA', '77.048.079-5', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Belén Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (799, 'Antu', '77.810.911-5', '', '', 'David Orellana', 'david.orellana@aedilestalinay.com', '56229951065', 'Alonso de Córdova 5670, Oficina 503', 'Las Condes', 'Gonzalo Menares', 'Antu Energy SpA', 'PMGD');
INSERT INTO public.reuc VALUES (800, 'PSF La Perla', '76.880.902-K', '', '7560994.0', 'Leonardo José León Orta', 'leon@akuoenergy.com', '56957403609', 'Américo Vespucio Norte 1090, of 203', 'Vitacura', 'Felipe Eduardo Domic Pérez', 'MVC Solar 38 SpA', 'PMGD');
INSERT INTO public.reuc VALUES (801, 'Quintacabrero', '76.812.966-5', '', '7560994.0', 'Leonardo José León Orta', 'leon@akuoenergy.com', '56957403609', 'Américo Vespucio Norte 1090, of 203', 'Vitacura', 'Felipe Eduardo Domic Pérez', 'Sol del Sur 9 SpA', 'PMGD');
INSERT INTO public.reuc VALUES (802, 'Cuarzo', '77.320.315-6', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'Energia Renovable Cuarzo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (803, 'La Confluencia Transmisión', '76.629.981-4', 'Registro segun carta DE 06334-24', '', 'JAVIER EDUARDO CARRASCO BRIONES', 'JCARRASCO@tenergia.cl', '56225194368', 'Avenida Cerro El Plomo 5630, Oficina 1702, Las Condes, Santiago', 'Las Condes', 'Javier Emilio Sepúlveda Saavedra', 'La Confluencia Transmisión S.A.', 'Transmisor Dedicado');
INSERT INTO public.reuc VALUES (804, 'PFV Leyda', '77.324.562-2', '', '', 'Stephanie Crichton Norero', 'crichton@solek.com', '56998281102', 'Apoquindo 4800 piso 15, Las Condes', '', 'Stephanie Crichton Norero', 'Parque Solar LEYDA SPA', 'PMGD');
INSERT INTO public.reuc VALUES (805, 'Pacific', '77.898.543-8', '', '', 'René Luis Retamales Bernal', 'rretamales@verano.energy', '56227239441', 'Av. Andrés Bello 2687, Of 1004', 'Las Condes', 'Rodrigo Daza Ibar', 'Pacific SpA', 'Generador');
INSERT INTO public.reuc VALUES (806, 'Parque Eólico Antofagasta', '76.188.406-9', '', '', 'Daniel Alejandro Tapia Castro', 'gestion.cen@repsol.com', '56223333540', 'Calle Cerro el Plomo 542, oficina nº1305. Edificio Parque Sur Las Condes.', 'Las Condes', 'Juan Marcelo Luengo', 'Parque Eólico Antofagasta SpA', 'Generador');
INSERT INTO public.reuc VALUES (807, 'PSF Chacaico', '76.812.974-6', '', '7560994.0', 'Leonardo José León Orta', 'leon@akuoenergy.com', '56957403609', 'Américo Vespucio Norte 1090, of 203', 'Vitacura', 'Felipe Eduardo Domic Pérez', 'Sol del sur 15 SpA', 'Generador');
INSERT INTO public.reuc VALUES (808, 'El Triunfo', '77.157.648-6', '', '', 'Mariano Ramiro Monedero Martinez', 'mariano.monedero@sungrow-re.com', '56223244672', 'Los Militares 5953, Nº 806', 'Las Condes', 'Roberto Antonio Plaza Yañez', 'Blue Solar Ocho SpA', 'Generador');
INSERT INTO public.reuc VALUES (809, 'LARQUI SOLAR', '77.501.276-5', '', '7550000.0', 'Juan Prieto Larrain', 'cen_matrix@revergy.es', '56957391650', 'Av Vitacura 2939 Piso 12', 'Las Condes', 'Morris Sosa Diaz', 'Larqui Solar SpA', 'Generador');
INSERT INTO public.reuc VALUES (810, 'Rucasol', '76.996.934-9', '', '', '', '', '', '', '', 'Alejandro Keller Hirsch', 'Rucasol SpA', 'Generador');
INSERT INTO public.reuc VALUES (811, 'PFV Los Naranjos', '77.136.405-5', '', '7550099.0', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Empresa eléctrica Ciprés SpA', 'Generador');
INSERT INTO public.reuc VALUES (812, 'PFV Isidro', '77.450.375-7', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Parque Solar San Isidro SpA', 'Generador');
INSERT INTO public.reuc VALUES (813, 'INIMA CHILE', '76.435.870-8', 'Fusión por absorción según carta DE00017-25 de Sociedad Boco Solar SpA', '', 'Beatriz Pilar Saiz Candeira', 'inima.chile@inima.com', '56228698086', 'Rosario Norte, 555. Oficina 1105.', 'Las Condes', 'Flavio Rosas', 'GS Inima Chile S.A.', 'Generador');
INSERT INTO public.reuc VALUES (814, 'Dongo Energía', '77.930.796-4', '', '', 'René Ilabaca', 'rilabaca@hidroelpaso.cl', '5627630479', 'Américo Vespucio Norte 1090', 'Vitacura', 'René Ilabaca', 'Dongo Energía SpA', 'Generador');
INSERT INTO public.reuc VALUES (815, 'Parque Solar Esmeralda', '77.023.431-K', '', '', 'Mariano Ramiro Monedero Martinez', 'mariano.monedero@sungrow-re.com', '56223244672', 'Los Militares 5953, Nº 806', 'Las Condes', 'Roberto Antonio Plaza Yañez', 'Parque Solar Esmeralda SpA', 'PMGD');
INSERT INTO public.reuc VALUES (816, 'PMGD Villa CVE', '77.088.123-4', '', '7550011.0', 'Luis Meersohn García-Huidobro', 'luis.meersohn@cvegroup.com', '56974170699', '', '', 'Victor Ramos Tapia', 'Solar TI Veinticuatro SpA', 'PMGD');
INSERT INTO public.reuc VALUES (817, 'FIRME ENERGIA SPA', '76.996.865-2', '', '', 'Alberto Treknais Rojas', 'Atreknais@hlt.cl', '56998770406', 'Jorge Vi 317, Casa C', 'Las Condes', 'José Tomás Urzúa González', 'Firme Energía SpA', 'PMGD');
INSERT INTO public.reuc VALUES (818, 'PMGD Chillan Huambalí Hiper', '77.139.386-1', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Tauro Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (819, 'BLUE SOLAR DOCE', '77.157.744-K', '', '', 'Pablo Caerols Palma ', 'pcaerolspalma@vectorenewables.com', '56996263741', 'Los militares 4777, piso 21', 'Las Condes', 'Abel Huenchuñir', 'Blue Solar Doce SpA', 'Generador');
INSERT INTO public.reuc VALUES (820, 'PFV Fragata', '77.363.389-4', '', '', 'Luis Alejandro Toledo Moreno', 'alejandrotoledo@cecltda.cl', '56752310389', 'Avda. Camilo Henríquez 153', 'Curicó', 'Carlos Arturo Riquelme Vargas', 'PFV Fragata SpA', 'PMGD');
INSERT INTO public.reuc VALUES (821, 'Cetus', '77.565.293-4', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'La Viña Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (822, 'PMG Villa Longaví', '77.324.643-2', '', '', 'David Orellana', 'david.orellana@aedilestalinay.com', '56229951065', 'Alonso de Córdova 5670, Oficina 503', 'Las Condes', 'Gonzalo Menares', 'Parque Solar Villa Longaví SpA', 'Generador');
INSERT INTO public.reuc VALUES (823, 'PMGD PVP Chinchorro', '76.871.329-4', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Parque Solar Benavente SpA', 'Generador');
INSERT INTO public.reuc VALUES (824, 'PMG Parque Fotovoltaico Cauquenes', '76.939.913-5', '', '', 'Luis Fernando Tovar Briceño', 'luis.tovar@nalarenewables.com', '56938683625', 'Isidora Goyenechea 2800, oficina 901A', 'Las Condes', 'Maria Alexandra Broderick Lorca', 'Parque Solar Viveros SpA', 'Generador');
INSERT INTO public.reuc VALUES (825, 'El Mirador', '77.912.475-4', '', '', 'Martin Riesco', 'MRIESCO@CHILESAT.NET', '56226767500', 'Los Conquistadores 1700 p-13', 'Providencia', 'Martin Riesco', 'El Mirador SpA', 'PMGD');
INSERT INTO public.reuc VALUES (826, 'Nueva Carena', '77.142.141-5', 'Registro de empresa según carta DE 00332-25', '', 'Alberto Treknais Rojas', 'Atreknais@hlt.cl', '56998770406', 'Jorge Vi 317, Casa C', 'Las Condes', 'José Tomás Urzúa González', 'Nueva Carena SpA', 'Generador');
INSERT INTO public.reuc VALUES (827, 'FV EL TRÉBOL', '76.549.476-1', '', '', 'Erwin Eduardo Thieme Neira', 'Erwin.Thieme@gestiongerencial.cl', '56993424002', 'La concepción 81 Of.608', 'Providencia', 'Oscar Sanchez', 'Portezuelo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (828, 'PMGD Persefone Solar', '77.087.896-9', '', '7550011.0', '', '', '', '', '', 'Victor Ramos Tapia', 'CVE Proyecto Treinta y Uno SpA', 'Generador');
INSERT INTO public.reuc VALUES (829, 'Las Tacas', '77.285.437-4', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'Las Tacas II SpA', 'PMGD');
INSERT INTO public.reuc VALUES (830, 'PMGD Margarita X', '76.888.367-K', '', '', 'Camila Andrea Álvarez Rojas', 'c.alvarez@solek.com', '--', 'Apoquindo 5400, piso 21', 'Las Condes', 'Sergio Mauricio Vogado Carvalho', 'Margarita Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (831, 'Solaris', '77.303.354-4', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'Cerrillos SpA', 'Generador');
INSERT INTO public.reuc VALUES (832, 'PMGD Casa de Lata', '77.447.177-4', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'Tedlar Mercurio SpA', 'PMGD');
INSERT INTO public.reuc VALUES (833, 'Desierto de Atacama', '76.278.665-6', '', '7550101.0', 'Renzo Valentino', 'rvalentino@pacifichydro.cl', '56225194200', 'Av. Isidora Goyenechea 3520 piso 10', 'Las Condes', 'Luis Osvaldo Nuñez Herrera', 'Copiapó Solar SpA', 'Generador');
INSERT INTO public.reuc VALUES (834, 'PMGD Taruca', '77.057.153-7', '', '', 'Emilio Pellegrini Munita', 'epm@decapital.cl', '56224245770', 'Rosario Norte 555, oficina 1601', 'Las Condes', 'Rodrigo Cabezas', 'Taruca Solar SpA', 'PMGD');
INSERT INTO public.reuc VALUES (835, 'Florida Energía SpA', '78.058.492-0', '', '', 'Gabriela Jazmín Sáez Aguilera', 'gabrielasaezaguilera@gmail.com', '56942112229', 'Av Las Margaritas 1415, D 211', 'San Pedro de la Paz', 'Gabriela Jazmín Sáez Aguilera', 'Florida Energía SpA', 'PMGD');
INSERT INTO public.reuc VALUES (836, 'Solar Ti 34', '77.290.266-2', '', '', 'Abel Huenchuñir', 'ahuenchunir@vectorenewables.com', '56995437167', 'Los Militares 4777, Oficina 2101,', 'Las Condes', 'Pablo Caerols Palma ', 'Solar Ti Treinta y Cuatro SpA', 'PMGD');
INSERT INTO public.reuc VALUES (837, 'Enlight', '77.916.002-5', 'Registro de empresa nueva segun carta DE01830-25', '7580069.0', 'Mauricio Ortuondo Doyharcabal', 'mauricio.ortuondo@enlight.cl', '56988996762', 'PUERTA DEL SOL 80 OF 108, LAS CONDES', 'Las Condes', 'Aura Rearte Jorquera', 'Enlight Investments SpA', 'Generador');
INSERT INTO public.reuc VALUES (838, 'PFV Peumo', '77.136.409-8', '', '', 'Alexis Piwonka Muñoz', 'apiwonka@revergy.es', '56964492220', 'Nueva Tajamar 481, Torres Sur of 1903', 'Las Condes', 'Jose Campos Castillo', 'Empresa Eléctrica Peumo SpA', 'Generador');
INSERT INTO public.reuc VALUES (839, 'BESS del Desierto', '77.176.766-4', '', '', 'Luis Alfredo Solar Pinedo ', 'asolar@atlasren.com', '56226118300', 'Apoquindo 3472, piso 9', 'Las Condes', 'Tomás Ávila Araya', 'BESS del Desierto SpA', 'PMGD');
INSERT INTO public.reuc VALUES (840, 'Collanco', '76.972.735-3', '', '7560994.0', 'Leonardo José León Orta', 'leon@akuoenergy.com', '56957403609', 'Américo Vespucio Norte 1090, of 203', 'Vitacura', 'Felipe Eduardo Domic Pérez', 'Blue Solar Uno SpA', 'Generador');
INSERT INTO public.reuc VALUES (841, 'NexVolt', '78.046.982-K', '', '', 'MARIO PAVEZ', 'mario.pavez@atriaenergia.com', '56966126694', 'Candelaria Goyenechea 3900, Of 203', 'Vitacura', 'MARIO PAVEZ', 'Linxergy SpA', 'PMGD');
INSERT INTO public.reuc VALUES (842, 'Socohi', '76.128.835-0', '--Comentario---', '', 'Ivonne Bell Rodríguez', 'ibell@hidrolena.com', '56222282859', 'Málaga 115, of. 709', 'Las Condes', 'Ivonne Bell Rodríguez', 'Sociedad Constructora de Obras Hidráulicas SpA', 'Generador');
INSERT INTO public.reuc VALUES (843, 'Odata', '77.128.355-1', '', '', 'Ignacio Larraín Echeverría', 'ignacio.larrain@odatacolocation.com', '56967613920', 'Camino San Esteban 01268', 'San Bernardo', 'Jorge León', 'Odata Chile SpA', 'PMGD');
INSERT INTO public.reuc VALUES (844, 'Fénix', '77.328.914-K', '', '', 'Edward Muriel', 'edward.muriel@nextenergycapital.com', '34911986003', 'Av. Vitacura 2939, Oficina: 1201, Las Condes', '', 'Adriana Barua', 'Fénix SpA', 'Generador');
INSERT INTO public.reuc VALUES (845, 'Encina', '76.923.618-K', '', '', 'José Luis Bernardo Ilabaca Searle', 'jlilabaca@dsabogados.cl', '', '', '', 'Stephano Pablo Absalon Chaura Montenegro', 'Encina SpA', 'PMGD');
INSERT INTO public.reuc VALUES (846, 'Ener Services SpA', '77.878.857-8', '', '', 'Andrés Alfonso Rodríguez Álvarez', 'arodriguez@ener.cl', '56977575830', 'Las Margaritas #121, Interior, San Pedro de la Paz', '', 'Andrés Alfonso Rodríguez Álvarez', 'Ener Services SpA', 'Generador');
INSERT INTO public.reuc VALUES (847, 'Ranguil', '76.541.893-3', '', '', 'Francisco Javier Promis Baeza', 'fpromis@daelimlatam.com', '56940558006', 'Av. Isidora Goyenechea 2800, piso 39, Las Condes', 'Las Condes', 'Martin Troncoso Belgeri', 'Ranguil SpA', 'PMGD');
INSERT INTO public.reuc VALUES (848, 'Respaldo y Potencia', '77.949.063-7', '', '', 'Juan León Obrecht', 'jlo@agrosonda.cl', '56223765202', 'Carretera General San Martin 16.500 15A', 'Colina', 'Juan León Obrecht', 'Respaldo y Potencia SpA', 'PMGD');
INSERT INTO public.reuc VALUES (849, 'Belloto', '76.882.322-7', '', '', 'José Luis Bernardo Ilabaca Searle', 'jlilabaca@dsabogados.cl', '', '', '', 'Stephano Pablo Absalon Chaura Montenegro', 'Belloto SpA', 'PMGD');
INSERT INTO public.reuc VALUES (850, 'Puig Sunlight', '77.264.929-0', '', '75550000.0', 'Guillermo Hernández Martínez', 'ghernandez@biworenovables.com', '56944065850', 'Cerro el Plomo 5420, Zócalo -1', 'Las Condes', 'Luis Cid Diaz', 'Malloa Solar SpA', 'Generador');
INSERT INTO public.reuc VALUES (851, 'Millahue', '76.972.749-3', '', '', 'Ana Ruiz Portillo', 'ana.ruiz@nextenergycapital.com', '34919613784', 'Avenida de Vitacura, 1201', 'Las Condes', 'Adriana Barua', 'Blue Solar Cinco SpA', 'Generador');
INSERT INTO public.reuc VALUES (852, 'PFV Tutuven', '76.871.339-1', '', '8320000.0', 'Felipe Pezo', 'fpezo@grenergy.eu', '56227515160', 'Av Isidora 2800 Of 3702 Las Condes Santiago', 'Las Condes', 'Ana Cuevas Esteban', 'Parque Solar Tangua SpA', 'PMGD');
INSERT INTO public.reuc VALUES (853, 'EVOL', '77.648.436-9', 'Fusión por absorción según carta DE 03043-25', '', 'Andrés Guerrero Marco', 'gestion@ecomenergia.cl', '56232443770', 'Bucarest 150', 'Providencia', 'Rodrigo Garcia', 'EVOL SpA', 'PMGD');
INSERT INTO public.reuc VALUES (854, 'Perla del Norte', '77.287.819-2', '', '', 'Edward Muriel', 'edward.muriel@nextenergycapital.com', '34911986003', 'Av. Vitacura 2939, Oficina: 1201, Las Condes', '', 'Adriana Barua', 'Solar TI Treinta y Uno SpA', 'Generador');
INSERT INTO public.reuc VALUES (855, 'PFV Chamonate Solar (Ex Toledo Dos)', '77.333.027-1', '', '8590594.0', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'Paula Domínguez', 'Toledo Solar SpA', 'Generador');
INSERT INTO public.reuc VALUES (856, 'Algarrobo', '76.882.304-9', '', '', 'José Luis Bernardo Ilabaca Searle', 'jlilabaca@dsabogados.cl', '', '', '', 'Stephano Pablo Absalon Chaura Montenegro', 'Algarrobo SpA', 'PMGD');
INSERT INTO public.reuc VALUES (857, 'Boix', '77.184.171-6', '', '', 'Pablo Maestri Muñoz', 'pablomaestri@im2solar.cl', '56229539592', 'ALONSO DE MONROY 2677 OFICINA 302', 'Las Condes', 'Miguel Buzunariz Ramos', 'Boix SpA', 'PMGD');
INSERT INTO public.reuc VALUES (858, 'Pudidi', '76.432.945-7', '', '', 'Martín Antonio Valdés Joannon', 'mvaldesj@gmail.com', '56975171210', 'Av. Juan de la Fuente 734', 'Lampa', 'Martín Antonio Valdés Joannon', 'Energias Pudidi SpA', 'PMGD');
INSERT INTO public.reuc VALUES (859, 'FV Esmeralda', '76.863.483-1', '', '', '', '', '', '', '', 'Mauricio Helmke Ruiz', 'Fotovoltaica Cipres SpA', 'PMGD');
INSERT INTO public.reuc VALUES (860, 'Falcon', '77.084.795-8', '', '', '', '', '', '', '', 'Martin Troncoso Belgeri', 'Energía Renovable Roble SpA', 'PMGD');
INSERT INTO public.reuc VALUES (861, 'Parque Solar San Ramón', '77.337.564-K', '', '', 'David Rau', 'd.rau@fluxsolar.cl', '56984246379', 'El Rosal 5108', 'Huechuraba', 'María José Quiroga', 'San Ramon Solar SpA', 'Generador');


--
-- TOC entry 3445 (class 0 OID 16715)
-- Dependencies: 220
-- Data for Name: sub_norma; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sub_norma VALUES (1, 1, NULL, 1, 'Disponibilidad SITR', 'Mensual', 'a');
INSERT INTO public.sub_norma VALUES (2, 1, NULL, 1, 'TIEMPOS DE ACTUALIZACIÓN DEL SITR', 'Mensual', 'a');
INSERT INTO public.sub_norma VALUES (3, 1, NULL, 2, 'DISPONIBILIDAD CANALES DE VOZ', 'Mensual', 'b');
INSERT INTO public.sub_norma VALUES (4, 1, NULL, 4, 'DISPONIBILIDAD CANALES DE TELEPROTECCIÓN', 'Mensual', 'c');
INSERT INTO public.sub_norma VALUES (5, 1, NULL, 4, 'IMPLEMENTACIÓN DE ESQUEMAS EDAC', 'Mensual', 'd');
INSERT INTO public.sub_norma VALUES (6, 1, NULL, 4, 'IMPLEMENTACIÓN DE ESQUEMAS EDAG', 'Mensual', 'd');
INSERT INTO public.sub_norma VALUES (7, 1, NULL, 4, 'IMPLEMENTACIÓN DE ESQUEMAS ERAG', 'Mensual', 'd');
INSERT INTO public.sub_norma VALUES (8, 1, NULL, 3, 'IMPLEMENTACIÓN DE PLANES DE RECUPERACIÓN DE SERVICIO (PRS) - IMPLEMENTACIÓN', 'Mensual', 'e');
INSERT INTO public.sub_norma VALUES (9, 1, NULL, 3, 'IMPLEMENTACIÓN DE PLANES DE RECUPERACIÓN DE SERVICIO (PRS) - PRUEBAS DE VERIFICACIÓN DEL PRS', 'Mensual', 'f');
INSERT INTO public.sub_norma VALUES (10, 1, NULL, 5, 'IMPLEMENTACIÓN PLANES DE DEFENSA CONTRA CONTINGENCIAS', 'Mensual', 'g');
INSERT INTO public.sub_norma VALUES (11, 1, NULL, 5, 'COMPENSACIÓN REACTIVA EN SISTEMAS DE TRANSMISIÓN', 'Mensual', 'h');
INSERT INTO public.sub_norma VALUES (12, 1, NULL, 4, 'INDISPONIBILIDAD PROGRAMADA - RESUMEN DE GENERACIÓN', 'Mensual', 'i');
INSERT INTO public.sub_norma VALUES (13, 1, NULL, 4, 'INDISPONIBILIDAD FORZADA - RESUMEN DE GENERACIÓN', 'Mensual', 'i');
INSERT INTO public.sub_norma VALUES (14, 1, NULL, 4, 'INDISPONIBILIDAD PROGRAMADA - RESUMEN DE TRANSMISIÓN', 'Mensual', 'i');
INSERT INTO public.sub_norma VALUES (15, 1, NULL, 4, 'INDISPONIBILIDAD FORZADA - RESUMEN DE TRANSMISIÓN', 'Mensual', 'i');
INSERT INTO public.sub_norma VALUES (16, 1, NULL, 6, 'SISTEMA DE MEDIDAS DE TRANSFERENCIAS ECONÓMICAS', 'Mensual', 'j');
INSERT INTO public.sub_norma VALUES (17, 1, NULL, 8, 'SISTEMA DE MONITOREO MÓDULO DE MEDICIÓN FASORIAL (PMU)', 'Mensual', 'k');


--
-- TOC entry 3451 (class 0 OID 16761)
-- Dependencies: 226
-- Data for Name: tipo_cumplimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_cumplimiento VALUES (1, 'Mensual');
INSERT INTO public.tipo_cumplimiento VALUES (2, 'Anual');


--
-- TOC entry 3460 (class 0 OID 24617)
-- Dependencies: 235
-- Data for Name: tipo_evento_seg; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 227
-- Name: tabla_cumplimiento_id_cumplimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_cumplimiento_id_cumplimiento_seq', 1, false);


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 221
-- Name: tabla_departamento_id_departamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_departamento_id_departamento_seq', 1, false);


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 229
-- Name: tabla_detalle_cumplimiento_id_detalle_cumplimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_detalle_cumplimiento_id_detalle_cumplimiento_seq', 1, false);


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 223
-- Name: tabla_homologacion_id_homologacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_homologacion_id_homologacion_seq', 1, false);


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 217
-- Name: tabla_norma_id_norma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_norma_id_norma_seq', 1, false);


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 231
-- Name: tabla_reuc_id_reuc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_reuc_id_reuc_seq', 861, true);


--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 219
-- Name: tabla_sub_norma_id_sub_norma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_sub_norma_id_sub_norma_seq', 1, false);


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 225
-- Name: tabla_tipo_cumplimiento_id_tipo_cumplimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_tipo_cumplimiento_id_tipo_cumplimiento_seq', 1, false);


--
-- TOC entry 3286 (class 2606 OID 24621)
-- Name: tipo_evento_seg carta_estado_seguimiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_evento_seg
    ADD CONSTRAINT carta_estado_seguimiento_pk PRIMARY KEY (id_tipo_evento_seg);


--
-- TOC entry 3282 (class 2606 OID 24598)
-- Name: carta_incpmt carta_incumplimiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carta_incpmt
    ADD CONSTRAINT carta_incumplimiento_pk PRIMARY KEY (id_carta_incpmt);


--
-- TOC entry 3284 (class 2606 OID 24616)
-- Name: carta_incpmt_seg carta_seguimiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carta_incpmt_seg
    ADD CONSTRAINT carta_seguimiento_pk PRIMARY KEY (id_cartas_incpmt_seg);


--
-- TOC entry 3276 (class 2606 OID 16777)
-- Name: cumplimiento tabla_cumplimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumplimiento
    ADD CONSTRAINT tabla_cumplimiento_pkey PRIMARY KEY (id_cumplimiento);


--
-- TOC entry 3270 (class 2606 OID 16736)
-- Name: departamento tabla_departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT tabla_departamento_pkey PRIMARY KEY (id_departamento);


--
-- TOC entry 3278 (class 2606 OID 16796)
-- Name: detalle_cumplimiento tabla_detalle_cumplimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cumplimiento
    ADD CONSTRAINT tabla_detalle_cumplimiento_pkey PRIMARY KEY (id_detalle_cumplimiento);


--
-- TOC entry 3272 (class 2606 OID 16754)
-- Name: homologacion tabla_homologacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homologacion
    ADD CONSTRAINT tabla_homologacion_pkey PRIMARY KEY (id_homologacion);


--
-- TOC entry 3266 (class 2606 OID 16713)
-- Name: norma tabla_norma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.norma
    ADD CONSTRAINT tabla_norma_pkey PRIMARY KEY (id_norma);


--
-- TOC entry 3280 (class 2606 OID 16815)
-- Name: reuc tabla_reuc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reuc
    ADD CONSTRAINT tabla_reuc_pkey PRIMARY KEY (id_reuc);


--
-- TOC entry 3268 (class 2606 OID 16722)
-- Name: sub_norma tabla_sub_norma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_norma
    ADD CONSTRAINT tabla_sub_norma_pkey PRIMARY KEY (id_sub_norma);


--
-- TOC entry 3274 (class 2606 OID 16768)
-- Name: tipo_cumplimiento tabla_tipo_cumplimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cumplimiento
    ADD CONSTRAINT tabla_tipo_cumplimiento_pkey PRIMARY KEY (id_tipo_cumplimiento);


--
-- TOC entry 3294 (class 2606 OID 24624)
-- Name: carta_incpmt carta_incpmt_cumplimiento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carta_incpmt
    ADD CONSTRAINT carta_incpmt_cumplimiento_fk FOREIGN KEY (id_cumplimiento) REFERENCES public.cumplimiento(id_cumplimiento);


--
-- TOC entry 3295 (class 2606 OID 24629)
-- Name: carta_incpmt_seg carta_incpmt_seg_carta_evento_seg_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carta_incpmt_seg
    ADD CONSTRAINT carta_incpmt_seg_carta_evento_seg_fk FOREIGN KEY (id_tipo_evento_seg) REFERENCES public.tipo_evento_seg(id_tipo_evento_seg);


--
-- TOC entry 3296 (class 2606 OID 24634)
-- Name: carta_incpmt_seg carta_incpmt_seg_carta_incpmt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carta_incpmt_seg
    ADD CONSTRAINT carta_incpmt_seg_carta_incpmt_fk FOREIGN KEY (id_carta_incpmt) REFERENCES public.carta_incpmt(id_carta_incpmt);


--
-- TOC entry 3290 (class 2606 OID 16821)
-- Name: cumplimiento cumplimiento_detalle_cumplimiento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumplimiento
    ADD CONSTRAINT cumplimiento_detalle_cumplimiento_fk FOREIGN KEY (id_detalle_cumplimiento) REFERENCES public.detalle_cumplimiento(id_detalle_cumplimiento);


--
-- TOC entry 3291 (class 2606 OID 24576)
-- Name: cumplimiento cumplimiento_reuc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumplimiento
    ADD CONSTRAINT cumplimiento_reuc_fk FOREIGN KEY (id_reuc) REFERENCES public.reuc(id_reuc);


--
-- TOC entry 3292 (class 2606 OID 16827)
-- Name: cumplimiento cumplimiento_tipo_cumplimiento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumplimiento
    ADD CONSTRAINT cumplimiento_tipo_cumplimiento_fk FOREIGN KEY (id_tipo_cumplimiento) REFERENCES public.tipo_cumplimiento(id_tipo_cumplimiento);


--
-- TOC entry 3287 (class 2606 OID 24587)
-- Name: sub_norma sub_norma_departamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_norma
    ADD CONSTRAINT sub_norma_departamento_fk FOREIGN KEY (id_departamento) REFERENCES public.departamento(id_departamento);


--
-- TOC entry 3293 (class 2606 OID 16778)
-- Name: cumplimiento tabla_cumplimiento_id_sub_norma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumplimiento
    ADD CONSTRAINT tabla_cumplimiento_id_sub_norma_fkey FOREIGN KEY (id_sub_norma) REFERENCES public.sub_norma(id_sub_norma);


--
-- TOC entry 3289 (class 2606 OID 16755)
-- Name: homologacion tabla_homologacion_id_sub_norma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homologacion
    ADD CONSTRAINT tabla_homologacion_id_sub_norma_fkey FOREIGN KEY (id_sub_norma) REFERENCES public.sub_norma(id_sub_norma);


--
-- TOC entry 3288 (class 2606 OID 16723)
-- Name: sub_norma tabla_sub_norma_id_norma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_norma
    ADD CONSTRAINT tabla_sub_norma_id_norma_fkey FOREIGN KEY (id_norma) REFERENCES public.norma(id_norma);


-- Completed on 2025-07-01 16:40:56

--
-- PostgreSQL database dump complete
--

