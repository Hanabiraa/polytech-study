CREATE SCHEMA polytech_lab;

SET search_path TO polytech_lab;
SHOW search_path;

-- Создание таблиц
-- alter table -> id -> primary key
CREATE TABLE item
(
    name         text PRIMARY KEY,
    manufacturer text NOT NULL,
    unit         text NOT NULL
);

CREATE TABLE buyer
(
    id              serial PRIMARY KEY,
    name            text NOT NULL,
    address         text NOT NULL,
    phone           text NOT NULL,
    contanct_person text NOT NULL
);

CREATE TABLE purchase
(
    id             serial PRIMARY KEY,
    quantity       int NOT NULL,
    price_per_unit float,
    item_name      text
        CONSTRAINT fk1 REFERENCES item (name),
    buyer_id       int
        CONSTRAINT fk2 REFERENCES buyer (id),
    date           timestamptz DEFAULT now()
);

-- вставка значений
WITH RECURSIVE cte AS (SELECT 0    AS val,
                              NULL AS name,
                              NULL as random_num,
                              NULL AS manufacturer_name,
                              NULL As unit
                       UNION ALL
                       SELECT val + 1,
                              'paint' || (val + 1)::text,
                              (floor(random() * 10)::int % 4)::text,
                              CASE
                                  WHEN random_num < '0' THEN 'breaks_company'
                                  WHEN random_num < '1' THEN 'toon_company'
                                  WHEN random_num < '2' THEN 'big_company'
                                  ELSE 'sun_company'
                                  END,
                              CASE
                                  WHEN random_num < '0' THEN 'milliliters'
                                  WHEN random_num < '1' THEN 'liters'
                                  WHEN random_num < '2' THEN 'cubic centimeter'
                                  ELSE 'cubic decimeter'
                                  END
                       FROM cte
                       WHERE val < 15)
INSERT
INTO item(name, manufacturer, unit)
SELECT name, manufacturer_name, unit
FROM cte
OFFSET 1;

WITH RECURSIVE cte AS (SELECT 0    AS val,
                              NULL as random_num,
                              NULL AS name1,
                              NULL As name2,
                              NULL As address,
                              NULL As phone
                       UNION ALL

                       SELECT val + 1,
                              (floor(random() * 10)::int % 4)::text,
                              CASE
                                  WHEN random_num < '0' THEN 'Ivan'
                                  WHEN random_num < '1' THEN 'Petr'
                                  WHEN random_num < '2' THEN 'Sergei'
                                  ELSE 'Alexey'
                                  END,
                              CASE
                                  WHEN random_num < '0' THEN 'Ivanovich'
                                  WHEN random_num < '1' THEN 'Stepanovich'
                                  WHEN random_num < '2' THEN 'Maksimovich'
                                  ELSE 'Nikolaevich'
                                  END,
                              CASE
                                  WHEN random_num < '0' THEN 'Space ' || random_num
                                  WHEN random_num < '1' THEN 'Star ' || random_num
                                  WHEN random_num < '2' THEN 'Eleven ' || random_num
                                  ELSE 'Cubic ' || random_num
                                  END,
                              floor(random() * 10 ^ 7)::text
                       FROM cte
                       WHERE val < 16)
INSERT
INTO buyer(name, address, phone, contanct_person)
SELECT name1 || ' ' || name2, address || ' street', '+7' || phone, name1
FROM cte
OFFSET 2;

INSERT INTO purchase(quantity, price_per_unit, item_name, buyer_id, date)
VALUES (floor(random() * 100)::int, random() * 10, 'paint1', 10, default),
       (floor(random() * 100)::int, random() * 10, 'paint2', 11, default),
       (floor(random() * 100)::int, random() * 10, 'paint3', 12, default),
       (floor(random() * 100)::int, random() * 10, 'paint4', 13, default),
       (floor(random() * 100)::int, random() * 10, 'paint5', 14, default),
       (floor(random() * 100)::int, random() * 10, 'paint7', 15, default),
       (floor(random() * 100)::int, random() * 10, 'paint8', 16, default),
       (floor(random() * 100)::int, random() * 10, 'paint9', 17, default),
       (floor(random() * 100)::int, random() * 10, 'paint10', 18, default);


-- Запросы

-- -- 1 -Запрос с заказами ТОЛЬКО за прошедший месяц
SELECT *
FROM purchase AS p
         LEFT JOIN item AS i ON p.item_name = i.name
         LEFT JOIN buyer AS b ON p.buyer_id = b.id
WHERE date > now() - interval '1 month';


-- группировки, оконные функции,
-- select, где покупатели, которые за какой-то интервал времени (1 день допустим) которые совершили от 2 до 3 покупок
