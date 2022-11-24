-- просмотр текущих ролей
-- -- createuser и dropuser - это синтакс. сахар для CREATE ROLE и DROP ROLE
SELECT rolname
FROM pg_roles;

-- TODO: транзакции

-- задание 1

-- проверка, какие роли доступны для текущего юзера
SELECT *
FROM pg_roles
WHERE rolname LIKE 'sushi';

-- создать роли
CREATE ROLE test_log_inh LOGIN INHERIT;
CREATE ROLE test2_createdb INHERIT CREATEDB;
CREATE ROLE test3_repl INHERIT REPLICATION;

SELECT *
FROM pg_roles
WHERE rolname SIMILAR TO '(sushi|test)%';

-- добавить пользователя в соответствующую роль
GRANT test3_repl TO test2_createdb;

SELECT *
FROM pg_roles
WHERE rolname SIMILAR TO '(sushi|test)%';

-- показать какие пользователи какие привилегии доступа имеют к схемам
SELECT *
FROM information_schema.table_privileges
WHERE table_schema SIMILAR TO 'polytech_lab'
  AND table_name SIMILAR TO 'buyer'
LIMIT 10;

-- создание специального представления и добавление специального привилегия для конкретного пользователя
CREATE TABLE polytech_lab.test
(
);

GRANT SELECT, DELETE
    ON polytech_lab.test
    TO test_log_inh;

SELECT *
FROM information_schema.table_privileges
WHERE table_schema SIMILAR TO 'polytech_lab'
  AND table_name SIMILAR TO 'test'
  AND grantee SIMILAR TO 'test_log_inh'
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

-- TODO: добавить VIEW
CREATE OR REPLACE VIEW polytech_lab.companyAveragOrderAmount AS
(
WITH cte AS (SELECT p.id AS id, p.quantity * i.price_per_unit AS amount
             FROM polytech_lab.purchase AS p
                      JOIN polytech_lab.item AS i ON i.id = p.item_id)
SELECT b.name, avg(cte.amount) AS average_amount
FROM polytech_lab.purchase AS p
         JOIN polytech_lab.buyer AS b ON b.id = p.buyer_id
         JOIN polytech_lab.item AS i ON i.id = p.item_id
         JOIN cte ON cte.id = p.id
GROUP BY b.name
    );

SELECT *
FROM companyAveragOrderAmount;

-- TODO: добавить VIEW на основе нескольких таблиц и переопределить правило insert к ней (либо триггер либо переопределение правило вставки)
-- выборка покупателей, где они совершили больше 3 покупок
-- за последние полтора месяца
CREATE OR REPLACE VIEW activeСustomersInLastMonth AS
(
WITH cte AS (SELECT * FROM purchase WHERE purchase.date > now() - '1 month 15 day'::interval)
SELECT b.name, sum(p.quantity) AS quantity, i.name AS item
FROM cte AS p
         JOIN buyer AS b ON b.id = p.buyer_id
         JOIN item AS i ON i.id = p.item_id
WHERE p.quantity > 3
GROUP BY b.name, i.name
ORDER BY b.name
    );

SELECT *
FROM activeСustomersInLastMonth;

-- Во многих случаях для задач, выполнимых с использованием правил для INSERT/UPDATE/DELETE,
-- лучше применять триггеры.
-- (Документация)

-- с правилами могут быть получены неожиданные результаты,
-- когда исходный запрос содержит изменчивые функции: в процессе исполнения правил
-- эти функции могут вызываться большее число раз, чем ожидается.

-- Кроме того, в некоторых случаях эти типы правил вообще нельзя применять;
-- а именно, с предложениями WITH в исходном запросе и
-- с вложенными подзапросами SELECT с множественным присваиванием
-- в списке SET запросов UPDATE.
-- Это объясняется тем, что копирование этих конструкций в запрос правила привело
-- бы к многократному вычислению вложенного запроса, что пошло бы в разрез с
-- выраженными намерениями автора запроса.
CREATE OR REPLACE RULE insertToView AS ON INSERT
    TO activeСustomersInLastMonth
    DO INSTEAD
    INSERT INTO polytech_lab.purchase (id, quantity, item_id, buyer_id, date)
    VALUES (default,
            NEW.quantity,
            (SELECT id FROM polytech_lab.item AS i WHERE new.item LIKE i.name LIMIT 1),
            (SELECT id FROM polytech_lab.buyer AS b WHERE new.name LIKE b.name LIMIT 1),
            now());

INSERT INTO activeСustomersInLastMonth
VALUES ('CORP manufacture', 222, 'heavy break');

-- проверка, что вставилось
SELECT *
FROM activeСustomersInLastMonth
WHERE name LIKe 'CORP%';

SELECT *
FROM purchase
WHERE quantity > 200;


-- задание 2
CREATE OR REPLACE PROCEDURE delete_items_before_timestamp(tmstp timestamp)
    LANGUAGE sql
AS
$$
DELETE
FROM polytech_lab.purchase
WHERE date < tmstp
$$;

SELECT count(*)
FROM polytech_lab.purchase;

CALL delete_items_before_timestamp((now() - '1 day'::interval)::timestamp);

SELECT count(*)
FROM polytech_lab.purchase;

-- TODO: 1 - с исключением и циклами
CREATE OR REPLACE PROCEDURE get_info_margin(percent double precision)
    LANGUAGE plpgsql
AS
$$
DECLARE
    row RECORD;
    x   int;
BEGIN
    FOR row IN SELECT * FROM item
        LOOP
            RAISE NOTICE 'item id: %, item price: %, with margin % percent: %', row.id, round(row.price_per_unit), percent, round(row.price_per_unit / 100 * percent + row.price_per_unit);
        END LOOP;

    x := percent / 0;
EXCEPTION
    WHEN division_by_zero THEN
        RAISE NOTICE 'перехватили ошибку division_by_zero';
END;
$$;

call get_info_margin(10);

-- TODO: процедура с курсорами
CREATE OR REPLACE PROCEDURE add_margin_to_price(percent double precision)
    LANGUAGE plpgsql
AS
$$
DECLARE
    curs NO SCROLL CURSOR FOR SELECT *
                              FROM item;
    row RECORD;
BEGIN
    FOR row IN curs
        LOOP
        UPDATE item SET (price_per_unit) = ROW(row.price_per_unit + row.price_per_unit/100*percent)  WHERE CURRENT OF curs;
        END LOOP;
END;
$$;

SELECT price_per_unit FROM item ORDER BY price_per_unit DESC;

CALL add_margin_to_price(10);

SELECT price_per_unit FROM item ORDER BY price_per_unit DESC;
