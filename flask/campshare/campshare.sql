--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _yoyo_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._yoyo_log (
    id character varying(36) NOT NULL,
    migration_hash character varying(64),
    migration_id character varying(255),
    operation character varying(10),
    username character varying(255),
    hostname character varying(255),
    comment character varying(255),
    created_at_utc timestamp without time zone
);


ALTER TABLE public._yoyo_log OWNER TO postgres;

--
-- Name: _yoyo_migration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._yoyo_migration (
    migration_hash character varying(64) NOT NULL,
    migration_id character varying(255),
    applied_at_utc timestamp without time zone
);


ALTER TABLE public._yoyo_migration OWNER TO postgres;

--
-- Name: _yoyo_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._yoyo_version (
    version integer NOT NULL,
    installed_at_utc timestamp without time zone
);


ALTER TABLE public._yoyo_version OWNER TO postgres;

--
-- Name: features; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.features (
    feature_id integer NOT NULL,
    hosted boolean,
    electricity boolean,
    water boolean,
    pets_allowed boolean,
    listing_id integer NOT NULL
);


ALTER TABLE public.features OWNER TO postgres;

--
-- Name: features_feature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.features_feature_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.features_feature_id_seq OWNER TO postgres;

--
-- Name: features_feature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.features_feature_id_seq OWNED BY public.features.feature_id;


--
-- Name: foo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.foo (
    a integer
);


ALTER TABLE public.foo OWNER TO postgres;

--
-- Name: listings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listings (
    listing_id integer NOT NULL,
    listing_title text NOT NULL,
    member_id integer
);


ALTER TABLE public.listings OWNER TO postgres;

--
-- Name: listings_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.listings_listing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listings_listing_id_seq OWNER TO postgres;

--
-- Name: listings_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.listings_listing_id_seq OWNED BY public.listings.listing_id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.members (
    member_id integer NOT NULL,
    username text NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.members OWNER TO postgres;

--
-- Name: members_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.members_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.members_member_id_seq OWNER TO postgres;

--
-- Name: members_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.members_member_id_seq OWNED BY public.members.member_id;


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    reservation_id integer NOT NULL,
    date date NOT NULL,
    sites_remaining integer,
    sites_reserved integer NOT NULL,
    listing_id integer NOT NULL
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- Name: reservations_reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_reservation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_reservation_id_seq OWNER TO postgres;

--
-- Name: reservations_reservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_reservation_id_seq OWNED BY public.reservations.reservation_id;


--
-- Name: yoyo_lock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yoyo_lock (
    locked integer DEFAULT 1 NOT NULL,
    ctime timestamp without time zone,
    pid integer NOT NULL
);


ALTER TABLE public.yoyo_lock OWNER TO postgres;

--
-- Name: features feature_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features ALTER COLUMN feature_id SET DEFAULT nextval('public.features_feature_id_seq'::regclass);


--
-- Name: listings listing_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listings ALTER COLUMN listing_id SET DEFAULT nextval('public.listings_listing_id_seq'::regclass);


--
-- Name: members member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members ALTER COLUMN member_id SET DEFAULT nextval('public.members_member_id_seq'::regclass);


--
-- Name: reservations reservation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN reservation_id SET DEFAULT nextval('public.reservations_reservation_id_seq'::regclass);


--
-- Data for Name: _yoyo_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._yoyo_log (id, migration_hash, migration_id, operation, username, hostname, comment, created_at_utc) FROM stdin;
0db6798d-3d66-11ee-9d93-e00af62e7c3a	36de61838323aa260382c952530b63c4be42fbe31520080d5c59a98bab6fca59	20230817_01_af13B	apply	aaronu	Big_Lenovo	\N	2023-08-18 01:25:02.116908
\.


--
-- Data for Name: _yoyo_migration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._yoyo_migration (migration_hash, migration_id, applied_at_utc) FROM stdin;
36de61838323aa260382c952530b63c4be42fbe31520080d5c59a98bab6fca59	20230817_01_af13B	2023-08-18 01:25:02.125309
\.


--
-- Data for Name: _yoyo_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._yoyo_version (version, installed_at_utc) FROM stdin;
2	2023-08-18 01:24:31.739954
\.


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.features (feature_id, hosted, electricity, water, pets_allowed, listing_id) FROM stdin;
1	t	f	t	t	2
2	f	f	f	t	4
3	t	f	t	f	3
9	t	t	t	t	5
12	f	t	t	f	10
15	f	f	t	t	6
\.


--
-- Data for Name: foo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.foo (a) FROM stdin;
\.


--
-- Data for Name: listings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listings (listing_id, listing_title, member_id) FROM stdin;
4	Yurt in the forest	9
5	High Desert Teepee Village	9
1	Riverside retreat	11
2	Private beach	15
7	Fly fishing heaven	15
3	Hideaway in the North Woods	12
6	ADA accesible camping near National Parks	3
8	Rustic cabins near Lake Bohnman	10
9	Rugged coastal island, boat access only	7
10	Scenic meadow near Emerald Gulch	3
11	Quaint cabin near the Elwa River	\N
12	Treehouse in the redwoods	11
13	Rugged firewatch lookout campground	3
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.members (member_id, username, password) FROM stdin;
3	HotCheeto99	ba395c5ee9bbbfdea710d18fbb95bab36e42cdd7e8e7c969be2b2cc259d79d6125d41db32bd38134d08bf3db3f924926d33f91e328e74f1ffa23433a194c29de
7	OceanWanderer1993	60630dcd5e4440a4f353fea04f5f08c212de6b74e57f79198beb0f4fb2d7715b5c9b9e9ac0456bd2eae5f303c31cece91f59cd84b1a3a63a1712762d53b9bbb3
9	Kat_Shannon77	636f445e133e387a7df6adc1bbe3cd8b7470eed26f6539c24269505f7d255adbbca260d998f6f8fbcd051d725511aab6a148e870c110f2a47c0ff971dcfa7120
10	JR_Bob_Dobb	d35d859a986352474ab9cf4c7a887cb966c0e7ce5d3828c46ca067b5063059ed00f1387e9e66096c9ca6d0e01920041e8ca7c478f130535977a22b1f18f11a20
12	E_Chao	3393a3c06860056da6ce3f6e9ded056f0b47c967cf406ec9eab3f1420d4d1854a7df0f7cdc0640a710950eb1caadd60d56cea2877d59c01c577fc57a32f5c309
13	DS_Jackson	d4731d213b054ba67669fe8a2a3f64764756dd229cbf670a682a66a39e9933275c8623957ceaf6c67b64be456d736dd3ee1eb3f09b762ba900d15be79e2783f8
15	Jessica_F_2001	22d660ce261f8b789238be7c04ee1a6af0e7b398e611dd128bbaf894d4b475ecd9a6ba0a399fa6218c5b850c011e2f2207b356ca26e3ec47688bfbe1cec63ccd
16	AmandaJones777	234a1c5e9f88e2502ac2998a8de2a9de6135abb570f4343b480d61640bc5cb352fc9a7f1626e984ae76eefd3fa1270ff919038807dcd830ebea1e58b0392ffae
11	nina_sanchez	8f94c7e7209b7dbbdb3b7f9543fbae103937f7aa016679fb8e2d3b268845c87ceeb1c76988e1a1a9838df5f2e0fd833745974b6ff3a4330365f820c2de3f7b3d
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (reservation_id, date, sites_remaining, sites_reserved, listing_id) FROM stdin;
2	2023-11-27	4	2	4
4	2024-10-31	\N	4	6
5	2024-05-20	\N	2	9
6	2025-11-20	\N	2	8
7	2025-11-20	\N	5	12
8	2025-08-20	\N	5	12
9	2026-08-20	\N	5	12
10	2024-08-15	\N	5	11
11	2024-08-15	\N	5	9
\.


--
-- Data for Name: yoyo_lock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yoyo_lock (locked, ctime, pid) FROM stdin;
\.


--
-- Name: features_feature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.features_feature_id_seq', 15, true);


--
-- Name: listings_listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.listings_listing_id_seq', 15, true);


--
-- Name: members_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.members_member_id_seq', 16, true);


--
-- Name: reservations_reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_reservation_id_seq', 11, true);


--
-- Name: _yoyo_log _yoyo_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._yoyo_log
    ADD CONSTRAINT _yoyo_log_pkey PRIMARY KEY (id);


--
-- Name: _yoyo_migration _yoyo_migration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._yoyo_migration
    ADD CONSTRAINT _yoyo_migration_pkey PRIMARY KEY (migration_hash);


--
-- Name: _yoyo_version _yoyo_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._yoyo_version
    ADD CONSTRAINT _yoyo_version_pkey PRIMARY KEY (version);


--
-- Name: features features_listing_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_listing_id_key UNIQUE (listing_id);


--
-- Name: features features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (feature_id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (listing_id);


--
-- Name: members members_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_email_key UNIQUE (username);


--
-- Name: members members_password_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_password_key UNIQUE (password);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (member_id);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (reservation_id);


--
-- Name: yoyo_lock yoyo_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yoyo_lock
    ADD CONSTRAINT yoyo_lock_pkey PRIMARY KEY (locked);


--
-- Name: features features_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listings(listing_id);


--
-- Name: listings listings_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id);


--
-- Name: reservations reservations_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listings(listing_id);


--
-- PostgreSQL database dump complete
--

