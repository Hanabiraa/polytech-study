from typing import List
from ..models.raw_data import RawData
import numpy as np
import pandas as pd
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
    ) -> RawData:
        datacls = RawData(
            matrix_row_names=self.__read_matrix_row_names(matrix_row_names_path),
            matrix=self.__read_matrix(matrix_path),
            choice_function=self.__read_choice_function(choice_function_path),
            weight_coefficients=self.__read_weight_coefficients(weight_coefficients_path)
        )
        return datacls

    @staticmethod
    def __read_matrix_row_names(path: str) -> List[str]:
        with open(path) as f:
            return [
                row[0]
                for row in csv.reader(f)
            ]

    @staticmethod
    def __read_matrix(path: str) -> pd.DataFrame:
        df = pd.read_csv(
            filepath_or_buffer=path,
            header=0
        )
        return df

    @staticmethod
    def __read_choice_function(path: str) -> np.ndarray:
        return np.genfromtxt(path, delimiter=',').astype(bool)

    @staticmethod
    def __read_weight_coefficients(path: str) -> np.ndarray:
        return np.genfromtxt(path, delimiter=',')
