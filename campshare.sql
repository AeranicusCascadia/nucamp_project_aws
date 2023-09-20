-- Core DB and tables

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

CREATE TABLE public.features (
    feature_id integer NOT NULL,
    hosted boolean,
    electricity boolean,
    water boolean,
    pets_allowed boolean,
    listing_id integer NOT NULL
);

ALTER TABLE public.features OWNER TO postgres;

CREATE SEQUENCE public.features_feature_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.features_feature_id_seq OWNER TO postgres;

ALTER SEQUENCE public.features_feature_id_seq OWNED BY public.features.feature_id;

CREATE TABLE public.listings (
    listing_id integer NOT NULL,
    listing_title text NOT NULL,
    member_id integer NOT NULL
);

ALTER TABLE public.listings OWNER TO postgres;

CREATE SEQUENCE public.listings_listing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listings_listing_id_seq OWNER TO postgres;

ALTER SEQUENCE public.listings_listing_id_seq OWNED BY public.listings.listing_id;

CREATE TABLE public.members (
    member_id integer NOT NULL,
    username text NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.members OWNER TO postgres;

CREATE SEQUENCE public.members_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.members_member_id_seq OWNER TO postgres;

ALTER SEQUENCE public.members_member_id_seq OWNED BY public.members.member_id;

CREATE TABLE public.reservations (
    reservation_id integer NOT NULL,
    date date NOT NULL,
    total_sites integer,
    sites_reserved integer NOT NULL,
    listing_id integer NOT NULL
);


ALTER TABLE public.reservations OWNER TO postgres;

CREATE SEQUENCE public.reservations_reservation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.reservations_reservation_id_seq OWNER TO postgres;

ALTER SEQUENCE public.reservations_reservation_id_seq OWNED BY public.reservations.reservation_id;

ALTER TABLE ONLY public.features ALTER COLUMN feature_id SET DEFAULT nextval('public.features_feature_id_seq'::regclass);

ALTER TABLE ONLY public.listings ALTER COLUMN listing_id SET DEFAULT nextval('public.listings_listing_id_seq'::regclass);

ALTER TABLE ONLY public.members ALTER COLUMN member_id SET DEFAULT nextval('public.members_member_id_seq'::regclass);

ALTER TABLE ONLY public.reservations ALTER COLUMN reservation_id SET DEFAULT nextval('public.reservations_reservation_id_seq'::regclass);

SELECT pg_catalog.setval('public.features_feature_id_seq', 15, true);

SELECT pg_catalog.setval('public.listings_listing_id_seq', 15, true);

SELECT pg_catalog.setval('public.members_member_id_seq', 16, true);

SELECT pg_catalog.setval('public.reservations_reservation_id_seq', 11, true);

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_listing_id_key UNIQUE (listing_id);

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (feature_id);

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (listing_id);

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_email_key UNIQUE (username);

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_password_key UNIQUE (password);

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (member_id);

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (reservation_id);

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listings(listing_id);

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id);

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listings(listing_id);

-- Populate data

INSERT INTO members (member_id, username, password)
VALUES 
-- (1, 'HotCheeto99', 'foo'),
(2, 'OceanWanderer1993', 'foobar'),
(3, 'Kat_Shannon77', 'bar'),
(4, 'JR_Bob_Dobb', 'barfoo'),
(5, 'E_Chao', 'foo'),
(6, 'DS_Jackson', 'bar'),
(7, 'Jessica_F_2001', 'foobar'),
(8, 'AmandaJones777', 'foo'),
(9, 'nina_sanchez', 'bar')
;

INSERT INTO listings (listing_id, listing_title, member_id)
VALUES
(1, 'Yurt in the Forest', 5),
(2, 'High Desert Teepee Village', 6),
(3, 'Riverside Retreat', 2),
(4, 'Private Beach', 6),
(5, 'Fly fishing heaven', 4),
(6, 'Hideaway in the North Woods', 1),
(7, 'ADA accesible camping near National Parks', 7),
(8, 'ADA accesible camping near National Parks', 9),
(9, 'Rustic cabins near Lake Bohnman', 3),
(10, 'Rugged coastal island, boat access only', 8),
(11, 'Scenic meadow near Emerald Gulch', 9),
(12, 'Quaint cabin near the Elwa River', 3),
(13, 'Treehouse in the redwoods', 1),
(14, 'Rugged firewatch lookout campground', 2)
;

INSERT INTO features (hosted, electricity, water, pets_allowed, listing_id)
VALUES
(false, false, true, true, 1),
(false, false, false, false, 2),
(true, true, true, true, 3),
(true, true, true, false, 4),
(true, true, true, true, 5),
(false, false, true, false, 6),
(true, true, true, true, 7),
(false, false, true, false, 9),
(false, false, true, true, 11),
(false, true, true, true, 12),
(true, true, true, false, 13),
(false, false, false, false, 14)
;

INSERT INTO reservations (date, total_sites, sites_reserved, listing_id)
VALUES
('2023-11-27', 4, 2, 1),
('2024-10-31', 6, 3, 2),
('2024-05-20', 8, 2, 3),
('2025-11-20', 6, 5, 4),
('2025-11-20', 12, 9, 5),
('2025-08-20', 4, 1, 6),
('2026-08-20', 15, 11, 7),
('2024-08-15', 1, 1, 13),
('2024-08-15', 2, 2, 14)
;

