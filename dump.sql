--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3 (Debian 11.3-1.pgdg100+1)
-- Dumped by pg_dump version 11.3 (Debian 11.3-1.pgdg100+1)

-- Started on 2019-06-06 15:22:00 -03

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
-- TOC entry 243 (class 1255 OID 26389)
-- Name: perdida_elemento(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.perdida_elemento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  IdRegistroElemento INTEGER;
  IdElemento INTEGER;
  IdArea INTEGER;
  IdPerdida INTEGER;
BEGIN
  -- SELECT OLD.IdRegistroElemento, OLD.IdElemento, OLD.IdArea
  -- INTO IdRegistroElemento, IdElemento, IdArea;
  IdRegistroElemento := OLD.IdRegistroElemento;
  IdElemento := OLD.IdElemento;
  IdArea := OLD.IdArea;
  
  INSERT INTO ElementosPerdidos(IdRegistroElemento, IdElemento, IdArea) 
  VALUES (IdRegistroElemento, IdElemento, IdArea)
  RETURNING ElementosPerdidos.IdPerdida INTO IdPerdida;
  
  perform pg_notify('perdida_elemento', IdPerdida::TEXT);
  RETURN OLD;
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 26390)
-- Name: alojamiento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alojamiento (
    idalojamiento integer NOT NULL,
    capacidad integer,
    categoria double precision,
    idparque integer
);


--
-- TOC entry 197 (class 1259 OID 26393)
-- Name: animal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.animal (
    idelemento integer NOT NULL,
    tipoalimentacion text,
    periodocelo text
);


--
-- TOC entry 198 (class 1259 OID 26399)
-- Name: area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area (
    idarea integer NOT NULL,
    nombre text,
    superficie integer,
    idparque integer
);


--
-- TOC entry 199 (class 1259 OID 26405)
-- Name: comestible; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comestible (
    idelemento integer NOT NULL,
    tipocomestible text
);


--
-- TOC entry 200 (class 1259 OID 26411)
-- Name: confloracion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.confloracion (
    idelemento integer NOT NULL,
    periodofloracion text
);


--
-- TOC entry 201 (class 1259 OID 26417)
-- Name: conservacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conservacion (
    idpersonal integer NOT NULL,
    especializacion text,
    idarea integer
);


--
-- TOC entry 202 (class 1259 OID 26423)
-- Name: contiene; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contiene (
    idprovincia integer NOT NULL,
    idparque integer NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 26426)
-- Name: elementonatural; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.elementonatural (
    idelemento integer NOT NULL,
    nombrecientifico text,
    nombrevulgar text,
    tipoelemento text
);


--
-- TOC entry 230 (class 1259 OID 26853)
-- Name: elementosperdidos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.elementosperdidos (
    idperdida integer NOT NULL,
    idregistroelemento integer NOT NULL,
    idelemento integer,
    idarea integer,
    emailenviado boolean DEFAULT false NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 26851)
-- Name: elementosperdidos_idperdida_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.elementosperdidos_idperdida_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 229
-- Name: elementosperdidos_idperdida_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.elementosperdidos_idperdida_seq OWNED BY public.elementosperdidos.idperdida;


--
-- TOC entry 204 (class 1259 OID 26435)
-- Name: estadia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estadia (
    idalojamiento integer NOT NULL,
    fecha date NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 26438)
-- Name: excursion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.excursion (
    idpropuesta integer NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 26441)
-- Name: gestion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gestion (
    idpersonal integer NOT NULL,
    numeroentrada integer
);


--
-- TOC entry 207 (class 1259 OID 26444)
-- Name: investiga; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.investiga (
    idinvestigador integer NOT NULL,
    idproyecto integer NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 26447)
-- Name: investigador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.investigador (
    idpersonal integer NOT NULL,
    titulacion text
);


--
-- TOC entry 209 (class 1259 OID 26453)
-- Name: mineral; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mineral (
    idelemento integer NOT NULL,
    tipomineral text
);


--
-- TOC entry 210 (class 1259 OID 26459)
-- Name: ocupadopor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ocupadopor (
    idalojamiento integer NOT NULL,
    fechaestadia date NOT NULL,
    idvisitante integer NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 26462)
-- Name: ofrece; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ofrece (
    idalojamiento integer NOT NULL,
    idpropuesta integer NOT NULL
);


--
-- TOC entry 212 (class 1259 OID 26465)
-- Name: organismo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organismo (
    idorganismo integer NOT NULL,
    nombre text
);


--
-- TOC entry 213 (class 1259 OID 26471)
-- Name: parque; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parque (
    idparque integer NOT NULL,
    nombre text,
    fechadeclaracion date,
    emailcontacto text
);


--
-- TOC entry 214 (class 1259 OID 26477)
-- Name: participade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.participade (
    idvisitante integer NOT NULL,
    idpropuesta integer NOT NULL,
    fechapropuesta date NOT NULL,
    horapropuesta time without time zone NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 26480)
-- Name: personal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personal (
    idpersonal integer NOT NULL,
    tipopersonal text,
    nombre text,
    direccion text,
    telefonomovil text,
    dni text,
    cuil text,
    telefonodomicilio text
);


--
-- TOC entry 216 (class 1259 OID 26486)
-- Name: propuestadeexcursion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.propuestadeexcursion (
    idpropuesta integer NOT NULL,
    mobilidad text,
    descripcion text
);


--
-- TOC entry 217 (class 1259 OID 26492)
-- Name: propuestadias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.propuestadias (
    idpropuesta integer NOT NULL,
    dia text NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 26498)
-- Name: propuestahoras; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.propuestahoras (
    idpropuesta integer NOT NULL,
    hora time without time zone NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 26501)
-- Name: provincia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provincia (
    idprovincia integer NOT NULL,
    nombre text,
    idorganismo integer
);


--
-- TOC entry 220 (class 1259 OID 26507)
-- Name: provincia_cantparques; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.provincia_cantparques AS
SELECT
    NULL::integer AS idprovincia,
    NULL::text AS nombre,
    NULL::bigint AS cantparques;


--
-- TOC entry 221 (class 1259 OID 26511)
-- Name: proyecto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.proyecto (
    idproyecto integer NOT NULL,
    presupuesto double precision,
    periodo daterange,
    idelementonatural integer
);


--
-- TOC entry 222 (class 1259 OID 26517)
-- Name: recorrido; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recorrido (
    idrecorrido integer NOT NULL,
    idpersonalvigilancia integer,
    idarea integer,
    matriculavehiculo text
);


--
-- TOC entry 223 (class 1259 OID 26523)
-- Name: registroelemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registroelemento (
    idregistroelemento integer NOT NULL,
    idelemento integer,
    idarea integer
);


--
-- TOC entry 224 (class 1259 OID 26526)
-- Name: sealimentade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sealimentade (
    iddepredador integer NOT NULL,
    idpresa integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 26529)
-- Name: trabajaen; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trabajaen (
    idpersonal integer NOT NULL,
    idparque integer NOT NULL,
    sueldo double precision
);


--
-- TOC entry 226 (class 1259 OID 26532)
-- Name: vegetal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vegetal (
    idelemento integer NOT NULL,
    tipovegetal text
);


--
-- TOC entry 227 (class 1259 OID 26538)
-- Name: vehiculo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vehiculo (
    matricula text NOT NULL,
    tipo text
);


--
-- TOC entry 228 (class 1259 OID 26544)
-- Name: visitante; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.visitante (
    idvisitante integer NOT NULL,
    nombre text,
    domicilio text,
    profesion text,
    dni text
);


--
-- TOC entry 2929 (class 2604 OID 26856)
-- Name: elementosperdidos idperdida; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.elementosperdidos ALTER COLUMN idperdida SET DEFAULT nextval('public.elementosperdidos_idperdida_seq'::regclass);


--
-- TOC entry 3158 (class 0 OID 26390)
-- Dependencies: 196
-- Data for Name: alojamiento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alojamiento (idalojamiento, capacidad, categoria, idparque) FROM stdin;
1	5	8	1
2	3	9	1
3	10	6	1
4	3	10	1
5	6	7	1
6	15	5	2
7	15	5	2
8	15	5	2
9	15	5	2
10	15	5	2
11	4	9	3
12	4	9	3
13	4	9	3
14	2	10	3
15	2	10	3
16	2	8	3
17	2	8	3
18	2	8	3
19	2	8	3
20	2	8	3
\.


--
-- TOC entry 3159 (class 0 OID 26393)
-- Dependencies: 197
-- Data for Name: animal; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.animal (idelemento, tipoalimentacion, periodocelo) FROM stdin;
15	herbivoro	inviero
16	herbivoro	verano
17	omnivoro	marzo a mayo
18	carnivoro	verano
\.


--
-- TOC entry 3160 (class 0 OID 26399)
-- Dependencies: 198
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.area (idarea, nombre, superficie, idparque) FROM stdin;
1	valle	300	1
2	colina	500	1
3	ladera	100	1
4	luna	200	1
5	tierra	400	1
6	sol	200	2
7	glam	100	2
8	super	300	2
9	chamo	400	2
10	giro	30	2
11	rose	10	2
12	jarro	30	2
13	valle	100	3
14	pradera	2000	4
15	nube	150	5
16	prado	300	6
17	valle	160	7
18	valle	450	8
\.


--
-- TOC entry 3161 (class 0 OID 26405)
-- Dependencies: 199
-- Data for Name: comestible; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.comestible (idelemento, tipocomestible) FROM stdin;
4	vegetal
5	vegetal
6	vegetal
7	vegetal
8	vegetal
9	vegetal
10	vegetal
11	vegetal
12	vegetal
13	vegetal
14	vegetal
15	animal
16	animal
17	animal
18	animal
\.


--
-- TOC entry 3162 (class 0 OID 26411)
-- Dependencies: 200
-- Data for Name: confloracion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.confloracion (idelemento, periodofloracion) FROM stdin;
10	enero a febrero
11	febrero a marzo
12	verano
13	invierno
14	verano a invierno
\.


--
-- TOC entry 3163 (class 0 OID 26417)
-- Dependencies: 201
-- Data for Name: conservacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conservacion (idpersonal, especializacion, idarea) FROM stdin;
\.


--
-- TOC entry 3164 (class 0 OID 26423)
-- Dependencies: 202
-- Data for Name: contiene; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contiene (idprovincia, idparque) FROM stdin;
1	1
1	2
2	1
2	2
2	3
2	5
3	4
4	1
4	7
\.


--
-- TOC entry 3165 (class 0 OID 26426)
-- Dependencies: 203
-- Data for Name: elementonatural; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.elementonatural (idelemento, nombrecientifico, nombrevulgar, tipoelemento) FROM stdin;
1	rockus	piedra	mineral
2	salate	sal	mineral
3	arenus	arena	mineral
4	hojus verdesu	lechuga	comestible
5	pepinus	pepino	comestible
6	apious	apio	comestible
7	albachus	albahaca	comestible
8	mentus	menta	comestible
9	radichus	radicheta	comestible
10	tomatus	tomate	comestible
11	bananus	banana	comestible
12	frutillus	frutilla	comestible
13	durazneous	durazno	comestible
14	perus	pera	comestible
15	conejus	conejo	comestible
16	vacuno	vaca	comestible
17	gatuno	gato	comestible
18	leonino	leon	comestible
\.


--
-- TOC entry 3191 (class 0 OID 26853)
-- Dependencies: 230
-- Data for Name: elementosperdidos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.elementosperdidos (idperdida, idregistroelemento, idelemento, idarea, emailenviado) FROM stdin;
2	200	10	1	t
1	100	10	1	t
\.


--
-- TOC entry 3166 (class 0 OID 26435)
-- Dependencies: 204
-- Data for Name: estadia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estadia (idalojamiento, fecha) FROM stdin;
1	0202-02-02
1	0303-03-03
2	0101-01-01
1	0101-01-01
2	0202-02-02
2	2003-03-03
3	0101-01-01
3	0202-02-02
3	0404-04-04
4	0101-01-01
4	0202-02-02
4	0303-03-03
7	0101-01-01
7	0202-02-02
7	30303-03-03
11	0101-01-01
12	0101-01-01
13	0101-01-01
14	0101-01-01
5	0101-01-01
8	0101-01-01
9	0101-01-01
6	0010-01-01
\.


--
-- TOC entry 3167 (class 0 OID 26438)
-- Dependencies: 205
-- Data for Name: excursion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.excursion (idpropuesta, fecha, hora) FROM stdin;
\.


--
-- TOC entry 3168 (class 0 OID 26441)
-- Dependencies: 206
-- Data for Name: gestion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gestion (idpersonal, numeroentrada) FROM stdin;
\.


--
-- TOC entry 3169 (class 0 OID 26444)
-- Dependencies: 207
-- Data for Name: investiga; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.investiga (idinvestigador, idproyecto) FROM stdin;
\.


--
-- TOC entry 3170 (class 0 OID 26447)
-- Dependencies: 208
-- Data for Name: investigador; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.investigador (idpersonal, titulacion) FROM stdin;
\.


--
-- TOC entry 3171 (class 0 OID 26453)
-- Dependencies: 209
-- Data for Name: mineral; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.mineral (idelemento, tipomineral) FROM stdin;
1	roca
2	cristal
3	cristal
\.


--
-- TOC entry 3172 (class 0 OID 26459)
-- Dependencies: 210
-- Data for Name: ocupadopor; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ocupadopor (idalojamiento, fechaestadia, idvisitante) FROM stdin;
1	0202-02-02	1
1	0303-03-03	2
1	0101-01-01	1
2	0101-01-01	1
11	0101-01-01	5
12	0101-01-01	6
13	0101-01-01	7
13	0101-01-01	8
6	0010-01-01	3
\.


--
-- TOC entry 3173 (class 0 OID 26462)
-- Dependencies: 211
-- Data for Name: ofrece; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ofrece (idalojamiento, idpropuesta) FROM stdin;
\.


--
-- TOC entry 3174 (class 0 OID 26465)
-- Dependencies: 212
-- Data for Name: organismo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organismo (idorganismo, nombre) FROM stdin;
1	Organizacion Bs. As.
2	Cordoba Organiza
3	porg. parque mendoza
4	Parques de santa fe org.
5	organiza La Pampa
6	org neuquen
\.


--
-- TOC entry 3175 (class 0 OID 26471)
-- Dependencies: 213
-- Data for Name: parque; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.parque (idparque, nombre, fechadeclaracion, emailcontacto) FROM stdin;
1	Parque la flores	1860-08-05	flores@gmail.com
2	parque Nacional central	1840-05-10	nacionalarg@arg.org.ar
3	parque grande	1950-02-06	grande@org.ar
4	parque norte	1975-09-08	norte@org.ar
5	parque azul	2000-07-06	azul@azul.com
6	marina y sal	1996-06-09	marina@org.ar
7	verde	1460-08-20	verde@gmail.com
8	parque rojo	1970-06-13	rojo@gmail.com
\.


--
-- TOC entry 3176 (class 0 OID 26477)
-- Dependencies: 214
-- Data for Name: participade; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.participade (idvisitante, idpropuesta, fechapropuesta, horapropuesta) FROM stdin;
\.


--
-- TOC entry 3177 (class 0 OID 26480)
-- Dependencies: 215
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.personal (idpersonal, tipopersonal, nombre, direccion, telefonomovil, dni, cuil, telefonodomicilio) FROM stdin;
\.


--
-- TOC entry 3178 (class 0 OID 26486)
-- Dependencies: 216
-- Data for Name: propuestadeexcursion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.propuestadeexcursion (idpropuesta, mobilidad, descripcion) FROM stdin;
\.


--
-- TOC entry 3179 (class 0 OID 26492)
-- Dependencies: 217
-- Data for Name: propuestadias; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.propuestadias (idpropuesta, dia) FROM stdin;
\.


--
-- TOC entry 3180 (class 0 OID 26498)
-- Dependencies: 218
-- Data for Name: propuestahoras; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.propuestahoras (idpropuesta, hora) FROM stdin;
\.


--
-- TOC entry 3181 (class 0 OID 26501)
-- Dependencies: 219
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.provincia (idprovincia, nombre, idorganismo) FROM stdin;
1	Buenos Aires	1
2	Cordoba	2
3	Neuquen	6
4	La Pampa	5
5	Santa Fe	4
6	Mendoza	3
\.


--
-- TOC entry 3182 (class 0 OID 26511)
-- Dependencies: 221
-- Data for Name: proyecto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.proyecto (idproyecto, presupuesto, periodo, idelementonatural) FROM stdin;
\.


--
-- TOC entry 3183 (class 0 OID 26517)
-- Dependencies: 222
-- Data for Name: recorrido; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recorrido (idrecorrido, idpersonalvigilancia, idarea, matriculavehiculo) FROM stdin;
\.


--
-- TOC entry 3184 (class 0 OID 26523)
-- Dependencies: 223
-- Data for Name: registroelemento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.registroelemento (idregistroelemento, idelemento, idarea) FROM stdin;
1	1	1
2	1	2
3	2	3
4	3	1
5	5	1
6	5	13
7	5	14
8	5	15
9	5	16
10	10	13
11	10	14
12	10	15
13	10	16
14	10	17
15	10	18
16	9	13
17	9	14
18	9	15
\.


--
-- TOC entry 3185 (class 0 OID 26526)
-- Dependencies: 224
-- Data for Name: sealimentade; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sealimentade (iddepredador, idpresa) FROM stdin;
\.


--
-- TOC entry 3186 (class 0 OID 26529)
-- Dependencies: 225
-- Data for Name: trabajaen; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trabajaen (idpersonal, idparque, sueldo) FROM stdin;
\.


--
-- TOC entry 3187 (class 0 OID 26532)
-- Dependencies: 226
-- Data for Name: vegetal; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vegetal (idelemento, tipovegetal) FROM stdin;
4	sinFloracion
5	sinFloracion
6	sinFloracion
7	sinFloracion
8	sinFloracion
9	sinFloracion
10	conFloracion
11	conFloracion
12	conFloracion
13	conFloracion
14	conFloracion
\.


--
-- TOC entry 3188 (class 0 OID 26538)
-- Dependencies: 227
-- Data for Name: vehiculo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vehiculo (matricula, tipo) FROM stdin;
\.


--
-- TOC entry 3189 (class 0 OID 26544)
-- Dependencies: 228
-- Data for Name: visitante; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.visitante (idvisitante, nombre, domicilio, profesion, dni) FROM stdin;
1	Ariel	las heras 22	docente	11111111
2	Brenda	Callao 22	carnicero	22222222
3	julian	julian Alvarez	peluquero	33333333
4	marcos	campana 44	panader	44444444
5	luciano	soler 55	abogado	55555555
6	lucas	soler 66	doctor	6666666
7	mario	callao 77	abogado	7777777
8	Carlos	juan b justo 88	doctor	88888888
9	federico	ssoler 99	empresario	99999999
10	facundo	ssanta fe 1010	diariero	10101010101010
\.


--
-- TOC entry 3198 (class 0 OID 0)
-- Dependencies: 229
-- Name: elementosperdidos_idperdida_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.elementosperdidos_idperdida_seq', 2, true);


--
-- TOC entry 2932 (class 2606 OID 26551)
-- Name: alojamiento alojamiento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alojamiento
    ADD CONSTRAINT alojamiento_pkey PRIMARY KEY (idalojamiento);


--
-- TOC entry 2934 (class 2606 OID 26553)
-- Name: animal animal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.animal
    ADD CONSTRAINT animal_pkey PRIMARY KEY (idelemento);


--
-- TOC entry 2936 (class 2606 OID 26555)
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (idarea);


--
-- TOC entry 2938 (class 2606 OID 26557)
-- Name: comestible comestible_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comestible
    ADD CONSTRAINT comestible_pkey PRIMARY KEY (idelemento);


--
-- TOC entry 2940 (class 2606 OID 26559)
-- Name: confloracion confloracion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.confloracion
    ADD CONSTRAINT confloracion_pkey PRIMARY KEY (idelemento);


--
-- TOC entry 2942 (class 2606 OID 26561)
-- Name: conservacion conservacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conservacion
    ADD CONSTRAINT conservacion_pkey PRIMARY KEY (idpersonal);


--
-- TOC entry 2944 (class 2606 OID 26563)
-- Name: contiene contiene_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_pkey PRIMARY KEY (idprovincia, idparque);


--
-- TOC entry 2946 (class 2606 OID 26565)
-- Name: elementonatural elementonatural_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.elementonatural
    ADD CONSTRAINT elementonatural_pkey PRIMARY KEY (idelemento);


--
-- TOC entry 2996 (class 2606 OID 26859)
-- Name: elementosperdidos elementosperdidos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.elementosperdidos
    ADD CONSTRAINT elementosperdidos_pkey PRIMARY KEY (idperdida);


--
-- TOC entry 2948 (class 2606 OID 26569)
-- Name: estadia estadia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadia
    ADD CONSTRAINT estadia_pkey PRIMARY KEY (idalojamiento, fecha);


--
-- TOC entry 2950 (class 2606 OID 26571)
-- Name: excursion excursion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excursion
    ADD CONSTRAINT excursion_pkey PRIMARY KEY (idpropuesta, fecha, hora);


--
-- TOC entry 2952 (class 2606 OID 26573)
-- Name: gestion gestion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestion
    ADD CONSTRAINT gestion_pkey PRIMARY KEY (idpersonal);


--
-- TOC entry 2954 (class 2606 OID 26575)
-- Name: investiga investiga_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investiga
    ADD CONSTRAINT investiga_pkey PRIMARY KEY (idinvestigador, idproyecto);


--
-- TOC entry 2956 (class 2606 OID 26577)
-- Name: investigador investigador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investigador
    ADD CONSTRAINT investigador_pkey PRIMARY KEY (idpersonal);


--
-- TOC entry 2958 (class 2606 OID 26579)
-- Name: mineral mineral_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mineral
    ADD CONSTRAINT mineral_pkey PRIMARY KEY (idelemento);


--
-- TOC entry 2960 (class 2606 OID 26581)
-- Name: ocupadopor ocupado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ocupadopor
    ADD CONSTRAINT ocupado_pkey PRIMARY KEY (idalojamiento, fechaestadia, idvisitante);


--
-- TOC entry 2962 (class 2606 OID 26583)
-- Name: ofrece ofrece_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ofrece
    ADD CONSTRAINT ofrece_pkey PRIMARY KEY (idalojamiento, idpropuesta);


--
-- TOC entry 2964 (class 2606 OID 26585)
-- Name: organismo organismo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organismo
    ADD CONSTRAINT organismo_pkey PRIMARY KEY (idorganismo);


--
-- TOC entry 2966 (class 2606 OID 26587)
-- Name: parque parque_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parque
    ADD CONSTRAINT parque_pkey PRIMARY KEY (idparque);


--
-- TOC entry 2968 (class 2606 OID 26589)
-- Name: participade participade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participade
    ADD CONSTRAINT participade_pkey PRIMARY KEY (idvisitante, idpropuesta, fechapropuesta, horapropuesta);


--
-- TOC entry 2970 (class 2606 OID 26591)
-- Name: personal personal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY (idpersonal);


--
-- TOC entry 2972 (class 2606 OID 26593)
-- Name: propuestadeexcursion propuestadeexcursion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propuestadeexcursion
    ADD CONSTRAINT propuestadeexcursion_pkey PRIMARY KEY (idpropuesta);


--
-- TOC entry 2974 (class 2606 OID 26595)
-- Name: propuestadias propuestadias_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propuestadias
    ADD CONSTRAINT propuestadias_pkey PRIMARY KEY (idpropuesta, dia);


--
-- TOC entry 2976 (class 2606 OID 26597)
-- Name: propuestahoras propuestahoras_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propuestahoras
    ADD CONSTRAINT propuestahoras_pkey PRIMARY KEY (idpropuesta, hora);


--
-- TOC entry 2978 (class 2606 OID 26599)
-- Name: provincia provincia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT provincia_pkey PRIMARY KEY (idprovincia);


--
-- TOC entry 2980 (class 2606 OID 26601)
-- Name: proyecto proyecto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyecto
    ADD CONSTRAINT proyecto_pkey PRIMARY KEY (idproyecto);


--
-- TOC entry 2982 (class 2606 OID 26603)
-- Name: recorrido recorrido_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recorrido
    ADD CONSTRAINT recorrido_pkey PRIMARY KEY (idrecorrido);


--
-- TOC entry 2984 (class 2606 OID 26605)
-- Name: registroelemento registroelemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registroelemento
    ADD CONSTRAINT registroelemento_pkey PRIMARY KEY (idregistroelemento);


--
-- TOC entry 2986 (class 2606 OID 26607)
-- Name: sealimentade sealimentade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sealimentade
    ADD CONSTRAINT sealimentade_pkey PRIMARY KEY (iddepredador, idpresa);


--
-- TOC entry 2988 (class 2606 OID 26609)
-- Name: trabajaen trabajaen_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trabajaen
    ADD CONSTRAINT trabajaen_pkey PRIMARY KEY (idpersonal, idparque);


--
-- TOC entry 2990 (class 2606 OID 26611)
-- Name: vegetal vegetal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vegetal
    ADD CONSTRAINT vegetal_pkey PRIMARY KEY (idelemento);


--
-- TOC entry 2992 (class 2606 OID 26613)
-- Name: vehiculo vehiculo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT vehiculo_pkey PRIMARY KEY (matricula);


--
-- TOC entry 2994 (class 2606 OID 26615)
-- Name: visitante visitante_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visitante
    ADD CONSTRAINT visitante_pkey PRIMARY KEY (idvisitante);


--
-- TOC entry 3157 (class 2618 OID 26510)
-- Name: provincia_cantparques _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.provincia_cantparques AS
 SELECT p.idprovincia,
    p.nombre,
    count(DISTINCT pq.idparque) AS cantparques
   FROM ((public.provincia p
     JOIN public.contiene c ON ((c.idprovincia = p.idprovincia)))
     JOIN public.parque pq ON ((pq.idparque = c.idparque)))
  GROUP BY p.idprovincia;


--
-- TOC entry 3035 (class 2620 OID 26616)
-- Name: registroelemento trigger_perdida_elemento; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_perdida_elemento BEFORE DELETE ON public.registroelemento FOR EACH ROW EXECUTE PROCEDURE public.perdida_elemento();


--
-- TOC entry 2997 (class 2606 OID 26617)
-- Name: alojamiento alojamiento_idparque_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alojamiento
    ADD CONSTRAINT alojamiento_idparque_fkey FOREIGN KEY (idparque) REFERENCES public.parque(idparque);


--
-- TOC entry 2998 (class 2606 OID 26622)
-- Name: animal animal_idelemento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.animal
    ADD CONSTRAINT animal_idelemento_fkey FOREIGN KEY (idelemento) REFERENCES public.comestible(idelemento);


--
-- TOC entry 2999 (class 2606 OID 26627)
-- Name: area area_idparque_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_idparque_fkey FOREIGN KEY (idparque) REFERENCES public.parque(idparque);


--
-- TOC entry 3000 (class 2606 OID 26632)
-- Name: comestible comestible_idelemento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comestible
    ADD CONSTRAINT comestible_idelemento_fkey FOREIGN KEY (idelemento) REFERENCES public.elementonatural(idelemento);


--
-- TOC entry 3001 (class 2606 OID 26637)
-- Name: confloracion confloracion_idelemento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.confloracion
    ADD CONSTRAINT confloracion_idelemento_fkey FOREIGN KEY (idelemento) REFERENCES public.vegetal(idelemento);


--
-- TOC entry 3002 (class 2606 OID 26642)
-- Name: conservacion conservacion_idarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conservacion
    ADD CONSTRAINT conservacion_idarea_fkey FOREIGN KEY (idarea) REFERENCES public.area(idarea);


--
-- TOC entry 3003 (class 2606 OID 26647)
-- Name: conservacion conservacion_idpersonal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conservacion
    ADD CONSTRAINT conservacion_idpersonal_fkey FOREIGN KEY (idpersonal) REFERENCES public.personal(idpersonal);


--
-- TOC entry 3004 (class 2606 OID 26652)
-- Name: contiene contiene_idparque_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_idparque_fkey FOREIGN KEY (idparque) REFERENCES public.parque(idparque);


--
-- TOC entry 3005 (class 2606 OID 26657)
-- Name: contiene contiene_idprovincia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_idprovincia_fkey FOREIGN KEY (idprovincia) REFERENCES public.provincia(idprovincia);


--
-- TOC entry 3034 (class 2606 OID 26865)
-- Name: elementosperdidos elementosperdidos_idarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.elementosperdidos
    ADD CONSTRAINT elementosperdidos_idarea_fkey FOREIGN KEY (idarea) REFERENCES public.area(idarea);


--
-- TOC entry 3033 (class 2606 OID 26860)
-- Name: elementosperdidos elementosperdidos_idelemento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.elementosperdidos
    ADD CONSTRAINT elementosperdidos_idelemento_fkey FOREIGN KEY (idelemento) REFERENCES public.registroelemento(idregistroelemento);


--
-- TOC entry 3006 (class 2606 OID 26662)
-- Name: estadia estadia_idalojamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadia
    ADD CONSTRAINT estadia_idalojamiento_fkey FOREIGN KEY (idalojamiento) REFERENCES public.alojamiento(idalojamiento);


--
-- TOC entry 3007 (class 2606 OID 26667)
-- Name: excursion excursion_idpropuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excursion
    ADD CONSTRAINT excursion_idpropuesta_fkey FOREIGN KEY (idpropuesta) REFERENCES public.propuestadeexcursion(idpropuesta);


--
-- TOC entry 3008 (class 2606 OID 26672)
-- Name: gestion gestion_idpersonal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestion
    ADD CONSTRAINT gestion_idpersonal_fkey FOREIGN KEY (idpersonal) REFERENCES public.personal(idpersonal);


--
-- TOC entry 3009 (class 2606 OID 26677)
-- Name: investiga investiga_idinvestigador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investiga
    ADD CONSTRAINT investiga_idinvestigador_fkey FOREIGN KEY (idinvestigador) REFERENCES public.investigador(idpersonal);


--
-- TOC entry 3010 (class 2606 OID 26682)
-- Name: investiga investiga_idproyecto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investiga
    ADD CONSTRAINT investiga_idproyecto_fkey FOREIGN KEY (idproyecto) REFERENCES public.proyecto(idproyecto);


--
-- TOC entry 3011 (class 2606 OID 26687)
-- Name: investigador investigador_idpersonal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investigador
    ADD CONSTRAINT investigador_idpersonal_fkey FOREIGN KEY (idpersonal) REFERENCES public.personal(idpersonal);


--
-- TOC entry 3012 (class 2606 OID 26692)
-- Name: mineral mineral_idelemento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mineral
    ADD CONSTRAINT mineral_idelemento_fkey FOREIGN KEY (idelemento) REFERENCES public.elementonatural(idelemento);


--
-- TOC entry 3013 (class 2606 OID 26697)
-- Name: ocupadopor ocupado_idalojamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ocupadopor
    ADD CONSTRAINT ocupado_idalojamiento_fkey FOREIGN KEY (idalojamiento, fechaestadia) REFERENCES public.estadia(idalojamiento, fecha);


--
-- TOC entry 3014 (class 2606 OID 26702)
-- Name: ocupadopor ocupado_idvisitante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ocupadopor
    ADD CONSTRAINT ocupado_idvisitante_fkey FOREIGN KEY (idvisitante) REFERENCES public.visitante(idvisitante);


--
-- TOC entry 3015 (class 2606 OID 26707)
-- Name: ofrece ofrece_idalojamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ofrece
    ADD CONSTRAINT ofrece_idalojamiento_fkey FOREIGN KEY (idalojamiento) REFERENCES public.alojamiento(idalojamiento);


--
-- TOC entry 3016 (class 2606 OID 26712)
-- Name: ofrece ofrece_idpropuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ofrece
    ADD CONSTRAINT ofrece_idpropuesta_fkey FOREIGN KEY (idpropuesta) REFERENCES public.propuestadeexcursion(idpropuesta);


--
-- TOC entry 3017 (class 2606 OID 26717)
-- Name: participade participade_idpropuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participade
    ADD CONSTRAINT participade_idpropuesta_fkey FOREIGN KEY (idpropuesta, fechapropuesta, horapropuesta) REFERENCES public.excursion(idpropuesta, fecha, hora);


--
-- TOC entry 3018 (class 2606 OID 26722)
-- Name: participade participade_idvisitante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participade
    ADD CONSTRAINT participade_idvisitante_fkey FOREIGN KEY (idvisitante) REFERENCES public.visitante(idvisitante);


--
-- TOC entry 3019 (class 2606 OID 26727)
-- Name: propuestadias propuestadias_idpropuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propuestadias
    ADD CONSTRAINT propuestadias_idpropuesta_fkey FOREIGN KEY (idpropuesta) REFERENCES public.propuestadeexcursion(idpropuesta);


--
-- TOC entry 3020 (class 2606 OID 26732)
-- Name: propuestahoras propuestahoras_idpropuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propuestahoras
    ADD CONSTRAINT propuestahoras_idpropuesta_fkey FOREIGN KEY (idpropuesta) REFERENCES public.propuestadeexcursion(idpropuesta);


--
-- TOC entry 3021 (class 2606 OID 26737)
-- Name: provincia provincia_idorganismo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT provincia_idorganismo_fkey FOREIGN KEY (idorganismo) REFERENCES public.organismo(idorganismo);


--
-- TOC entry 3022 (class 2606 OID 26742)
-- Name: proyecto proyecto_idelementonatural_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyecto
    ADD CONSTRAINT proyecto_idelementonatural_fkey FOREIGN KEY (idelementonatural) REFERENCES public.elementonatural(idelemento);


--
-- TOC entry 3023 (class 2606 OID 26747)
-- Name: recorrido recorrido_idarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recorrido
    ADD CONSTRAINT recorrido_idarea_fkey FOREIGN KEY (idarea) REFERENCES public.area(idarea);


--
-- TOC entry 3024 (class 2606 OID 26752)
-- Name: recorrido recorrido_idpersonalvigilancia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recorrido
    ADD CONSTRAINT recorrido_idpersonalvigilancia_fkey FOREIGN KEY (idpersonalvigilancia) REFERENCES public.personal(idpersonal);


--
-- TOC entry 3025 (class 2606 OID 26757)
-- Name: recorrido recorrido_matriculavehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recorrido
    ADD CONSTRAINT recorrido_matriculavehiculo_fkey FOREIGN KEY (matriculavehiculo) REFERENCES public.vehiculo(matricula);


--
-- TOC entry 3026 (class 2606 OID 26762)
-- Name: registroelemento registroelemento_idarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registroelemento
    ADD CONSTRAINT registroelemento_idarea_fkey FOREIGN KEY (idarea) REFERENCES public.area(idarea);


--
-- TOC entry 3027 (class 2606 OID 26767)
-- Name: registroelemento registroelemento_idelemento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registroelemento
    ADD CONSTRAINT registroelemento_idelemento_fkey FOREIGN KEY (idelemento) REFERENCES public.elementonatural(idelemento);


--
-- TOC entry 3028 (class 2606 OID 26772)
-- Name: sealimentade sealimentade_iddepredador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sealimentade
    ADD CONSTRAINT sealimentade_iddepredador_fkey FOREIGN KEY (iddepredador) REFERENCES public.animal(idelemento);


--
-- TOC entry 3029 (class 2606 OID 26777)
-- Name: sealimentade sealimentade_idpresa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sealimentade
    ADD CONSTRAINT sealimentade_idpresa_fkey FOREIGN KEY (idpresa) REFERENCES public.comestible(idelemento);


--
-- TOC entry 3030 (class 2606 OID 26782)
-- Name: trabajaen trabajaen_idparque_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trabajaen
    ADD CONSTRAINT trabajaen_idparque_fkey FOREIGN KEY (idparque) REFERENCES public.parque(idparque);


--
-- TOC entry 3031 (class 2606 OID 26787)
-- Name: trabajaen trabajaen_idpersonal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trabajaen
    ADD CONSTRAINT trabajaen_idpersonal_fkey FOREIGN KEY (idpersonal) REFERENCES public.personal(idpersonal);


--
-- TOC entry 3032 (class 2606 OID 26792)
-- Name: vegetal vegetal_idelemento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vegetal
    ADD CONSTRAINT vegetal_idelemento_fkey FOREIGN KEY (idelemento) REFERENCES public.comestible(idelemento);


-- Completed on 2019-06-06 15:22:01 -03

--
-- PostgreSQL database dump complete
--

