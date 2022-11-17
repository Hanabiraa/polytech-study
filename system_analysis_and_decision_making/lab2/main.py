prob_1_year = [0.3, 0.2, 0.2, 0.15, 0.09, 0.05, 0.01]
prob_2_year = [0.01, 0.03, 0.06, 0.1, 0.15, 0.25, 0.4]

demand = [0, 50, 100, 150, 200, 250, 300]
order = [0, 50, 100, 150, 200, 250, 300]

laplas_1_year = [0 for _ in range(7)]
laplas_2_year = [0 for _ in range(7)]

first_year_table = [[0 for _ in range(7)] for _ in range(7)]
second_year_table = [[0 for _ in range(7)] for _ in range(7)]
r = [0 for _ in range(7)]

# расчет первого года
for i in range(len(first_year_table)):
    for j in range(len(first_year_table)):
        first_year_table[i][j] = first_year_table[i][i] if j > i else demand[j] * 25_000 - order[i] * 15_000
        laplas_1_year[i] += first_year_table[i][j] * prob_1_year[j]

print("1 год:")
# распечатка таблицы
for name in range(9):
    print(f"{15 * '-'}", end='|')
else:
    print()
print(f"{'спрос/заказ':^15s}", end='|')
for name in demand:
    print(f"{name:^15_.0f}", end='|')
else:
    print(f"{'Байес-Лаплас':^15}", end='|')
    print()

for name in range(9):
    print(f"{15 * '-'}", end='|')
else:
    print()

for row, laplas, idx in zip(first_year_table, laplas_1_year, range(7)):
    print(f"{demand[idx]:^15_.0f}", end='|')
    for cell in row:
        print(f"{cell:^15_.0f}", end='|')
    print(f"{laplas:^15_.2f}", end='|')
    print()
for name in range(9):
    print(f"{15 * '-'}", end='|')
else:
    print()


# расчет второго и третьего года
for i in range(len(second_year_table)):
    for j in range(len(second_year_table)):
        if j > i:
            second_year_table[i][j] = second_year_table[i][i]
        else:
            sold_1 = order[i] - demand[j]
            sold_10 = order[i] - sold_1
            second_year_table[i][j] = sold_1 * 1_000 + sold_10 * 10_000
        laplas_2_year[i] += second_year_table[i][j] * prob_2_year[j]

print("\n\n2 год:")
# распечатка таблицы
for name in range(9):
    print(f"{15 * '-'}", end='|')
else:
    print()
print(f"{'спрос/заказ':^15s}", end='|')
for name in demand:
    print(f"{name:^15_.0f}", end='|')
else:
    print(f"{'Байес-Лаплас':^15}", end='|')
    print()

for name in range(9):
    print(f"{15 * '-'}", end='|')
else:
    print()

for row, laplas, idx in zip(second_year_table, laplas_2_year, range(7)):
    print(f"{demand[idx]:^15_.0f}", end='|')
    for cell in row:
        print(f"{cell:^15_.0f}", end='|')
    print(f"{laplas:^15_.2f}", end='|')
    print()
for name in range(9):
    print(f"{15 * '-'}", end='|')
else:
    print()

# рассчет прибыли
profit = 0
for i in range(len(r)):
    for j in range(i+1):
        r[i] += prob_1_year[j] * laplas_2_year[j]
    r[i] += laplas_1_year[i]

# распечатка
print('\n\n\n\n')
print(f"{'Заказ':^15s}", end='|')
for name in demand:
    print(f"{name:^15_.0f}", end='|')
else:
    print()

for name in range(8):
    print(f"{15 * '-'}", end='|')
else:
    print()

print(f"{'Прибыль':^15s}", end='|')
for cell in r:
    print(f"{cell:^15_.0f}", end='|')
