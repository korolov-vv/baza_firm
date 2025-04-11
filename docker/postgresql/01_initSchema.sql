--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

\connect bazafirm

SET statement_timeout = 0;
SET
lock_timeout = 0;
SET
client_encoding = 'UTF8';
SET
standard_conforming_strings = on;
SET
check_function_bodies = false;
SET
client_min_messages = warning;


CREATE SCHEMA IF NOT EXISTS bazafirm;

DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'bazafirm') THEN
        PERFORM dblink_exec('dbname=bazafirm', 'pg_restore -d bazafirm -1 .dump_bazafirm.tar');
    END IF;
END $$;
