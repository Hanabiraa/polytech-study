from typing import List, Any
from ..models.raw_data import RawDataframeModel
import csv

class Reader:
    """
    Класс для чтения всех данных из директории input_data и создания датакласса
    """

    def __init__(self):
        pass

    def __call__(
            self,
            *,
            matrix_row_names_path: str,
            matrix_path: str,
            choice_function_path: str,
            weight_coefficients_path: str
    ) -> RawDataframeModel:
        df = RawDataframeModel(
            matrix_col_names=self.__read_matrix_column_names(matrix_path),
            matrix_row_names=self.__read_matrix_row_names(matrix_row_names_path),
            matrix=self.__read_matrix(matrix_path),
            choice_function=self.__read_choice_function(choice_function_path),
            weight_coefficients=self.__read_weight_coefficients(weight_coefficients_path)
        )
        return df

    @staticmethod
    def __read_matrix_column_names(path: str) -> List[str]:
        with open(path) as f:
            return next(csv.reader(f))

    @staticmethod
    def __read_matrix_row_names(path: str) -> List[str]:
        with open(path) as f:
            return [
                row[0]
                for row in csv.reader(f)
            ]

    @staticmethod
    def __read_matrix(path: str) -> List[List[Any]]:
        with open(path) as f:
            csv_iter = csv.reader(f)
            next(csv_iter)
            return [
                list(map(float, row))
                for row in csv_iter
            ]

    @staticmethod
    def __read_choice_function(path: str) -> List[bool]:
        with open(path) as f:
            return [
                False if row[0] == "0" else True
                for row in csv.reader(f)
            ]

    @staticmethod
    def __read_weight_coefficients(path: str) -> List[float]:
        with open(path) as f:
            return [
                float(row[0])
                for row in csv.reader(f)
            ]
