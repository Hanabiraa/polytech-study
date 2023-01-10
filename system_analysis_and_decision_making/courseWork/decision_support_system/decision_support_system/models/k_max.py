from dataclasses import dataclass
from typing import Dict, List, Any
from prettytable import PrettyTable


@dataclass
class KMaxModel:
    """
    модель данных для k-max механизма вместе с проверкой на оптимальность k-max вариантов
    """
    preference: str
    k_max_matrix: List[List[Any]]
    k_max_optimal_check: List[int]
    variant_names: List[str]

    def __str__(self):
        table = PrettyTable()
        table.field_names = [self.preference, "HR0 + ER + NK", "HR0 + NK", "HR0 + ER", "HR0", "оптимальность"]

        for variant_name, row, optimal_check in zip(self.variant_names, self.k_max_matrix, self.k_max_optimal_check):
            optimal_check_str = "-"
            match optimal_check:
                case 1:
                    optimal_check_str = "максимальный"
                case 2:
                    optimal_check_str = "строго максимальный"
                case 3:
                    optimal_check_str = "наибольший"
                case 4:
                    optimal_check_str = "строго наибольший"
                case _:
                    ...
            table.add_row(
                [variant_name] + row + [optimal_check_str]
            )
        return str(table)


@dataclass
class KMaxModels:
    """
    модель данных для k-max моделей по каждому предпочтению
    """
    k_max_matrix_by_preference: Dict[str, KMaxModel]
    variants_count: int

    def __str__(self):
        tables = []
        for val in self.k_max_matrix_by_preference.values():
            tables.append(str(val))
        return "\n".join(tables)
