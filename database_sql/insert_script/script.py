import time

import psycopg2.extras
from psycopg2.pool import ThreadedConnectionPool

from core.fake_generator import (
    make_retail_centers,
    make_transport_events,
    make_shipped_item,
    make_item_transportation
)
from core.test_connection import test_connect

retail_center_id = []
transportation_events_id = []


def run_insert(params):
    global retail_center_id
    pool = ThreadedConnectionPool(
        minconn=1,
        maxconn=10,
        **params
    )

    insert_centers(pool=pool)
    print("insert centers")

    insert_events(pool=pool)
    print("insert events")

    for center_id in retail_center_id:
        insert_shipped_items(pool=pool, center_id=center_id)
    print("insert shipped items")

    insert_item_transportation(pool=pool)
    print("insert item transportation")


def insert_centers(pool):
    global retail_center_id
    conn = pool.getconn()
    if conn:
        cursor = conn.cursor()

        data = make_retail_centers()
        retail_center_id = [id for id in range(1, len(data) + 1)]

        sql = "INSERT INTO retailcenter (type, address) VALUES %s"
        psycopg2.extras.execute_values(
            cur=cursor,
            sql=sql,
            argslist=data,
            template=None,
            page_size=100,
        )

        cursor.close()
    conn.commit()
    pool.putconn(conn)


def insert_events(pool):
    global transportation_events_id
    conn = pool.getconn()
    if conn:
        cursor = conn.cursor()

        data = make_transport_events()
        transportation_events_id = [id for id in range(1, len(data) + 1)]

        sql = "INSERT INTO transportationevent (type, deliveryrout) VALUES %s"
        psycopg2.extras.execute_values(
            cur=cursor,
            sql=sql,
            argslist=data,
            template=None,
            page_size=100,
        )

        cursor.close()
    conn.commit()
    pool.putconn(conn)


def insert_shipped_items(pool, center_id):
    global retail_center_id
    conn = pool.getconn()
    if conn:
        cursor = conn.cursor()

        sql = "INSERT INTO shippeditem (retailcenterid, weight, dimension, insuranceamt, destination, finaldeliverydate) VALUES %s"
        psycopg2.extras.execute_values(
            cur=cursor,
            sql=sql,
            argslist=make_shipped_item(center_id=center_id, size=100_000),
            template=None,
            page_size=10_000,
        )
        print(f"insert 100_000 items for retail center #{center_id}")

        cursor.close()
    conn.commit()
    pool.putconn(conn)


def insert_item_transportation(pool):
    conn = pool.getconn()
    if conn:
        cursor = conn.cursor()

        sql = "INSERT INTO itemtransportation (transportationeventseqnumber, shippeditemnum) VALUES %s"
        psycopg2.extras.execute_values(
            cur=cursor,
            sql=sql,
            argslist=make_item_transportation(),
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
