import random

from faker import Faker

Faker.seed(0)
faker = Faker()

retail_center_type = [
    "Big box retailers",
    "Small box retailers",
    "Discount stores",
    "Grocery chains",
    "Pharmacies",
    "Specialty retail",
    "Restaurants",
    "Small banks",
    "Medium banks",
    "Big banks",
]

transp_event_type = [
    "car",
    "plane",
    "ship",
    "human"
]

def get_retail_center_type_count():
    global retail_center_type
    return len(retail_center_type)

def get_transp_event_type_count():
    global transp_event_type
    return len(transp_event_type)


def make_retail_centers():
    global retail_center_type
    global faker

    return [
        [type, faker.address()] for type in retail_center_type
    ]


def make_transport_events():
    global transp_event_type
    global faker

    return [
        [type, faker.address()] for type in transp_event_type
    ]


def make_shipped_item(center_id, size):
    global faker

    return [
        [
            center_id,
            random.randint(1, 150),
            random.randint(1, 20),
            random.randint(1, 5000),
            faker.address(),
            faker.date_this_century(before_today=False, after_today=True),
        ] for _ in range(size)
    ]


def make_item_transportation():
    data = []
    for item_id in range(1, 1_000_001):
        for _ in range(10):
            data.append(
                [random.randint(1, 4), item_id]
            )
    return data
