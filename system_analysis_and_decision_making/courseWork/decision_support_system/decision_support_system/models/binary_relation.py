from dataclasses import dataclass
from typing import Dict, List, Any

from prettytable import PrettyTable


@dataclass
class BinaryRelationModel:
    """
    модель данных для бинарных отношений
    """
    preference: str
    binary_relation_matrix: List[List[Any]]
    variant_names: List[str]
    variants_count: int
    weight_coefficient: float

    def __str__(self):
        table = PrettyTable()
        table.field_names = [self.preference] + self.variant_names
        for variant, row in zip(self.variant_names, self.binary_relation_matrix):
            table.add_row([variant] + row)
        return str(table)


@dataclass
class BinaryRelationModels:
    """
    модель данных для модели бинарных отношений по каждому предпочтению
    """
    binary_relation_by_preference: Dict[str, BinaryRelationModel]
    variant_names: List[str]
    variants_count: int
    preference_names: List[str]
    preference_count: int

    def __str__(self):
        tables = []
        for model in self.binary_relation_by_preference.values():
            tables.append(str(model))
        return "\n".join(tables)
