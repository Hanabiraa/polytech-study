import time
from collections import defaultdict
from statistics import mean

import matplotlib.pyplot as plt
from psycopg2.pool import ThreadedConnectionPool

toast_size = {}  # key: [toast object len, toast size in bytes]
statistic = defaultdict(list)  # toast len : [time to access, ...]


def stat(params):
    global toast_size, statistic
    pool = ThreadedConnectionPool(
        minconn=1,
        maxconn=10,
        **params
    )

    start_timer = time.time()
    collect_data(pool)
    print(f"collect stat dict(key=toast_size) in {(time.time() - start_timer) / 60} mins")

    start_timer = time.time()
    collect_time(pool)
    print(f"collect access time dict(toast_bytes_size=time_to_access) in {(time.time() - start_timer) / 60} mins")

    start_timer = time.time()
    create_analytics()
    print(f"create plot(toast_bytes_size=time_to_access) in {(time.time() - start_timer) / 60} mins")


def collect_data(pool):
    global toast_size
    conn = pool.getconn()
    if conn:
        cursor = conn.cursor()
        cursor.itersize = 2000

        cursor.execute(
            """
            SELECT t1.id, jsonb_array_length(t1.RolesName) AS SIZE, pg_column_size(t1.RolesName)
            FROM IMDBtest AS t1
            WHERE t1.RolesName != '[]'
            """
        )
        for row in cursor:
            toast_size[row[0]] = [row[1], row[2]]
        cursor.close()
    conn.commit()
    pool.putconn(conn)


def collect_time(pool):
    global toast_size, statistic
    conn = pool.getconn()
    if conn:
        cursor = conn.cursor()

        for key, (size, bytes) in toast_size.items():
            cursor.execute(
                f"""
                EXPLAIN (ANALYSE, TIMING, FORMAT JSON)
                SELECT jsonb_array_elements(t1.RolesName) ->> 'year' AS YEAR
                FROM imdbtest AS t1
                WHERE t1.id = {key}
                LIMIT 1;
                """
            )

            for row in cursor:
                statistic[bytes].append(row[0][0]['Execution Time'])
        cursor.close()
    conn.commit()
    pool.putconn(conn)


def create_analytics():
    global statistic

    avg_data = {}

    for key, vals in statistic.items():
        avg_data[key] = mean(vals)

    x_axis = list(map(lambda x: x // 1000, avg_data.keys()))
    y_axis = avg_data.values()

    fig, ax = plt.subplots()
    ax.scatter(x_axis, y_axis, marker='o', c=x_axis)
    ax.grid()
    ax.set_xlabel("Json toast KB")
    ax.set_ylabel("Time to access")
    plt.savefig("stat.png")
