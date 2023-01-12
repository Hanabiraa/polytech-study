from dataclasses import dataclass
from typing import Dict, List, Any
from prettytable import PrettyTable
from itertools import chain


@dataclass
class LockModel:
    """
    модель данных для механизма блокирования
    """
    preference: str
    lock_matrix: List[int]
    variant_names: List[str]
    variants_count: int

    def __str__(self):
        table = PrettyTable()
        table.field_names = [f"Блокирующий механизм для {self.preference}", "Блокирует ли вариант?"]
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