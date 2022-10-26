import numpy as np
import pprint

prob = [0.25, 0.25, 0.35, 0.1, 0.05]
money = []

for order in [100, 150, 200, 250, 300]:
    row = []
    for demand in [100, 150, 200, 250, 300]:
        if (bad := (order - demand)) <= 0:
            row.append(order * 49 - order * 25)
        else:
            row.append(demand * 49 + bad * 15 - order * 25)
    money.append(row)

print('Матрица решений: ')
pprint.pprint(money)

e = []
for idx, row in enumerate(money):
    acc = 0
    for i in range(len(prob)):
        acc += row[i] * prob[i]
    e.append([acc, idx])

print('Мат. ожидания:')
for el, idx in e:
    print(el)

print(f'Оптимальное число закупое: {[100, 150, 200, 250, 300][max(e, key=lambda x: x[0])[1]]},\nНаибольшее мат. ожидание: {max(e, key=lambda x: x[0])[0]:.2f}')
