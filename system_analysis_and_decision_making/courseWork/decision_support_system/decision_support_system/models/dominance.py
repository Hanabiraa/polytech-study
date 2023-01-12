from dataclasses import dataclass
from typing import Dict, List, Any
from prettytable import PrettyTable
from itertools import chain


@dataclass
class DominanceModel:
    """
    модель данных для механизма доминирования
    """
    preference: str
    dominance_matrix: List[int]
    variant_names: List[str]
    variants_count: int

    def __str__(self):
        table = PrettyTable()
        table.field_names = [f"Доминирующий механизм для {self.preference}", "Доминирует ли вариант?"]
        for idx, variant in enumerate(self.variant_names):
            table.add_row([
                variant,
                "да" if idx in self.dominance_matrix else "нет"
            ])
        return str(table)


@dataclass
class DominanceModels:
    """
    модель данных для модели механизма доминирования по каждому из предпочтений
    """
    dominance_by_preference: Dict[str, DominanceModel]
    variant_names: List[str]
    variants_count: int
    preference_names: List[str]
    preference_count: int

    def __str__(self):
        tables = []
        for model in self.dominance_by_preference.values():
            tables.append(str(model))
        return "\n".join(tables)
