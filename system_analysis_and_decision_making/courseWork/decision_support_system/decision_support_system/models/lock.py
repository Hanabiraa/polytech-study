from dataclasses import dataclass
from typing import Dict, List, Any

from prettytable import PrettyTable


@dataclass
class LockModel:
    """
    модель данных для механизма блокирования
    """
    preference: str
    lock_matrix: List[int]
    variant_names: List[str]
    variants_count: int
    weight_coefficient: float

    def __str__(self):
        table = PrettyTable()
        table.field_names = [f"Блокирующий механизм", "Блокирует ли вариант?"]
        for idx, variant in enumerate(self.variant_names):
            table.add_row([
                variant,
                "да" if idx in self.lock_matrix else "нет"
            ])
        return str(table)


@dataclass
class LockModels:
    """
    модель данных для модели механизма блокирования по каждому из предпочтений
    """
    lock_by_preference: Dict[str, LockModel]
    variant_names: List[str]
    variants_count: int
    preference_names: List[str]
    preference_count: int

    def __str__(self):
        tables = []
        for model in self.lock_by_preference.values():
            tables.append(str(model))
        return "\n".join(tables)

@dataclass
class LockMechanismResultsModel:
    """
    модель результатов для каждого из варианта по механизму блокирования
    """
    lock_by_variant: Dict[str, List[Any]]

    def __str__(self):
        table = PrettyTable()
        table.field_names = [
            "Механизм блокирования. Вариант",
            "Баллы",
            "Место"
        ]
        for variant in sorted(
                self.lock_by_variant.keys(),
                key=lambda variant: self.lock_by_variant[variant][1],
                reverse=False
        ):
            table.add_row([
                variant,
                round(self.lock_by_variant[variant][0], 2),
                *self.lock_by_variant[variant][1:],
            ])
        return str(table)
