from dataclasses import dataclass
from typing import Dict, List, Any

from prettytable import PrettyTable


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
        table.field_names = [f"Турнирный механизм", "Баллы"]
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


@dataclass
class TournamentMechanismResultsModel:
    """
        модель результатов для каждого из варианта по турнирному механизму
    """
    tournament_by_variant: Dict[str, List[Any]]

    def __str__(self):
        table = PrettyTable()
        table.field_names = [
            "Механизм турнирный. Вариант",
            "Баллы",
            "Место"
        ]
        for variant in sorted(
                self.tournament_by_variant.keys(),
                key= lambda variant: self.tournament_by_variant[variant][1],
                reverse = False
        ):
            table.add_row([
                variant,
                round(self.tournament_by_variant[variant][0], 2),
                *self.tournament_by_variant[variant][1:],
            ])
        return str(table)
