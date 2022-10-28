import pprint
from copy import deepcopy

matrix = [
    [15, 10, 0, -6, 17],
    [3, 14, 8, 9, 2],
    [1, 5, 14, 20, -3],
    [7, 19, 10, 2, 0]
]

# Минимаксный критерий
print(f'---Вариант решения по MM (минимаксный критерий)---')
e = list()  # множество E вариантов
for idx, str in enumerate(matrix, start=1):
    e.append([min(str), idx])
print('\tмножество E вариантов:')
for el, idx in e:
    print(f'\t{el:+3.0f}')
print(f'\tОптимальная стратегия: X{max(e, key=lambda x: x[0])[1]},\n\tзначение MM: {max(e, key=lambda x: x[0])[0]}',
      end='\n\n')


# критерий Севиджа S
print(f'---Вариант решения по критерию Севиджа S---')
Z = deepcopy(matrix)  # матрица потерь
Z_col = list()
for i in range(len(Z[0])):
    col = [row[i] for row in Z]
    Z_col.append(col)

for col in Z_col:
    max_el = max(col)
    for i in range(len(col)):
        col[i] = max_el - col[i]

print('\tМатрица потерь:')
for i in range(len(Z_col[0])):
    print('\t', end='')
    for j in range(len(Z_col)):
        print(f'{Z_col[j][i]:2.0f}', end=' ')
    print()

for i in range(len(Z_col[0])):
    for j in range(len(Z_col)):
        Z[i][j] = Z_col[j][i]

e = [[max(str), idx] for idx, str in enumerate(Z, start=1)] # матрица наибольших разностей
print('\tМатрица наибольших разностей:')
for el in e:
    print(f'\t{el[0]}')

print(f'\tОптимальная стратегия: X{min(e)[1]}\n\tзначение критерия Севиджа S: {min(e)[0]}', end='\n\n')

# Критерий Гурвица с C=0.7
print(f'---Вариант решения по критерию Гурвица (HW), где C=0.7---')
C = 0.7

arr_str = deepcopy(matrix)
arr_col = list()
for i in range(len(arr_str[0])):
    col = [row[i] for row in arr_str]
    arr_col.append(col)

e = [
    [C * min(col) + (1 - C) * max(col), idx] for idx, col in enumerate(arr_str, start=1)
]
print('\tМатрица значений:')
for el, idx in e:
    print(f'\t{el:.2f}')
print(f'\tОптимальная стратегия: X{max(e, key=lambda x: x[0])[1]},\n\tзначение HW: {max(e, key=lambda x: x[0])[0]:.2f}')
