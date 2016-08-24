--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE blueprint;
ALTER ROLE blueprint WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5c4bb4e65ccacb36e8f93c71b4ce47a43';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS;






--
-- Database creation
--

CREATE DATABASE blueprint WITH TEMPLATE = template0 OWNER = blueprint;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect blueprint

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: pvcrequest_stamp(); Type: FUNCTION; Schema: public; Owner: blueprint
--

CREATE FUNCTION pvcrequest_stamp() RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $$    BEGIN
          -- Record the time the request is entered into the database
         RETURN current_timestamp;
    END;
$$;


ALTER FUNCTION public.pvcrequest_stamp() OWNER TO blueprint;

--
-- Name: trg_fn_tbl_pvcrequest_inserted_timestamp(); Type: FUNCTION; Schema: public; Owner: blueprint
--

CREATE FUNCTION trg_fn_tbl_pvcrequest_inserted_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.created_at = NOW(); 
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.trg_fn_tbl_pvcrequest_inserted_timestamp() OWNER TO blueprint;

--
-- Name: trg_fn_tbl_pvcrequest_updated_timestamp(); Type: FUNCTION; Schema: public; Owner: blueprint
--

CREATE FUNCTION trg_fn_tbl_pvcrequest_updated_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
   NEW.updated_at = NOW(); 
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.trg_fn_tbl_pvcrequest_updated_timestamp() OWNER TO blueprint;

--
-- Name: trg_fn_tbl_pvprovision_inserted_timestamp(); Type: FUNCTION; Schema: public; Owner: blueprint
--

CREATE FUNCTION trg_fn_tbl_pvprovision_inserted_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.created_at = NOW(); 
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.trg_fn_tbl_pvprovision_inserted_timestamp() OWNER TO blueprint;

--
-- Name: trg_fn_tbl_pvprovision_updated_timestamp(); Type: FUNCTION; Schema: public; Owner: blueprint
--

CREATE FUNCTION trg_fn_tbl_pvprovision_updated_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
   NEW.updated_at = NOW(); 
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.trg_fn_tbl_pvprovision_updated_timestamp() OWNER TO blueprint;

--
-- Name: trg_tbl_pvcrequest_inserted_timestamp(); Type: FUNCTION; Schema: public; Owner: blueprint
--

CREATE FUNCTION trg_tbl_pvcrequest_inserted_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.created_at = NOW(); 
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.trg_tbl_pvcrequest_inserted_timestamp() OWNER TO blueprint;

--
-- Name: trg_tbl_pvcrequest_updated_timestamp(); Type: FUNCTION; Schema: public; Owner: blueprint
--

CREATE FUNCTION trg_tbl_pvcrequest_updated_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.updated_at = NOW(); 
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.trg_tbl_pvcrequest_updated_timestamp() OWNER TO blueprint;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: blueprint
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO blueprint;

--
-- Name: pvcrequests; Type: TABLE; Schema: public; Owner: blueprint
--

CREATE TABLE pvcrequests (
    creationtimestamp timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    kind character varying(100) NOT NULL,
    namespace character varying(100) NOT NULL,
    selflink character varying(100) NOT NULL,
    accessmode character varying(50),
    storage character varying(10) NOT NULL,
    phase character varying(10) NOT NULL,
    id uuid DEFAULT uuid_in((md5((random())::text))::cstring) NOT NULL,
    apiversion character varying(20) NOT NULL,
    pvcuid uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE pvcrequests OWNER TO blueprint;

--
-- Name: pvsequence; Type: SEQUENCE; Schema: public; Owner: blueprint
--

CREATE SEQUENCE pvsequence
    START WITH 9
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pvsequence OWNER TO blueprint;

--
-- Name: pvprovisions; Type: TABLE; Schema: public; Owner: blueprint
--

CREATE TABLE pvprovisions (
    pvcreationtimestamp timestamp with time zone DEFAULT now(),
    name character varying(100) NOT NULL,
    pvcname character varying(100) NOT NULL,
    pvcnamespace character varying(100),
    pvcuid uuid NOT NULL,
    kind character varying(100) DEFAULT 'PersistentVolume'::character varying NOT NULL,
    accessmode character varying(50),
    storage character varying(10) NOT NULL,
    phase character varying(10),
    id uuid DEFAULT uuid_in((md5((random())::text))::cstring) NOT NULL,
    apiversion character varying(20) NOT NULL,
    pvreclaimpolicy character varying(20) DEFAULT 'Recycle'::character varying NOT NULL,
    pvphase character varying(20) NOT NULL,
    volumeprovider character varying(10) DEFAULT 'nfs'::character varying NOT NULL,
    serveraddress character varying(20) NOT NULL,
    volumename character varying(100) DEFAULT 'replicated-volume'::character varying NOT NULL,
    pvsequencenumber integer DEFAULT nextval('pvsequence'::regclass),
    pvuid uuid,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE pvprovisions OWNER TO blueprint;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: blueprint
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO blueprint;

--
-- Name: users; Type: TABLE; Schema: public; Owner: blueprint
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    admin boolean DEFAULT false,
    approved boolean DEFAULT false
);


ALTER TABLE users OWNER TO blueprint;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: blueprint
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO blueprint;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blueprint
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: blueprint
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: blueprint
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2016-08-08 15:40:00.74341	2016-08-08 15:40:00.74341
\.


--
-- Data for Name: pvcrequests; Type: TABLE DATA; Schema: public; Owner: blueprint
--

COPY pvcrequests (creationtimestamp, name, kind, namespace, selflink, accessmode, storage, phase, id, apiversion, pvcuid, created_at, updated_at) FROM stdin;
2016-06-13 20:34:38+00	postgresql	PersistentVolumeClaim	efss	/api/v1/namespaces/efss/persistentvolumeclaims/postgresql	ReadWriteOnce	1Gi	Bound	4c8dfa2f-2450-9aa2-f5d6-eaba90feb576	v1	3fb487af-31a6-11e6-9cf8-fa163ebdd783	\N	\N
2016-07-04 19:50:32+00	postgresql	PersistentVolumeClaim	el-blueprint	/api/v1/namespaces/el-blueprint/persistentvolumeclaims/postgresql	ReadWriteOnce	2Gi	Bound	0fd0a985-b91c-c220-d688-ff2f0ebd3c42	v1	914ac2f2-4220-11e6-aec0-fa163ebdd783	\N	\N
2016-07-19 13:29:26+00	pvm-claim-test	PersistentVolumeClaim	el-blueprint	/api/v1/namespaces/el-blueprint/persistentvolumeclaims/pvm-claim-test	ReadWriteMany	2Gi	Bound	89b1cca7-1306-47a3-3ccb-fbde5b303893	v1	d0224c59-4db4-11e6-aec0-fa163ebdd783	\N	\N
2016-07-24 02:11:17+00	pvm-claim-test-2	PersistentVolumeClaim	el-blueprint	/api/v1/namespaces/el-blueprint/persistentvolumeclaims/pvm-claim-test-2	ReadWriteMany	4Gi	Bound	076df9a1-41b8-7991-640f-43ca4db9aa5a	v1	e7b22c90-5143-11e6-aec0-fa163ebdd783	\N	\N
2016-06-29 19:31:37+00	mysql	PersistentVolumeClaim	issue-management	/api/v1/namespaces/issue-management/persistentvolumeclaims/mysql	ReadWriteOnce	2Gi	Bound	04dd66e0-8916-d893-8c75-a8efdcf07dad	v1	18c65140-3e30-11e6-aec0-fa163ebdd783	\N	2016-08-02 16:55:12.120659+00
2016-07-24 12:06:59+00	pvm-claim-test-3	PersistentVolumeClaim	el-blueprint	/api/v1/namespaces/el-blueprint/persistentvolumeclaims/pvm-claim-test-3	ReadWriteMany	3Gi	Pending	e9030a6c-a13a-6431-e1b2-dfebda5dcdbd	v1	1f9b7be9-5197-11e6-aec0-fa163ebdd783	\N	2016-08-02 17:15:15.295878+00
2016-06-29 19:33:46+00	atlassian-jira-data	PersistentVolumeClaim	issue-management	/api/v1/namespaces/issue-management/persistentvolumeclaims/atlassian-jira-data	ReadWriteOnce	1Gi	Bound	6bcf99ec-80aa-efe4-09a0-3422f6398da4	v1	65bf11ff-3e30-11e6-aec0-fa163ebdd783	\N	\N
2016-06-29 19:33:47+00	atlassian-jira-logs	PersistentVolumeClaim	issue-management	/api/v1/namespaces/issue-management/persistentvolumeclaims/atlassian-jira-logs	ReadWriteOnce	1Gi	Bound	18222367-7cb5-1511-5cec-9c0ccacff1ea	v1	65e90800-3e30-11e6-aec0-fa163ebdd783	\N	\N
2016-06-07 11:19:23+00	jenkins	PersistentVolumeClaim	ci	/api/v1/namespaces/ci/persistentvolumeclaims/jenkins	ReadWriteMany	512Mi	Bound	36461395-5ebd-23c3-d94e-b458b21b0577	v1	affcaf9f-2ca1-11e6-b31a-fa163ebdd783	\N	\N
2016-06-07 13:55:16+00	jenkins20	PersistentVolumeClaim	ci	/api/v1/namespaces/ci/persistentvolumeclaims/jenkins20	ReadWriteMany	512Mi	Bound	775c0132-8817-7d83-d17d-9f5f86d34f2f	v1	76bae99e-2cb7-11e6-b31a-fa163ebdd783	\N	\N
2016-06-26 20:27:56+00	manageiq	PersistentVolumeClaim	cloud-management	/api/v1/namespaces/cloud-management/persistentvolumeclaims/manageiq	ReadWriteOnce	2Gi	Bound	52ebfa2b-c518-c812-9a57-bd96aca9cd6f	v1	7797042b-3bdc-11e6-a1e0-fa163ebdd783	\N	\N
2016-04-21 18:24:18+00	gluster-claim	PersistentVolumeClaim	cybersafe	/api/v1/namespaces/cybersafe/persistentvolumeclaims/gluster-claim	ReadWriteMany	2Gi	Bound	c0209a3e-227f-434f-efbf-0d09dd4ab623	v1	42b91d6b-07ee-11e6-84e9-fa163ebdd783	\N	\N
2016-06-17 23:13:16+00	shibboleth-idp3	PersistentVolumeClaim	cybersafe	/api/v1/namespaces/cybersafe/persistentvolumeclaims/shibboleth-idp3	ReadWriteOnce	1Gi	Bound	e04c7502-8305-b237-f302-e386109b68aa	v1	129e4c9b-34e1-11e6-9cf8-fa163ebdd783	\N	\N
\.


--
-- Data for Name: pvprovisions; Type: TABLE DATA; Schema: public; Owner: blueprint
--

COPY pvprovisions (pvcreationtimestamp, name, pvcname, pvcnamespace, pvcuid, kind, accessmode, storage, phase, id, apiversion, pvreclaimpolicy, pvphase, volumeprovider, serveraddress, volumename, pvsequencenumber, pvuid, created_at, updated_at) FROM stdin;
2016-07-23 00:09:21.788333+00	pv0002	jenkins20	\N	76bae99e-2cb7-11e6-b31a-fa163ebdd783	PersistentVolumeClaim	ReadWriteMany	512Mi	Bound	868ff18f-b11a-bdaf-f356-d2d39ec1bedf	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	331	\N	\N	\N
2016-07-23 00:09:21.875524+00	pv0005	manageiq	\N	7797042b-3bdc-11e6-a1e0-fa163ebdd783	PersistentVolumeClaim	ReadWriteOnce	2Gi	Bound	004d4025-2c26-aa24-01b3-7ef3ae835d03	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	332	\N	\N	\N
2016-07-23 00:09:21.979143+00	gluster-default-volume	gluster-claim	\N	42b91d6b-07ee-11e6-84e9-fa163ebdd783	PersistentVolumeClaim	ReadWriteMany	2Gi	Bound	b9cc6cd9-cdbc-7724-0783-e21880852f57	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	333	\N	\N	\N
2016-07-23 00:09:22.086692+00	pv0004	shibboleth-idp3	\N	129e4c9b-34e1-11e6-9cf8-fa163ebdd783	PersistentVolumeClaim	ReadWriteOnce	1Gi	Bound	9f2a55de-203f-3cb1-a085-c10c3ecd4bf0	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	334	\N	\N	\N
2016-07-23 00:09:22.183053+00	pv0003	postgresql	\N	3fb487af-31a6-11e6-9cf8-fa163ebdd783	PersistentVolumeClaim	ReadWriteOnce	1Gi	Bound	3f037733-ec87-23ce-ae36-8b1128ada7e2	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	335	\N	\N	\N
2016-07-23 00:09:22.274486+00	pv0007	postgresql	\N	914ac2f2-4220-11e6-aec0-fa163ebdd783	PersistentVolumeClaim	ReadWriteOnce	2Gi	Bound	3e7103e0-e54f-1b98-1097-0e8bd7a4ca0a	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	336	\N	\N	\N
2016-07-24 02:14:30+00	pv341	pvm-claim-test-2	\N	e7b22c90-5143-11e6-aec0-fa163ebdd783	PersistentVolumeClaim	ReadWriteMany	4Gi	Bound	c65778a0-aed1-cdc5-f989-420559d66146	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	341	5a93914c-5144-11e6-aec0-fa163ebdd783	\N	\N
2016-07-24 12:10:07+00		pvm-claim-test-3	\N	1f9b7be9-5197-11e6-aec0-fa163ebdd783	PersistentVolumeClaim	ReadWriteMany	3Gi	Pending	fc082888-4890-0c08-76c4-138686520f40	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	342	8feda642-5197-11e6-aec0-fa163ebdd783	\N	\N
2016-07-23 00:09:00+00	pv229	pvm-claim-test	el-blueprint	d0224c59-4db4-11e6-aec0-fa163ebdd783	PersistentVolumeClaim	ReadWriteMany	2Gi	Bound	90b7250d-dcee-4d7c-1bf7-bc3449fae63e	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	337	\N	\N	\N
2016-07-23 00:09:22.485946+00	pv0004	atlassian-jira-data	\N	65bf11ff-3e30-11e6-aec0-fa163ebdd783	PersistentVolumeClaim	ReadWriteOnce	1Gi	Bound	a1ee5eb4-4961-09c2-e29a-f618d2a5b81f	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	338	\N	\N	\N
2016-07-23 00:09:22.602887+00	pv0005	atlassian-jira-logs	\N	65e90800-3e30-11e6-aec0-fa163ebdd783	PersistentVolumeClaim	ReadWriteOnce	1Gi	Bound	fabfd8ca-1366-d1a1-cd7d-041fb823837a	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	339	\N	\N	\N
2016-07-23 00:09:22.692264+00	pv0006	mysql	\N	18c65140-3e30-11e6-aec0-fa163ebdd783	PersistentVolumeClaim	ReadWriteOnce	2Gi	Bound	6f84034b-8919-ef19-0c80-0cb41c065c7b	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	340	\N	\N	\N
2016-07-23 00:09:21.670765+00	pv0001	jenkins	\N	affcaf9f-2ca1-11e6-b31a-fa163ebdd783	PersistentVolumeClaim	ReadWriteMany	512Mi	Bound	fb4ac135-0283-6663-7243-c35ac1c9a4d3	v1	Recycle	Available	nfs	192.168.0.145	replicated-volume	330	\N	\N	\N
\.


--
-- Name: pvsequence; Type: SEQUENCE SET; Schema: public; Owner: blueprint
--

SELECT pg_catalog.setval('pvsequence', 342, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: blueprint
--

COPY schema_migrations (version) FROM stdin;
20160808153834
20160810203703
20160814130642
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: blueprint
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, admin, approved) FROM stdin;
10	davidjbrewer@gmail.com	$2a$11$KJ.AkrV09sr6rcUX//BmD.NWCrOHTnYmv8Qw5brTrQ8r7ZYyH2vmi	\N	\N	\N	19	2016-08-17 13:42:16.653582	2016-08-16 20:28:31.354158	192.168.0.151	192.168.0.151	2016-08-15 14:09:29.161295	2016-08-17 13:42:16.65676	t	t
5	jayden.mckettrick@eupraxialabs.com	$2a$11$Uud4ZiMhlh89r173Mz.Zj..T1velGfUgXpLctdMqcBFyC6KaHW6Va	\N	\N	\N	2	2016-08-13 17:27:17.806571	2016-08-13 17:26:48.611739	72.183.163.145	72.183.163.145	2016-08-13 17:26:48.587723	2016-08-13 17:27:17.809782	f	\N
1	davidjbrewer@eupraxialabs.com	$2a$11$ZdObHYHOOxONah/x9OHcp.S7GFwMIvh6Rn4mDM0lHNht7ePFfVFby	654ae2963eed5fa254c65452dc284813e5713c9a348ac75fd494f66fb74d1334	2016-08-22 13:00:26.074282	\N	173	2016-08-22 17:12:11.982452	2016-08-22 13:00:55.545311	72.183.163.145	72.183.163.145	2016-08-08 16:09:28.437282	2016-08-22 17:12:11.988009	t	\N
11	ron.backman@eupraxialabs.com	$2a$11$X26QXTKyRIc5cXu9LgOP9e4xTCoklmyLjMz5zuSpUUFVvaPHCgyA6	\N	\N	\N	1	2016-08-15 21:30:48.475337	2016-08-15 21:30:48.475337	72.183.163.145	72.183.163.145	2016-08-15 21:30:21.495548	2016-08-15 21:30:48.478822	f	t
6	lbrewer2@austin.rr.com	$2a$11$NkypdZf9AF.R8ASaClW2R./u1GgjRDa5NNy9vBQI/42o1LCIVXxGa	\N	\N	\N	0	\N	\N	\N	\N	2016-08-14 16:11:56.009209	2016-08-14 16:11:56.009209	f	\N
4	davidjbrewer@yahoo.com	$2a$11$vxU40c7ST4ZRcsc4nermduJWdhfCzE4MAJwKDrOL2lelZBSOZcRBy	\N	\N	\N	12	2016-08-15 23:07:21.338377	2016-08-12 19:17:56.801901	192.168.0.151	192.168.0.151	2016-08-11 14:02:24.323652	2016-08-15 23:07:21.343342	f	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blueprint
--

SELECT pg_catalog.setval('users_id_seq', 11, true);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: blueprint
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: pvcrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: blueprint
--

ALTER TABLE ONLY pvcrequests
    ADD CONSTRAINT pvcrequest_pkey PRIMARY KEY (id);


--
-- Name: pvcuid_provision_constraint; Type: CONSTRAINT; Schema: public; Owner: blueprint
--

ALTER TABLE ONLY pvprovisions
    ADD CONSTRAINT pvcuid_provision_constraint UNIQUE (pvcuid);


--
-- Name: pvcuid_request_constraint; Type: CONSTRAINT; Schema: public; Owner: blueprint
--

ALTER TABLE ONLY pvcrequests
    ADD CONSTRAINT pvcuid_request_constraint UNIQUE (pvcuid);


--
-- Name: pvprovision_pkey; Type: CONSTRAINT; Schema: public; Owner: blueprint
--

ALTER TABLE ONLY pvprovisions
    ADD CONSTRAINT pvprovision_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: blueprint
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: blueprint
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: blueprint
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: blueprint
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: trg_insert_tbl_pvcrequest; Type: TRIGGER; Schema: public; Owner: blueprint
--

CREATE TRIGGER trg_insert_tbl_pvcrequest BEFORE INSERT ON pvcrequests FOR EACH ROW EXECUTE PROCEDURE trg_fn_tbl_pvcrequest_inserted_timestamp();


--
-- Name: trg_insert_tbl_pvprovision; Type: TRIGGER; Schema: public; Owner: blueprint
--

CREATE TRIGGER trg_insert_tbl_pvprovision BEFORE INSERT ON pvprovisions FOR EACH ROW EXECUTE PROCEDURE trg_fn_tbl_pvprovision_inserted_timestamp();


--
-- Name: trg_update_tbl_pvcrequest; Type: TRIGGER; Schema: public; Owner: blueprint
--

CREATE TRIGGER trg_update_tbl_pvcrequest BEFORE UPDATE ON pvcrequests FOR EACH ROW EXECUTE PROCEDURE trg_fn_tbl_pvcrequest_updated_timestamp();


--
-- Name: trg_update_tbl_pvprovision; Type: TRIGGER; Schema: public; Owner: blueprint
--

CREATE TRIGGER trg_update_tbl_pvprovision BEFORE UPDATE ON pvprovisions FOR EACH ROW EXECUTE PROCEDURE trg_fn_tbl_pvprovision_updated_timestamp();


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

