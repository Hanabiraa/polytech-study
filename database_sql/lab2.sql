-- просмотр текущих ролей
-- -- createuser и dropuser - это синтакс. сахар для CREATE ROLE и DROP ROLE
SELECT rolname FROM pg_roles;

-- TODO: транзакции

-- задание 1
-- TODO: добавить VIEW и VIEW на основе нескольких таблиц, также добавить к этой VIEW (комплексной) право на insert.
-- нужно определить instead of insert для VIEW (либо триггер либо переопределение правило вставки)

-- проверка, какие роли доступны для текущего юзера
SELECT * FROM pg_roles
WHERE rolname LIKE 'sushi';

-- создать роли
CREATE ROLE test_log_inh LOGIN INHERIT;
CREATE ROLE test2_createdb INHERIT CREATEDB;
CREATE ROLE test3_repl INHERIT REPLICATION;

SELECT * FROM pg_roles
WHERE rolname SIMILAR TO '(sushi|test)%';

-- добавить пользователя в соответствующую роль
GRANT test3_repl TO test2_createdb;

SELECT * FROM pg_roles
WHERE rolname SIMILAR TO '(sushi|test)%';

-- показать какие пользователи какие привилегии доступа имеют к схемам
SELECT * FROM information_schema.table_privileges
WHERE table_schema SIMILAR TO 'polytech_lab' AND
      table_name SIMILAR TO 'buyer'
LIMIT 10;

-- создание специального представления и добавление специального привилегия для конкретного пользователя
CREATE TABLE polytech_lab.test();

GRANT SELECT, DELETE
    ON polytech_lab.test
    TO test_log_inh;

SELECT * FROM information_schema.table_privileges
WHERE table_schema SIMILAR TO 'polytech_lab' AND
      table_name SIMILAR TO 'test' AND
      grantee SIMILAR TO 'test_log_inh'
LIMIT 10;

-- вывод макрокоманды psql \dp
-- sushi-# \dp polytech_lab.*
--                                            Access privileges
--     Schema    |         Name         |   Type   |   Access privileges   | Column privileges | Policies
-- --------------+----------------------+----------+-----------------------+-------------------+----------
--  polytech_lab | addresses            | table    |                       |                   |
--  polytech_lab | addresses_id_seq     | sequence |                       |                   |
--  polytech_lab | buyer                | table    |                       |                   |
--  polytech_lab | buyer_id_seq         | sequence |                       |                   |
--  polytech_lab | item                 | table    |                       |                   |
--  polytech_lab | item_id_seq          | sequence |                       |                   |
--  polytech_lab | manufacturers        | table    |                       |                   |
--  polytech_lab | manufacturers_id_seq | sequence |                       |                   |
--  polytech_lab | purchase             | table    |                       |                   |
--  polytech_lab | purchase_id_seq      | sequence |                       |                   |
--  polytech_lab | test                 | table    | sushi=arwdDxt/sushi  +|                   |
--               |                      |          | test_log_inh=rd/sushi |                   |
-- (11 rows)

-- SELECT	r (“read”)	    LARGE OBJECT, SEQUENCE, TABLE (and table-like objects), table column
-- INSERT	a (“append”)	TABLE, table column
-- UPDATE	w (“write”)	    LARGE OBJECT, SEQUENCE, TABLE, table column
-- DELETE	d	            TABLE
-- TRUNCATE	D	            TABLE
-- REFERENCES	x	        TABLE, table column
-- TRIGGER	t	            TABLE
-- CREATE	C	            DATABASE, SCHEMA, TABLESPACE
-- CONNECT	c	            DATABASE
-- TEMPORARY	T	        DATABASE
-- EXECUTE	X	            FUNCTION, PROCEDURE
-- USAGE	U	            DOMAIN, FOREIGN DATA WRAPPER, FOREIGN SERVER, LANGUAGE, SCHEMA, SEQUENCE, TYPE
-- SET	s	                PARAMETER
-- ALTER SYSTEM	A	        PARAMETER

-- задание 2

-- -- TODO: 1 - с исключением и циклами, вторая с курсорами
CREATE OR REPLACE PROCEDURE delete_items_before_timestamp(tmstp timestamp)
LANGUAGE sql
AS $$
DELETE FROM polytech_lab.purchase
WHERE date < tmstp
$$;

SELECT count(*)
FROM polytech_lab.purchase;

CALL delete_items_before_timestamp((now() - '1 day'::interval)::timestamp);

SELECT count(*)
FROM polytech_lab.purchase;