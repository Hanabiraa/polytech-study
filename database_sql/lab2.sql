-- просмотр текущих ролей
-- -- createuser и dropuser - это синтакс. сахар для CREATE ROLE и DROP ROLE
SELECT rolname FROM pg_roles;

-- задание 1

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



-- задание 2
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