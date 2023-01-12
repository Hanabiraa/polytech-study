from dataclasses import dataclass
from itertools import chain
from typing import List, Any

from prettytable import PrettyTable


@dataclass
class RawDataframeModel:
    """
    Модель данных для сырых, необработанных данных
    """
    matrix_col_names: List[str]
    matrix_row_names: List[str]
    matrix: List[List[Any]]
    choice_function: List[bool]
    weight_coefficients: List[float]

    def __str__(self) -> str:
        table = PrettyTable()
        table.field_names = list(
            chain(["предпочтения", *self.matrix_col_names, "функция выбора", "весовые коэффициенты"]))
        table.align["предпочтения"] = "r"
        for matrix_row_name, matrix_row, choice, weight in zip(self.matrix_row_names, self.matrix, self.choice_function,
                                                               self.weight_coefficients):
            table.add_row(list(chain(
                [
                    matrix_row_name,
                    *matrix_row,
                    "Большее преобладает" if choice else "Меньшее преобладает",
                    weight
                ])))
        return str(table)
