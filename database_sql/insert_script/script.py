import time
from functools import partial

import psycopg2.extras
from psycopg2.pool import ThreadedConnectionPool

from core.fake_generator import (
    get_retail_center_type_count,
    make_retail_centers,
    make_transport_events,
    make_shipped_item,
    make_item_transportation,
)
from core.test_connection import test_connect


def run_insert(params):
    global retail_center_id

    pool = ThreadedConnectionPool(
        minconn=1,
        maxconn=10,
        **params
    )

    start_timer = time.time()
    insert_centers(pool=pool)
    print(f"insert centers in {(time.time() - start_timer) / 60} mins")

    start_timer = time.time()
    insert_events(pool=pool)
    print(f"insert events in {(time.time() - start_timer) / 60} mins")

    start_timer = time.time()
    for center_id in range(1, get_retail_center_type_count() + 1):
        insert_shipped_items(pool=pool, center_id=center_id)
    print(f"insert shipped items in {(time.time() - start_timer) / 60} mins")

    start_timer = time.time()
    insert_item_transportation(pool=pool)
    print(f"insert item transportation in {(time.time() - start_timer) / 60} mins")


def insert_centers(pool):
    sql = "INSERT INTO retailcenter (type, address) VALUES %s"
    __insert(
        pool=pool,
        sql=sql,
        data_maker=make_retail_centers
    )


def insert_events(pool):
    sql = "INSERT INTO transportationevent (type, deliveryrout) VALUES %s"
    __insert(
        pool=pool,
        sql=sql,
        data_maker=make_transport_events
    )


def insert_shipped_items(pool, center_id):
    sql = "INSERT INTO shippeditem (retailcenterid, weight, dimension, insuranceamt, destination, finaldeliverydate) VALUES %s"
    __insert(
        pool=pool,
        sql=sql,
        data_maker=partial(make_shipped_item, center_id=center_id, size=100_000)
    )
    print(f"insert 100_000 items for retail center #{center_id}")


def insert_item_transportation(pool):
    sql = "INSERT INTO itemtransportation (transportationeventseqnumber, shippeditemnum) VALUES %s"
    __insert(
        pool=pool,
        sql=sql,
        data_maker=make_item_transportation
    )


def __insert(pool, sql, data_maker):
    conn = pool.getconn()
    if conn:
        cursor = conn.cursor()

        psycopg2.extras.execute_values(
            cur=cursor,
            sql=sql,
            argslist=data_maker(),
            template=None,
            page_size=10_000,
        )

        cursor.close()
    conn.commit()
    pool.putconn(conn)


def main():
    params = dict(
        host="localhost",
        database="polyDB",
        user="sushi",
        password="1234",
        options="-c search_path=lab3",
    )
    test_connect(params)
    run_insert(params)


if __name__ == "__main__":
    start_time = time.time()
    main()
    print(f"\n\nthe script was executed for {(time.time() - start_time) / 60} mins")
