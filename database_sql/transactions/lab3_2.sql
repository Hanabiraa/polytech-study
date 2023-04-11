CREATE TABLE IMDBtest
(
    id        serial,
    ActorName varchar(255),
    RolesName jsonb
);

TRUNCATE IMDBtest;

ALTER TABLE IMDBtest
    ADD PRIMARY KEY (id);

-- размер таблицы - 832 МБ
SELECT pg_size_pretty(pg_total_relation_size('IMDBtest'));

-- запрос 1 (Имя актера и название фильмов, где все фильмы c неизвестным годом)
EXPLAIN ANALYSE
SELECT t1.ActorName, t2 ->> 'title' AS FILM_TITLE
FROM IMDBtest AS t1,
     jsonb_array_elements(t1.RolesName) as t2
WHERE (t2 ->> 'year') = '????'
  AND t1.RolesName != '[]';

-- Gather  (cost=1000.00..1424271.53 rows=1831019 width=47) (actual time=137.997..3077.742 rows=58046 loops=1)
--   Workers Planned: 2
--   Workers Launched: 2
--   ->  Nested Loop  (cost=0.00..1240169.63 rows=762925 width=47) (actual time=86.000..2278.361 rows=19349 loops=3)
--         ->  Parallel Seq Scan on imdbtest t1  (cost=0.00..86245.57 rows=762925 width=304) (actual time=85.845..664.221 rows=610289 loops=3)
--               Filter: (rolesname <> '[]'::jsonb)
--         ->  Function Scan on jsonb_array_elements t2  (cost=0.00..1.50 rows=1 width=32) (actual time=0.002..0.002 rows=0 loops=1830867)
--               Filter: ((value ->> 'year'::text) = '????'::text)
--               Rows Removed by Filter: 9
-- Planning Time: 0.141 ms
-- JIT:
--   Functions: 24
-- "  Options: Inlining true, Optimization true, Expressions true, Deforming true"
-- "  Timing: Generation 249.033 ms, Inlining 97.869 ms, Optimization 103.487 ms, Emission 56.135 ms, Total 506.525 ms"
-- Execution Time: 3080.177 ms

-- запрос 2 (строки, сортированные по максимальным жсончиком (по количеству ролей)
SELECT DISTINCT t1.id AS ID, jsonb_array_length(t1.RolesName) AS SIZE
FROM IMDBtest AS t1,
     jsonb_array_elements(t1.RolesName) as t2
WHERE t1.RolesName != '[]'
ORDER BY jsonb_array_length(t1.RolesName) = 2
    FETCH FIRST 1 ROWS ONLY;

-- изменение года на +1 для всех ролей для актера с 1 записью в бд (id 3444057)
SELECT *
FROM IMDBtest AS t1
WHERE id = 2849035;

-- [2023-04-11 18:01:27] 1 row affected in 64 ms
UPDATE IMDBtest
SET RolesName = json_build_array((SELECT jsonb_set(t2, '{year}', to_jsonb(((t2 ->> 'year')::int + 1)::text))
                 FROM IMDBtest AS t1,
                      jsonb_array_elements(t1.RolesName) as t2
                 WHERE t1.id = 3444057))
WHERE id = 3444057;


-- Update on imdbtest  (cost=12.38..20.39 rows=0 width=0)
--   InitPlan 1 (returns $1)
--     ->  Nested Loop  (cost=0.43..11.95 rows=100 width=32)
--           ->  Index Scan using imdbtest_pkey on imdbtest t1  (cost=0.43..8.45 rows=1 width=289)
--                 Index Cond: (id = 2849035)
--           ->  Function Scan on jsonb_array_elements t2  (cost=0.00..1.00 rows=100 width=32)
--   ->  Index Scan using imdbtest_pkey on imdbtest  (cost=0.43..8.45 rows=1 width=38)
--         Index Cond: (id = 2849035)



-- изменение года для актера с большим количество записей в бд (id 3444057)
SELECT *
FROM IMDBtest AS t1
WHERE id = 3444057;

BEGIN TRANSACTION;

UPDATE IMDBtest
SET RolesName = (((SELECT json_agg(jsonb_set(t2, '{year}', to_jsonb(((t2 ->> 'year')::int + 1)::text)))
                 FROM IMDBtest AS t1,
                      jsonb_array_elements(t1.RolesName) as t2
                 WHERE t1.id = 3444057)))
WHERE id = 3444057;

ROLLBACK;
COMMIT;
