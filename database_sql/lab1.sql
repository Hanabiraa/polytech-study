CREATE SCHEMA polytech_lab;

SET search_path TO polytech_lab;
SHOW search_path;

-- Создание таблиц
CREATE TABLE addresses
(
    id      serial PRIMARY KEY,
    city    text,
    address text,
    office  int
);

CREATE TABLE manufacturers
(
    id   serial PRIMARY KEY,
    name text,
    address_id     int
        CONSTRAINT fk1 REFERENCES addresses (id)
);

CREATE TABLE item
(
    id              serial PRIMARY KEY,
    name            text,
    manufacturer_id int
        CONSTRAINT fk1 REFERENCES manufacturers (id),
    unit            text,
    price_per_unit  float
);

CREATE TABLE buyer
(
    id             serial PRIMARY KEY,
    name           text,
    address_id     int
        CONSTRAINT fk1 REFERENCES addresses (id),
    phone          text,
    contact_person text
);

CREATE TABLE purchase
(
    id             serial PRIMARY KEY,
    quantity       int,
    item_id        int
        CONSTRAINT fk1 REFERENCES item (id),
    buyer_id       int
        CONSTRAINT fk2 REFERENCES buyer (id),
    date           timestamp DEFAULT now()
);

-- вставка значений

INSERT INTO addresses
VALUES (DEFAULT, 'Moscow', 'Pushkin street', 1),
       (DEFAULT, 'Saint Petersburg', 'Lermontov street', 10),
       (DEFAULT, 'Moscow', 'Motrosova street', 23),
       (DEFAULT, 'Vologda', 'Pushkin street', 12),
       (DEFAULT, 'Krasnoyarsk', 'Lermontov street', 14),
       (DEFAULT, 'Moscow', 'Pushkin street', 6),
       (DEFAULT, 'Krasnoyarsk', 'Motrosova street', 16),
       (DEFAULT, 'Krasnoyarsk', 'Pushkin street', 12),
       (DEFAULT, 'Vologda', 'Motrosova street', 14)

INSERT INTO manufacturers
VALUES (DEFAULT, 'Break company', 1),
       (DEFAULT, 'Paint manufacture', 2),
       (DEFAULT, 'Toona industries', 3),
       (DEFAULT, 'Car factory', 4)

INSERT INTO item
VALUES (DEFAULT, 'standart break', 1, 'kg', random() * 10),
       (DEFAULT, 'light break', 1, 'kg', random() * 10),
       (DEFAULT, 'heavy break', 1, 'kg', random() * 10),
       (DEFAULT, 'blue paint', 2, 'litters', floor(random() * 10) + 2),
       (DEFAULT, 'white paint', 2, 'litters', floor(random() * 10) + 2),
       (DEFAULT, 'red paint', 2, 'litters', floor(random() * 10)+ 2),
       (DEFAULT, 'small fish', 3, 'kg', random() * 10),
       (DEFAULT, 'big fish', 3, 'kg', random() * 10),
       (DEFAULT, 'light car', 4, 'unit', random() * 10000),
       (DEFAULT, 'sport car', 4, 'unit', random() * 10000),
       (DEFAULT, 'city car', 4, 'unit', random() * 10000)

INSERT INTO buyer
VALUES (DEFAULT, 'LTD company', 5, '8999191919', 'Ivan Ivanov'),
       (DEFAULT, 'CORP manufacture', 6, '8999191919', 'Petr Petrov'),
       (DEFAULT, 'DOS factory', 7, '8999191919', 'Alexey Kirilovich'),
       (DEFAULT, 'SCS industry', 8, '8999191919', 'Mark Valerievich'),
       (DEFAULT, 'Bee company', 9, '8999191919', 'Ivan Petrov')


INSERT INTO purchase
VALUES (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '1 day 1 hour'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '2 day 2 hour'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '3 day 3 hour'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '4 day 4 hour'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '5 day 5 hour'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '6 day 6 hour'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '1 month 7 hour'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '1 month 8 hour'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '1 month 8 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '1 month 11 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '1 month 12 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '1 month 13 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '3 month 8 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '2 month 8 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '4 month 1 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '4 month 2 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '4 month 3 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '4 month 4 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '2 month 5 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, now() - '2 month 6 day'::interval),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT),
       (DEFAULT, floor(random() * 10 + 2)::int, floor(random() * 10000)::int % 11 + 1, floor(random() * 10000)::int % 5 + 1, DEFAULT);

-- выборка покупателей, где они совершили больше 3 но меньше 7 покупок
-- за последние полтора месяца
-- c id и именем покупателя, количеством товара и названием товара,
WITH cte AS (
    SELECT * FROM purchase WHERE purchase.date > now() - '1 month 15 day'::interval
)
SELECT b.id AS id, b.name, sum(p.quantity) AS quantity, i.name AS item
FROM cte AS p
         JOIN buyer AS b ON b.id = p.buyer_id
         JOIN item AS i ON i.id = p.item_id
WHERE p.quantity BETWEEN 3 AND 7
GROUP BY b.id, b.name, i.name;

-- Выборка, где покупатели совершили суммарно больше 6 любых покупок
SELECT b.name, count(p.id) AS amount
FROM purchase AS p
         JOIN buyer b on p.buyer_id = b.id
GROUP BY b.name
HAVING count(*) > 5;

-- Средняя сумма заказа для каждой компании
WITH cte AS (
    SELECT p.id AS id, p.quantity * i.price_per_unit AS amount
    FROM purchase AS p
         JOIN item AS i ON i.id = p.item_id
)
SELECT b.name, avg(cte.amount) AS average_amount
FROM purchase AS p
         JOIN buyer AS b ON b.id = p.buyer_id
         JOIN item AS i ON i.id = p.item_id
         JOIN cte AS cte ON cte.id = p.id
GROUP BY b.name;

-- Средняя количество товара каждого вида для каждой компании
SELECT DISTINCT b.name, i.name, avg(p.quantity) OVER (PARTITION BY b.name, i.name ORDER BY b.name DESC) AS avg
FROM purchase AS p
         JOIN buyer AS b ON b.id = p.buyer_id
         JOIN item AS i ON i.id = p.item_id
GROUP BY p.id, b.name, i.name
ORDER BY b.name DESC;