from dataclasses import dataclass
from typing import Dict, List, Any
from prettytable import PrettyTable
from itertools import chain


@dataclass
class TournamentModel:
    """
    модель данных для турнирного механизма
    """
    preference: str
    tournament_matrix: List[float]
    variant_names: List[str]
    variants_count: int

    def __str__(self):
        table = PrettyTable()
        table.field_names = [f"Турнирный механизм для {self.preference}", "Баллы"]
        for variant, weight in zip(self.variant_names, self.tournament_matrix):
            table.add_row([
                variant,
                round(weight, 3)
            ])
        return str(table)


@dataclass
class TournamentModels:
    """
    модель данных для модели турнирного механизма по каждому из предпочтений
    """
    tournament_by_preference: Dict[str, TournamentModel]
    variant_names: List[str]
    variants_count: int
    preference_names: List[str]
    preference_count: int

    def __str__(self):
        tables = []
        for model in self.tournament_by_preference.values():
            tables.append(str(model))
        return "\n".join(tables)
