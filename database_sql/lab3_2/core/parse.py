import json
import re


def parse_role(line):
    # все части роли
    match = re.match(
        r'^(.*?) \((\d{4}|\?\?\?\?)\)(.*?)\[(.*?)\](.*?)$', line.strip()
    )

    if not match:
        return None

    title, year, types, character, credit = match.groups()

    role = {
        'title': title.strip('"'),
        'year': year,
        'character': character.strip(),
    }

    # атрибуты типов
    types = re.findall(r'\((.*?)\)', types)
    for i, type_ in enumerate(types, start=1):
        role[f'type{i}'] = type_

    # атрибуты кредитов
    credit_match = re.search(r'<(.*?)>', credit)
    if credit_match:
        role['credit'] = credit_match.group(1)

    return role


def process_file(file_path):
    actors_data = {}  # информация об актерах
    with open(file_path, 'r', encoding='ISO-8859-1') as file:
        line = file.readline()

        while line:
            # Ищем разделитель актеров
            if not line.strip() or line.startswith('\t\t'):
                line = file.readline()
                continue

            # Извлекаем имя актера
            name = line.split('\t')[0].strip().replace(',', '')
            roles = []

            # Обрабатываем роли актера
            while line and not line.startswith('\t\t'):
                role = parse_role(line)
                if role:
                    roles.append(role)
                line = file.readline()

            # Добавьте запись актера
            actors_data[name] = json.dumps(roles)

    return actors_data

# def load_data_to_postgresql(actors_data):
#     for actor_data in actors_data:
#         actor_name = actor_data['actor_name']
#         roles_name = json.dumps(actor_data['roles_name'])
#         if actor_name and roles_name:
#             # Подготовка запроса на вставку записи актера в таблицу
#             insert_plan = plpy.prepare(
#                 "INSERT INTO actors (actor_name, roles_name) VALUES ($1, $2)",
#                 ["text", "jsonb"],
#             )
#             # Выполнение запроса с переданными параметрами
#             plpy.execute(insert_plan, [actor_name, roles_name])
#
# file_path = '/Users/allamosina/Desktop/actors.list.txt'
# actors_data = process_file(file_path)
# load_data_to_postgresql(actors_data)
