from dataclasses import dataclass
from typing import Dict, List, Any

from prettytable import PrettyTable


@dataclass
class SummaryModel:
    """
    модель балльной системы
    """
    summary_rating_by_variant: Dict[str, List[Any]]

    def __str__(self):
        table = PrettyTable()
        table.field_names = [
            "Вариант",
            "Механизм доминирования",
            "Механизм блокирования",
            "Механизм турнирный",
            "Механизм K-max, Sjp",
            "Механизм K-max, SjM",
            "Сумма баллов"
        ]
        for variant_name, ratings in sorted(
                self.summary_rating_by_variant.items(),
                key=lambda item: sum(item[1]),
                reverse=True
        ):
            table.add_row([variant_name, *ratings, sum(ratings)])
        return str(table)
