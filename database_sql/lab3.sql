-- подготовка к загрузке данных

-- -- быстродействие CREATE INDEX, ALTER TABLE ADD FOREIGN KEY
-- -- 128MB
-- -- default: 64MB
SHOW maintenance_work_mem;
SET maintenance_work_mem='128MB';

-- -- частота создания контрольных точек для сброса "грязных страниц" на диск
-- -- 3GB
-- -- default: 1GB
SHOW max_wal_size;
SET max_wal_size='3GB'; -- not work (cant be changed now)

-- -- отключение архивации WAL и потоковой репликации
SET wal_level=minimal; -- not work (cant be changed without restarting the server)
SET archive_mode=off; -- not work (cant be changed without restarting the server)


-- -- отключить механизм транзакций
-- -- отключить запись логов
--- --- --- либо
-- -- без индексов, после вставки - навсеть через ALTER TABLE

-- создание таблиц
CREATE TABLE shippedItem
(
    itemNum serial,
    retailCenterID int,
    weight numeric(19, 0),
    dimension numeric(19, 0),
    insuranceAmt numeric(19, 0),
    destination varchar(255),
    finalDeliveryDate date
);

CREATE TABLE retailCenter
(
    id serial,
    type varchar(255),
    address varchar(255)
);

CREATE TABLE TransportationEvent
(
    seqNumber serial,
    type varchar(255),
    deliveryRout varchar(255)
);

CREATE TABLE itemTransportation
(
    transportationEventSeqNumber int,
    shippedItemNum int
);

-- добавление PK и FK для таблиц
ALTER TABLE retailCenter
ADD PRIMARY KEY (id);

ALTER TABLE shippedItem
ADD PRIMARY KEY (itemNum),
ADD FOREIGN KEY (retailCenterID) REFERENCES retailCenter(id);

ALTER TABLE TransportationEvent
ADD PRIMARY KEY (seqNumber);

ALTER TABLE itemTransportation
ADD FOREIGN KEY (transportationEventSeqNumber) REFERENCES TransportationEvent(seqNumber),
ADD FOREIGN KEY (shippedItemNum) REFERENCES shippedItem(itemNum);


-- создание секционированной таблицы по дате доставки
CREATE TABLE shippedItem_sec (LIKE shippedItem)
PARTITION BY RANGE (finalDeliveryDate);

-- -- [0A000] ERROR: unique constraint on partitioned table must include all partitioning columns
-- -- Detail: PRIMARY KEY constraint on table "shippeditem_sec" lacks column "finaldeliverydate"
--  --which is part of the partition key.
ALTER TABLE shippedItem_sec
ADD PRIMARY KEY (itemNum),
ADD FOREIGN KEY (retailCenterID) REFERENCES retailCenter(id);

-- -- секции по 10 лет
CREATE TABLE shippedItem_sec_q2 PARTITION OF shippedItem_sec
    FOR VALUES FROM ('2020-01-01') TO ('2030-01-01');

CREATE TABLE shippedItem_sec_q3 PARTITION OF shippedItem_sec
    FOR VALUES FROM ('2030-01-01') TO ('2040-01-01');

CREATE TABLE shippedItem_sec_q4 PARTITION OF shippedItem_sec
    FOR VALUES FROM ('2040-01-01') TO ('2050-01-01');

CREATE TABLE shippedItem_sec_q5 PARTITION OF shippedItem_sec
    FOR VALUES FROM ('2050-01-01') TO ('2060-01-01');

CREATE TABLE shippedItem_sec_q6 PARTITION OF shippedItem_sec
    FOR VALUES FROM ('2060-01-01') TO ('2070-01-01');

CREATE TABLE shippedItem_sec_q7 PARTITION OF shippedItem_sec
    FOR VALUES FROM ('2070-01-01') TO ('2080-01-01');

CREATE TABLE shippedItem_sec_q8 PARTITION OF shippedItem_sec
    FOR VALUES FROM ('2080-01-01') TO ('2090-01-01');

CREATE TABLE shippedItem_sec_q9 PARTITION OF shippedItem_sec
    FOR VALUES FROM ('2090-01-01') TO ('3000-01-01');

-- -- вставка данных
INSERT INTO shippedItem_sec
SELECT * from shippedItem;















-- запрос к 1 таблице
-- -- без секционирования, без индекса
EXPLAIN ANALYZE
SELECT *
FROM shippedItem
WHERE weight BETWEEN 3 and 10 and dimension > 15 and finalDeliveryDate < current_date + '5 years'::interval
ORDER BY finalDeliveryDate;

-- Gather Merge  (cost=24151.14..24169.34 rows=156 width=71) (actual time=49.480..51.923 rows=217 loops=1)
--   Workers Planned: 2
--   Workers Launched: 2
--   ->  Sort  (cost=23151.12..23151.31 rows=78 width=71) (actual time=40.438..40.443 rows=72 loops=3)
--         Sort Key: finaldeliverydate
--         Sort Method: quicksort  Memory: 36kB
--         Worker 0:  Sort Method: quicksort  Memory: 34kB
--         Worker 1:  Sort Method: quicksort  Memory: 35kB
--         ->  Parallel Seq Scan on shippeditem  (cost=0.00..23148.67 rows=78 width=71) (actual time=1.462..40.346 rows=72 loops=3)
--               Filter: ((weight < '10'::numeric) AND (dimension > '15'::numeric) AND (weight < '3'::numeric) AND (finaldeliverydate < (CURRENT_DATE + '5 years'::interval)))
--               Rows Removed by Filter: 333261
-- Planning Time: 0.070 ms
-- Execution Time: 51.941 ms


EXPLAIN ANALYZE
SELECT *
FROM shippedItem_sec
WHERE weight BETWEEN 3 and 10 and dimension > 15 and finalDeliveryDate < current_date + '5 years'::interval
ORDER BY finalDeliveryDate;

-- Gather Merge  (cost=28444.37..28465.84 rows=184 width=71) (actual time=13.509..15.662 rows=217 loops=1)
--   Workers Planned: 2
--   Workers Launched: 2
--   ->  Sort  (cost=27444.34..27444.57 rows=92 width=71) (actual time=3.575..3.587 rows=72 loops=3)
--         Sort Key: shippeditem_sec.finaldeliverydate
--         Sort Method: quicksort  Memory: 55kB
--         Worker 0:  Sort Method: quicksort  Memory: 25kB
--         Worker 1:  Sort Method: quicksort  Memory: 25kB
--         ->  Parallel Append  (cost=0.00..27441.34 rows=92 width=71) (actual time=0.004..3.520 rows=72 loops=3)
--               Subplans Removed: 7
--               ->  Parallel Seq Scan on shippeditem_sec_q2 shippeditem_sec_1  (cost=0.00..2428.65 rows=120 width=71) (actual time=0.009..10.542 rows=217 loops=1)
--                     Filter: ((weight < '10'::numeric) AND (dimension > '15'::numeric) AND (weight < '3'::numeric) AND (finaldeliverydate < (CURRENT_DATE + '5 years'::interval)))
--                     Rows Removed by Filter: 88295
-- Planning Time: 0.190 ms
-- Execution Time: 15.686 ms


-- Cоздание индекса для таблицы shippeditem и shippeditem_sec
CREATE INDEX weight_idx ON shippedItem(weight);
CREATE INDEX weight_idx_sec ON shippedItem_sec(weight);

EXPLAIN ANALYZE
SELECT *
FROM shippedItem
WHERE weight BETWEEN 3 and 10 and dimension > 15 and finalDeliveryDate < current_date + '5 years'::interval
ORDER BY finalDeliveryDate;

-- Sort  (cost=15182.20..15184.41 rows=884 width=71) (actual time=46.190..46.254 rows=881 loops=1)
--   Sort Key: finaldeliverydate
--   Sort Method: quicksort  Memory: 148kB
--   ->  Bitmap Heap Scan on shippeditem  (cost=1099.59..15138.94 rows=884 width=71) (actual time=6.757..45.998 rows=881 loops=1)
--         Recheck Cond: ((weight >= '3'::numeric) AND (weight <= '10'::numeric))
--         Filter: ((dimension > '15'::numeric) AND (finaldeliverydate < (CURRENT_DATE + '5 years'::interval)))
--         Rows Removed by Filter: 52450
--         Heap Blocks: exact=12563
--         ->  Bitmap Index Scan on weight_idx  (cost=0.00..1099.37 rows=52294 width=0) (actual time=5.227..5.227 rows=53331 loops=1)
--               Index Cond: ((weight >= '3'::numeric) AND (weight <= '10'::numeric))
-- Planning Time: 0.165 ms
-- Execution Time: 46.289 ms

EXPLAIN ANALYZE
SELECT *
FROM shippedItem_sec
WHERE weight BETWEEN 3 and 10 and dimension > 15 and finalDeliveryDate < current_date + '5 years'::interval
ORDER BY finalDeliveryDate;

-- Sort  (cost=15183.65..15185.76 rows=843 width=71) (actual time=4.908..4.967 rows=881 loops=1)
--   Sort Key: shippeditem_sec.finaldeliverydate
--   Sort Method: quicksort  Memory: 148kB
--   ->  Append  (cost=97.37..15142.68 rows=843 width=71) (actual time=0.717..4.714 rows=881 loops=1)
--         Subplans Removed: 7
--         ->  Bitmap Heap Scan on shippeditem_sec_q2 shippeditem_sec_1  (cost=97.37..1336.22 rows=836 width=71) (actual time=0.717..4.648 rows=881 loops=1)
--               Recheck Cond: ((weight >= '3'::numeric) AND (weight <= '10'::numeric))
--               Filter: ((dimension > '15'::numeric) AND (finaldeliverydate < (CURRENT_DATE + '5 years'::interval)))
--               Rows Removed by Filter: 3824
--               Heap Blocks: exact=1111
--               ->  Bitmap Index Scan on shippeditem_sec_q2_weight_idx  (cost=0.00..97.16 rows=4474 width=0) (actual time=0.555..0.555 rows=4705 loops=1)
--                     Index Cond: ((weight >= '3'::numeric) AND (weight <= '10'::numeric))
-- Planning Time: 0.794 ms
-- Execution Time: 5.022 ms









DROP INDEX weight_idx, weight_idx_sec;
-- запрос к нескольким таблицам
-- -- без секционирования, без индекса
EXPLAIN ANALYZE
SELECT *
FROM itemTransportation as t1
INNER JOIN transportationevent as t2 ON t1.transportationEventSeqNumber = t2.seqNumber
INNER JOIN shippedItem as t3 ON t1.shippedItemNum = t3.itemNum
WHERE t1.transportationEventSeqNumber = 1
  and t3.weight BETWEEN 1 and 5 and t3.dimension = 4
  and t3.finalDeliveryDate BETWEEN current_date and current_date + '25 years'::interval;

-- Nested Loop  (cost=26234.72..125449.83 rows=1312 width=1115) (actual time=70.147..281.025 rows=1364 loops=1)
--   ->  Seq Scan on transportationevent t2  (cost=0.00..1.05 rows=1 width=1036) (actual time=8.994..8.995 rows=1 loops=1)
--         Filter: (seqnumber = 1)
--         Rows Removed by Filter: 3
--   ->  Gather  (cost=26234.72..125435.66 rows=1312 width=79) (actual time=61.148..271.830 rows=1364 loops=1)
--         Workers Planned: 2
--         Workers Launched: 2
--         ->  Parallel Hash Join  (cost=25234.72..124304.46 rows=547 width=79) (actual time=51.930..257.946 rows=455 loops=3)
--               Hash Cond: (t1.shippeditemnum = t3.itemnum)
--               ->  Parallel Seq Scan on itemtransportation t1  (cost=0.00..96331.33 rows=1043195 width=8) (actual time=0.037..155.505 rows=833423 loops=3)
--                     Filter: (transportationeventseqnumber = 1)
--                     Rows Removed by Filter: 2499910
--               ->  Parallel Hash  (cost=25232.00..25232.00 rows=218 width=71) (actual time=49.909..49.910 rows=176 loops=3)
--                     Buckets: 1024  Batches: 1  Memory Usage: 104kB
--                     ->  Parallel Seq Scan on shippeditem t3  (cost=0.00..25232.00 rows=218 width=71) (actual time=5.494..49.815 rows=176 loops=3)
--                           Filter: ((weight >= '1'::numeric) AND (weight <= '5'::numeric) AND (dimension = '4'::numeric) AND (finaldeliverydate >= CURRENT_DATE) AND (finaldeliverydate <= (CURRENT_DATE + '25 years'::interval)))
--                           Rows Removed by Filter: 333157
-- Planning Time: 0.287 ms
-- JIT:
--   Functions: 46
-- "  Options: Inlining false, Optimization false, Expressions true, Deforming true"
-- "  Timing: Generation 2.108 ms, Inlining 0.000 ms, Optimization 1.026 ms, Emission 22.824 ms, Total 25.958 ms"
-- Execution Time: 281.950 ms


EXPLAIN ANALYZE
SELECT *
FROM itemTransportation as t1
INNER JOIN transportationevent as t2 ON t1.transportationEventSeqNumber = t2.seqNumber
INNER JOIN shippedItem_sec as t3 ON t1.shippedItemNum = t3.itemNum
WHERE t1.transportationEventSeqNumber = 1 and t3.weight BETWEEN 1 and 5 and t3.dimension = 4 and t3.finalDeliveryDate BETWEEN current_date and current_date + '25 years'::interval;

-- Nested Loop  (cost=114446.11..149109.27 rows=1754 width=1115) (actual time=285.922..351.889 rows=1364 loops=1)
--   ->  Seq Scan on transportationevent t2  (cost=0.00..1.05 rows=1 width=1036) (actual time=0.448..0.452 rows=1 loops=1)
--         Filter: (seqnumber = 1)
--         Rows Removed by Filter: 3
--   ->  Gather  (cost=114446.11..149090.68 rows=1754 width=79) (actual time=285.469..351.187 rows=1364 loops=1)
--         Workers Planned: 2
--         Workers Launched: 2
--         ->  Parallel Hash Join  (cost=113446.11..147915.28 rows=731 width=79) (actual time=271.653..322.293 rows=455 loops=3)
--               Hash Cond: (t3.itemnum = t1.shippeditemnum)
--               ->  Parallel Append  (cost=0.00..30383.06 rows=201 width=71) (actual time=0.123..14.951 rows=176 loops=3)
--                     Subplans Removed: 5
--                     ->  Parallel Seq Scan on shippeditem_sec_q4 t3_3  (cost=0.00..3957.49 rows=94 width=71) (actual time=0.112..5.605 rows=56 loops=3)
--                           Filter: ((weight >= '1'::numeric) AND (weight <= '5'::numeric) AND (dimension = '4'::numeric) AND (finaldeliverydate >= CURRENT_DATE) AND (finaldeliverydate <= (CURRENT_DATE + '25 years'::interval)))
--                           Rows Removed by Filter: 43360
--                     ->  Parallel Seq Scan on shippeditem_sec_q3 t3_2  (cost=0.00..3928.82 rows=112 width=71) (actual time=0.128..8.629 rows=102 loops=2)
--                           Filter: ((weight >= '1'::numeric) AND (weight <= '5'::numeric) AND (dimension = '4'::numeric) AND (finaldeliverydate >= CURRENT_DATE) AND (finaldeliverydate <= (CURRENT_DATE + '25 years'::interval)))
--                           Rows Removed by Filter: 64550
--                     ->  Parallel Seq Scan on shippeditem_sec_q2 t3_1  (cost=0.00..2688.98 rows=70 width=71) (actual time=0.091..10.724 rows=156 loops=1)
--                           Filter: ((weight >= '1'::numeric) AND (weight <= '5'::numeric) AND (dimension = '4'::numeric) AND (finaldeliverydate >= CURRENT_DATE) AND (finaldeliverydate <= (CURRENT_DATE + '25 years'::interval)))
--                           Rows Removed by Filter: 88356
--               ->  Parallel Hash  (cost=96331.21..96331.21 rows=1043192 width=8) (actual time=250.662..250.662 rows=833423 loops=3)
--                     Buckets: 131072  Batches: 64  Memory Usage: 2592kB
--                     ->  Parallel Seq Scan on itemtransportation t1  (cost=0.00..96331.21 rows=1043192 width=8) (actual time=9.334..170.616 rows=833423 loops=3)
--                           Filter: (transportationeventseqnumber = 1)
--                           Rows Removed by Filter: 2499910
-- Planning Time: 0.375 ms
-- JIT:
--   Functions: 55
-- "  Options: Inlining false, Optimization false, Expressions true, Deforming true"
-- "  Timing: Generation 2.853 ms, Inlining 0.000 ms, Optimization 1.390 ms, Emission 31.675 ms, Total 35.918 ms"
-- Execution Time: 352.512 ms


-- создание 3 индексов для запроса
CREATE INDEX fk_idx ON itemTransportation(transportationEventSeqNumber); -- TODO: сделать хэш
CREATE INDEX complex_idx ON shippedItem(dimension, weight); -- гибридные индексы - сложно, для того, чтобы понять - перебирать все подряд и explain analyze
CREATE INDEX date_idx ON shippedItem(finalDeliveryDate);

-- также 2 индекса для секционированной таблицы
CREATE INDEX complex_idx_sec ON shippedItem_sec(dimension, weight);
CREATE INDEX date_idx_sec ON shippedItem_sec(finalDeliveryDate);


EXPLAIN ANALYZE
SELECT *
FROM itemTransportation as t1
INNER JOIN transportationevent as t2 ON t1.transportationEventSeqNumber = t2.seqNumber
INNER JOIN shippedItem as t3 ON t1.shippedItemNum = t3.itemNum
WHERE t1.transportationEventSeqNumber = 1
  and t3.weight BETWEEN 1 and 5 and t3.dimension = 4
  and t3.finalDeliveryDate BETWEEN current_date and current_date + '25 years'::interval;

-- Nested Loop  (cost=33405.76..93577.46 rows=1312 width=1115) (actual time=64.311..242.089 rows=1364 loops=1)
--   ->  Seq Scan on transportationevent t2  (cost=0.00..1.05 rows=1 width=1036) (actual time=0.003..0.006 rows=1 loops=1)
--         Filter: (seqnumber = 1)
--         Rows Removed by Filter: 3
--   ->  Gather  (cost=33405.76..93563.29 rows=1312 width=79) (actual time=64.306..241.835 rows=1364 loops=1)
--         Workers Planned: 2
--         Workers Launched: 2
--         ->  Parallel Hash Join  (cost=32405.76..92432.09 rows=547 width=79) (actual time=53.663..225.441 rows=455 loops=3)
--               Hash Cond: (t1.shippeditemnum = t3.itemnum)
--               ->  Parallel Bitmap Heap Scan on itemtransportation t1  (cost=27879.85..85167.79 rows=1043195 width=8) (actual time=50.774..167.940 rows=833423 loops=3)
--                     Recheck Cond: (transportationeventseqnumber = 1)
--                     Heap Blocks: exact=15998
--                     ->  Bitmap Index Scan on fk_idx  (cost=0.00..27253.94 rows=2503667 width=0) (actual time=51.813..51.813 rows=2500269 loops=1)
--                           Index Cond: (transportationeventseqnumber = 1)
--               ->  Parallel Hash  (cost=4522.06..4522.06 rows=308 width=71) (actual time=1.962..1.963 rows=176 loops=3)
--                     Buckets: 1024  Batches: 1  Memory Usage: 72kB
--                     ->  Parallel Bitmap Heap Scan on shippeditem t3  (cost=48.42..4522.06 rows=308 width=71) (actual time=0.462..5.759 rows=529 loops=1)
--                           Recheck Cond: ((dimension = '4'::numeric) AND (weight >= '1'::numeric) AND (weight <= '5'::numeric))
--                           Filter: ((finaldeliverydate >= CURRENT_DATE) AND (finaldeliverydate <= (CURRENT_DATE + '25 years'::interval)))
--                           Rows Removed by Filter: 1147
--                           Heap Blocks: exact=1583
--                           ->  Bitmap Index Scan on complex_idx  (cost=0.00..48.29 rows=1589 width=0) (actual time=0.298..0.298 rows=1676 loops=1)
--                                 Index Cond: ((dimension = '4'::numeric) AND (weight >= '1'::numeric) AND (weight <= '5'::numeric))
-- Planning Time: 0.315 ms
-- Execution Time: 242.165 ms

EXPLAIN ANALYZE
SELECT *
FROM itemTransportation as t1
INNER JOIN transportationevent as t2 ON t1.transportationEventSeqNumber = t2.seqNumber
INNER JOIN shippedItem_sec as t3 ON t1.shippedItemNum = t3.itemNum
WHERE t1.transportationEventSeqNumber = 1 and t3.weight BETWEEN 1 and 5 and t3.dimension = 4 and t3.finalDeliveryDate BETWEEN current_date and current_date + '25 years'::interval;

-- Nested Loop  (cost=103289.58..109077.37 rows=1754 width=1115) (actual time=272.890..340.008 rows=1364 loops=1)
--   ->  Seq Scan on transportationevent t2  (cost=0.00..1.05 rows=1 width=1036) (actual time=0.625..0.629 rows=1 loops=1)
--         Filter: (seqnumber = 1)
--         Rows Removed by Filter: 3
--   ->  Gather  (cost=103289.58..109058.78 rows=1754 width=79) (actual time=272.260..339.178 rows=1364 loops=1)
--         Workers Planned: 2
--         Workers Launched: 2
--         ->  Parallel Hash Join  (cost=102289.58..107883.38 rows=731 width=79) (actual time=262.126..309.494 rows=455 loops=3)
--               Hash Cond: (t3.itemnum = t1.shippeditemnum)
--               ->  Parallel Append  (cost=6.85..1514.56 rows=201 width=71) (actual time=0.136..0.810 rows=176 loops=3)
--                     Subplans Removed: 5
--                     ->  Parallel Bitmap Heap Scan on shippeditem_sec_q4 t3_3  (cost=6.88..562.47 rows=94 width=71) (actual time=0.056..0.309 rows=56 loops=3)
--                           Recheck Cond: ((dimension = '4'::numeric) AND (weight >= '1'::numeric) AND (weight <= '5'::numeric))
--                           Filter: ((finaldeliverydate >= CURRENT_DATE) AND (finaldeliverydate <= (CURRENT_DATE + '25 years'::interval)))
--                           Rows Removed by Filter: 13
--                           Heap Blocks: exact=31
--                           ->  Bitmap Index Scan on shippeditem_sec_q4_dimension_weight_idx  (cost=0.00..6.84 rows=194 width=0) (actual time=0.082..0.082 rows=207 loops=1)
--                                 Index Cond: ((dimension = '4'::numeric) AND (weight >= '1'::numeric) AND (weight <= '5'::numeric))
--                     ->  Parallel Bitmap Heap Scan on shippeditem_sec_q3 t3_2  (cost=6.85..554.22 rows=112 width=71) (actual time=0.084..0.422 rows=102 loops=2)
--                           Recheck Cond: ((dimension = '4'::numeric) AND (weight >= '1'::numeric) AND (weight <= '5'::numeric))
--                           Filter: ((finaldeliverydate >= CURRENT_DATE) AND (finaldeliverydate <= (CURRENT_DATE + '25 years'::interval)))
--                           Heap Blocks: exact=87
--                           ->  Bitmap Index Scan on shippeditem_sec_q3_dimension_weight_idx  (cost=0.00..6.81 rows=191 width=0) (actual time=0.085..0.085 rows=204 loops=1)
--                                 Index Cond: ((dimension = '4'::numeric) AND (weight >= '1'::numeric) AND (weight <= '5'::numeric))
--                     ->  Parallel Bitmap Heap Scan on shippeditem_sec_q2 t3_1  (cost=5.93..355.26 rows=70 width=71) (actual time=0.099..0.592 rows=156 loops=1)
--                           Recheck Cond: ((dimension = '4'::numeric) AND (weight >= '1'::numeric) AND (weight <= '5'::numeric))
--                           Filter: ((finaldeliverydate >= CURRENT_DATE) AND (finaldeliverydate <= (CURRENT_DATE + '25 years'::interval)))
--                           Heap Blocks: exact=150
--                           ->  Bitmap Index Scan on shippeditem_sec_q2_dimension_weight_idx  (cost=0.00..5.91 rows=119 width=0) (actual time=0.048..0.048 rows=156 loops=1)
--                                 Index Cond: ((dimension = '4'::numeric) AND (weight >= '1'::numeric) AND (weight <= '5'::numeric))
--               ->  Parallel Hash  (cost=85167.79..85167.79 rows=1043195 width=8) (actual time=255.270..255.271 rows=833423 loops=3)
--                     Buckets: 131072  Batches: 64  Memory Usage: 2624kB
--                     ->  Parallel Bitmap Heap Scan on itemtransportation t1  (cost=27879.85..85167.79 rows=1043195 width=8) (actual time=43.065..161.851 rows=833423 loops=3)
--                           Recheck Cond: (transportationeventseqnumber = 1)
--                           Heap Blocks: exact=15933
--                           ->  Bitmap Index Scan on fk_idx  (cost=0.00..27253.94 rows=2503667 width=0) (actual time=47.891..47.891 rows=2500269 loops=1)
--                                 Index Cond: (transportationeventseqnumber = 1)
-- Planning Time: 0.691 ms
-- JIT:
--   Functions: 73
-- "  Options: Inlining false, Optimization false, Expressions true, Deforming true"
-- "  Timing: Generation 3.756 ms, Inlining 0.000 ms, Optimization 1.959 ms, Emission 37.428 ms, Total 43.143 ms"
-- Execution Time: 343.434 ms








-- полноитекстовый поиск
-- -- наивный
EXPLAIN ANALYZE
SELECT itemNum, ts_rank(to_tsvector("destination"), plainto_tsquery('Green')), destination
FROM shippedItem
WHERE to_tsvector("destination") @@ plainto_tsquery('Green')
ORDER BY ts_rank(to_tsvector("destination"), plainto_tsquery('Green')) DESC;

-- Gather Merge  (cost=228435.22..228921.28 rows=4166 width=52) (actual time=2207.237..2210.287 rows=10231 loops=1)
--   Workers Planned: 2
--   Workers Launched: 2
--   ->  Sort  (cost=227435.19..227440.40 rows=2083 width=52) (actual time=2196.848..2196.966 rows=3410 loops=3)
-- "        Sort Key: (ts_rank(to_tsvector((destination)::text), plainto_tsquery('Green'::text))) DESC"
--         Sort Method: quicksort  Memory: 528kB
--         Worker 0:  Sort Method: quicksort  Memory: 530kB
--         Worker 1:  Sort Method: quicksort  Memory: 522kB
--         ->  Parallel Seq Scan on shippeditem  (cost=0.00..227320.37 rows=2083 width=52) (actual time=4.684..2195.483 rows=3410 loops=3)
--               Filter: (to_tsvector((destination)::text) @@ plainto_tsquery('Green'::text))
--               Rows Removed by Filter: 329923
-- Planning Time: 0.072 ms
-- JIT:
--   Functions: 12
-- "  Options: Inlining false, Optimization false, Expressions true, Deforming true"
-- "  Timing: Generation 1.014 ms, Inlining 0.000 ms, Optimization 0.665 ms, Emission 10.821 ms, Total 12.499 ms"
-- Execution Time: 2210.874 ms

-- -- создание индекса
DROP INDEX IF EXISTS fullsearch_idx;
CREATE INDEX fullsearch_idx ON shippedItem USING gin (to_tsvector('english', destination));

EXPLAIN ANALYZE
SELECT itemNum, ts_rank(to_tsvector("destination"), plainto_tsquery('Green')), destination
FROM shippedItem
WHERE to_tsvector("destination") @@ plainto_tsquery('Green')
ORDER BY ts_rank(to_tsvector("destination"), plainto_tsquery('Green')) DESC;

-- Gather Merge  (cost=228435.22..228921.28 rows=4166 width=52) (actual time=2121.380..2124.303 rows=10231 loops=1)
--   Workers Planned: 2
--   Workers Launched: 2
--   ->  Sort  (cost=227435.19..227440.40 rows=2083 width=52) (actual time=2110.741..2110.871 rows=3410 loops=3)
-- "        Sort Key: (ts_rank(to_tsvector((destination)::text), plainto_tsquery('Green'::text))) DESC"
--         Sort Method: quicksort  Memory: 529kB
--         Worker 0:  Sort Method: quicksort  Memory: 532kB
--         Worker 1:  Sort Method: quicksort  Memory: 518kB
--         ->  Parallel Seq Scan on shippeditem  (cost=0.00..227320.37 rows=2083 width=52) (actual time=4.928..2109.825 rows=3410 loops=3)
--               Filter: (to_tsvector((destination)::text) @@ plainto_tsquery('Green'::text))
--               Rows Removed by Filter: 329923
-- Planning Time: 0.320 ms
-- JIT:
--   Functions: 12
-- "  Options: Inlining false, Optimization false, Expressions true, Deforming true"
-- "  Timing: Generation 1.611 ms, Inlining 0.000 ms, Optimization 0.688 ms, Emission 11.445 ms, Total 13.743 ms"
-- Execution Time: 2125.587 ms

-- добавим таблицу векторов заранее сформированных
DROP INDEX fullsearch_idx;

CREATE TABLE shippeditemVector(
    shipItemNum serial CONSTRAINT fk1 REFERENCES shippedItem(itemNum),
    dest_vector tsvector
);

INSERT INTO shippeditemvector
SELECT itemNum, to_tsvector(destination)
FROM shippedItem;

-- создание индекса для векторной таблицы
CREATE INDEX fullsearch_idx ON shippeditemvector USING gin (dest_vector); -- gist - топ для геолокации

-- обновленный запрос
EXPLAIN ANALYSE
SELECT t1.itemNum, ts_rank("dest_vector", plainto_tsquery('Green'))
FROM shippeditem AS t1
  LEFT JOIN shippeditemVector AS t2 ON t1.itemNum = t2.shipItemNum
WHERE "dest_vector" @@ plainto_tsquery('Green')
ORDER BY ts_rank("dest_vector", plainto_tsquery('Green')) DESC;

-- Gather Merge  (cost=25436.98..26324.87 rows=7610 width=8) (actual time=24.347..28.848 rows=10231 loops=1)
--   Workers Planned: 2
--   Workers Launched: 2
--   ->  Sort  (cost=24436.95..24446.47 rows=3805 width=8) (actual time=15.169..15.280 rows=3410 loops=3)
-- "        Sort Key: (ts_rank(t2.dest_vector, plainto_tsquery('Green'::text))) DESC"
--         Sort Method: quicksort  Memory: 495kB
--         Worker 0:  Sort Method: quicksort  Memory: 137kB
--         Worker 1:  Sort Method: quicksort  Memory: 137kB
--         ->  Nested Loop  (cost=99.46..24210.68 rows=3805 width=8) (actual time=1.143..14.771 rows=3410 loops=3)
--               ->  Parallel Bitmap Heap Scan on shippeditemvector t2  (cost=99.03..15870.16 rows=3805 width=106) (actual time=0.936..4.937 rows=3410 loops=3)
--                     Recheck Cond: (dest_vector @@ plainto_tsquery('Green'::text))
--                     Heap Blocks: exact=4862
--                     ->  Bitmap Index Scan on fullsearch_idx  (cost=0.00..96.75 rows=9133 width=0) (actual time=1.859..1.859 rows=10231 loops=1)
--                           Index Cond: (dest_vector @@ plainto_tsquery('Green'::text))
--               ->  Index Only Scan using shippeditem_pkey on shippeditem t1  (cost=0.42..1.94 rows=1 width=4) (actual time=0.002..0.002 rows=1 loops=10231)
--                     Index Cond: (itemnum = t2.shipitemnum)
--                     Heap Fetches: 1020
-- Planning Time: 0.181 ms
-- Execution Time: 29.098 ms