from dataclasses import dataclass
from typing import List

import numpy as np
import pandas as pd


@dataclass
class RawData:
    matrix_row_names: List[str]
    matrix: pd.DataFrame
    choice_function: np.ndarray
    weight_coefficients: np.ndarray