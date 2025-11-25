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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: event_store_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_store_events (
    id bigint NOT NULL,
    event_id uuid NOT NULL,
    event_type character varying NOT NULL,
    metadata jsonb,
    data jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    valid_at timestamp(6) without time zone
);


--
-- Name: event_store_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.event_store_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_store_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.event_store_events_id_seq OWNED BY public.event_store_events.id;


--
-- Name: event_store_events_in_streams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_store_events_in_streams (
    id bigint NOT NULL,
    stream character varying NOT NULL,
    "position" integer,
    event_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: event_store_events_in_streams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.event_store_events_in_streams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_store_events_in_streams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.event_store_events_in_streams_id_seq OWNED BY public.event_store_events_in_streams.id;


--
-- Name: forecasts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forecasts (
    id bigint NOT NULL,
    data jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    location_id bigint NOT NULL,
    date date NOT NULL
);


--
-- Name: forecasts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.forecasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forecasts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.forecasts_id_seq OWNED BY public.forecasts.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    name character varying,
    latitude double precision,
    longitude double precision,
    address_line_1 character varying,
    address_line_2 character varying,
    address_line_3 character varying,
    address_line_4 character varying,
    address_line_5 character varying,
    address_line_6 character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    country_code character varying NOT NULL,
    nws_grid_id character varying,
    nws_grid_x integer,
    nws_grid_y integer,
    discarded_at timestamp without time zone,
    datetime timestamp without time zone,
    time_zone character varying
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: user_locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_locations (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    location_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: user_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_locations_id_seq OWNED BY public.user_locations.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    full_name character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: event_store_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_store_events ALTER COLUMN id SET DEFAULT nextval('public.event_store_events_id_seq'::regclass);


--
-- Name: event_store_events_in_streams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_store_events_in_streams ALTER COLUMN id SET DEFAULT nextval('public.event_store_events_in_streams_id_seq'::regclass);


--
-- Name: forecasts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forecasts ALTER COLUMN id SET DEFAULT nextval('public.forecasts_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: user_locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_locations ALTER COLUMN id SET DEFAULT nextval('public.user_locations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: event_store_events_in_streams event_store_events_in_streams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_store_events_in_streams
    ADD CONSTRAINT event_store_events_in_streams_pkey PRIMARY KEY (id);


--
-- Name: event_store_events event_store_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_store_events
    ADD CONSTRAINT event_store_events_pkey PRIMARY KEY (id);


--
-- Name: forecasts forecasts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forecasts
    ADD CONSTRAINT forecasts_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: user_locations user_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_on_address_line_3_address_line_4_address_line_5_0af8be9b19; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_on_address_line_3_address_line_4_address_line_5_0af8be9b19 ON public.locations USING btree (address_line_3, address_line_4, address_line_5, country_code);


--
-- Name: index_event_store_events_in_streams_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_store_events_in_streams_on_created_at ON public.event_store_events_in_streams USING btree (created_at);


--
-- Name: index_event_store_events_in_streams_on_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_store_events_in_streams_on_event_id ON public.event_store_events_in_streams USING btree (event_id);


--
-- Name: index_event_store_events_in_streams_on_stream_and_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_event_store_events_in_streams_on_stream_and_event_id ON public.event_store_events_in_streams USING btree (stream, event_id);


--
-- Name: index_event_store_events_in_streams_on_stream_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_event_store_events_in_streams_on_stream_and_position ON public.event_store_events_in_streams USING btree (stream, "position");


--
-- Name: index_event_store_events_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_store_events_on_created_at ON public.event_store_events USING btree (created_at);


--
-- Name: index_event_store_events_on_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_event_store_events_on_event_id ON public.event_store_events USING btree (event_id);


--
-- Name: index_event_store_events_on_event_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_store_events_on_event_type ON public.event_store_events USING btree (event_type);


--
-- Name: index_event_store_events_on_valid_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_store_events_on_valid_at ON public.event_store_events USING btree (valid_at);


--
-- Name: index_forecasts_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_forecasts_on_location_id ON public.forecasts USING btree (location_id);


--
-- Name: index_locations_on_discarded_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_discarded_at ON public.locations USING btree (discarded_at);


--
-- Name: index_user_locations_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_locations_on_location_id ON public.user_locations USING btree (location_id);


--
-- Name: index_user_locations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_locations_on_user_id ON public.user_locations USING btree (user_id);


--
-- Name: user_locations fk_rails_374794d0e3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT fk_rails_374794d0e3 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: user_locations fk_rails_3aef0f4606; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT fk_rails_3aef0f4606 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: forecasts fk_rails_6aed6f4045; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forecasts
    ADD CONSTRAINT fk_rails_6aed6f4045 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: event_store_events_in_streams fk_rails_c8d52b5857; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_store_events_in_streams
    ADD CONSTRAINT fk_rails_c8d52b5857 FOREIGN KEY (event_id) REFERENCES public.event_store_events(event_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20251125132309'),
('20251124132444'),
('20250916121549'),
('20250916114503'),
('20250916113223'),
('20250915110812'),
('20250914111001'),
('20250901155730'),
('20250831031904'),
('20250831024401'),
('20250818090921'),
('20240506022630'),
('20240429105644');

