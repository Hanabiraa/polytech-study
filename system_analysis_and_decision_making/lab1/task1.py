matrix = [
    [15, 10, 0, -6, 17],
    [3, 14, 8, 9, 2],
    [1, 5, 14, 20, -3],
    [7, 19, 10, 2, 0]
]


# Минимаксный критерий
e = list() # множество E вариантов
for idx, str in enumerate(matrix, start=1):
    e.append([min(str), idx])

print(f'Вариант решение по MM (минимаксный критерий): X{max(e, key=lambda x: x[0])[1]}, значение: {max(e, key=lambda x: x[0])[0]}')

# критерий Севиджа S
Z = list() # матрица потерь

for i in range(len(matrix[0])):
    col = [row[i] for row in matrix]
    max_el = max(col)
    Z.append(list(map(lambda x: x - max_el, col)))

Z_mod = list() # матрица потерь в виде хранения строками
for i in range(len(matrix)):
    str = [row[i] for row in Z]
    Z_mod.append(str)


print(Z_mod)
e = [[max(str), idx] for idx, str in enumerate(Z_mod, start=1)] # столбец наибольших разностей
print(f'Вариант регшения по критерию Севиджа S = X{min(e)[1]}, {min(e)[0]}')