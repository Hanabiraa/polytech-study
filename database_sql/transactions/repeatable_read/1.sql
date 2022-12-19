-- Запускать до всех транзакций
CREATE SCHEMA transactions;
SET search_path TO transactions;

CREATE TABLE tbl(
    id integer PRIMARY KEY,
    data text
);

INSERT INTO tbl
VALUES (1, 'first'),
       (2, 'second'),
       (3, 'third'),
       (4, 'fourth');

-- Начало транзакции
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- шаг 1
SELECT * FROM tbl;

-- шаг 2
INSERT INTO tbl
VALUES (5, 'first transaction insert this');

-- шаг 3
SELECT * FROM tbl;

-- шаг 4
COMMIT;

-- последующие шаги в этой транзакции не выполняются