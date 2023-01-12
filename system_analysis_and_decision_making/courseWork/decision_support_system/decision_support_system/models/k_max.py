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
    weight_coefficient: float

    def __str__(self):
        table = PrettyTable()
        table.field_names = ["K-max механизм", "HR0 + ER + NK", "HR0 + NK", "HR0 + ER", "HR0", "оптимальность"]

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
    variant_names: List[str]
    variants_count: int

    def __str__(self):
        tables = []
        for model in self.k_max_matrix_by_preference.values():
            tables.append(str(model))
        return "\n".join(tables)


@dataclass
class KMaxMechanismResultsModel:
    """
    модель результатов для каждого из варианта по механизму k-max с учетом
    весовых коэффициентов и оптимальности
    """
    rating_and_place_by_variant: Dict[str, List[Any]]
    rating_and_place_by_variant_with_optimal: Dict[str, List[Any]]

    def __str__(self):
        table = PrettyTable()
        table.field_names = [
            "Механизм K-max. Вариант",
            "Баллы без учета оптимальности",
            "Место без учета",
            "Баллы с учетом оптимальности",
            "Место с учетом"
        ]
        for variant in sorted(
                self.rating_and_place_by_variant.keys(),
                key=lambda variant: self.rating_and_place_by_variant_with_optimal[variant][1],
                reverse=False
        ):
            table.add_row([
                variant,
                round(self.rating_and_place_by_variant[variant][0], 2),
                *self.rating_and_place_by_variant[variant][1:],
                round(self.rating_and_place_by_variant_with_optimal[variant][0], 2),
                *self.rating_and_place_by_variant_with_optimal[variant][1:],
            ])
        return str(table)
