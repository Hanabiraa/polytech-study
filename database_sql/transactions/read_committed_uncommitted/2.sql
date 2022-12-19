SET search_path TO transactions;

-- Начало транзакции
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- шаг 1
SELECT * FROM tbl;

-- шаг 2 (пропуск)
-- шаг 3
SELECT * FROM tbl;

-- шаг 4 (пропуск)
-- шаг 5 (АНОМАЛИЯ: НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ) (ИЗ-ЗА UPDATE в первой транзакции)
SELECT * FROM tbl;

-- шаг 6
UPDATE tbl SET data = 'second transaction update this'
WHERE id = 2;

-- шаг 7 (пропуск)
-- шаг 8 (не видно удаления строки, которая была исполнена в 3ей транзакции
SELECT * FROM tbl;

-- шаг 9
COMMIT;

-- последующие шаги в этой транзакции не выполняются