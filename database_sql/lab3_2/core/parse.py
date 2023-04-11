import json
import re


def format_actor_name(name):
    parts = name.split(', ')
    if len(parts) == 2:
        last_name, first_name = parts
        return f'{first_name.strip()} {last_name.strip()}'
    return name


def parse_role(line):
    # все части роли
    match = re.match(r'^[^,]+,\s+[^(\t]+(\t+)(.*?)\s+\((\d{4}|\?\?\?\?)\)(.*?)\[(.*?)\](.*?)$', line)
    match2 = re.match(r'^[\t\s]+(.*?)\s+\((\d{4}|\?\?\?\?)\)(.*?)\[(.*?)\](.*?)$', line)

    if match:
        _, title, year, types, character, credit = match.groups()
    elif match2:
        title, year, types, character, credit = match2.groups()
    else:
        return None

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


def process_file(file_path, limit=None):
    actors_data = {}  # информация об актерах
    with open(file_path, 'r', encoding='ISO-8859-1') as file:
        line = file.readline()
        actor_count = 0

        name = None
        roles = []

        while line and (limit is None or actor_count < limit):
            if not line.startswith('\t'):
                name = line.split('\t')[0].strip()
                name = format_actor_name(name)
                role = parse_role(line)
                if role:
                    roles.append(role)
                line = file.readline()
                while line.startswith('\t'):
                    role = parse_role(line)
                    line = file.readline()
                    if role:
                        roles.append(role)

            if name and roles:
                actors_data[name] = json.dumps(roles)
                actor_count += 1
                name = None
                roles = []

    return actors_data
