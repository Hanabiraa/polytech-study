import time

import psycopg2.extras
from psycopg2.pool import ThreadedConnectionPool

from core.parse import (
    process_file
)
from core.test_connection import test_connect

actor_data = None


def run_insert(params):
    global actor_data

    pool = ThreadedConnectionPool(
        minconn=1,
        maxconn=10,
        **params
    )

    start_timer = time.time()
    file_path = '/storage/documents/actors.list.txt'
    actor_data = process_file(file_path)
    print(f"parse file in {(time.time() - start_timer) / 60} mins")

    start_timer = time.time()
    insert(pool=pool, data=actor_data)
    print(f"insert data in {(time.time() - start_timer) / 60} mins")


def insert(pool, data):
    sql = "INSERT INTO imdbtest (ActorName, RolesName) VALUES %s"
    __insert(
        pool=pool,
        sql=sql,
        data=data
    )


def __insert(pool, sql, data):
    conn = pool.getconn()
    if conn:
        cursor = conn.cursor()

        psycopg2.extras.execute_values(
            cur=cursor,
            sql=sql,
            argslist=data.items(),
            template=None,
            page_size=50_000,
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
