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

DROP TABLE retailCenter, shippedItem, TransportationEvent, itemTransportation;