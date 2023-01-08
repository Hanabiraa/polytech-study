from .core.read_data import (
    Reader
)

def main():
    files_reader = Reader()
    dataframe = files_reader(
        matrix_row_names_path="./decision_support_system/input_data/feature_names_for_matrix_rows.csv",
        matrix_path="./decision_support_system/input_data/matrix.csv",
        choice_function_path="./decision_support_system/input_data/choice_function.csv",
        weight_coefficients_path="./decision_support_system/input_data/weight_coefficients.csv"
    )

    """
    kmax - к-макс механизм по суммам Sjp для всех вариантов
    kopt - к-макс механизм по суммам SjM для оптимальных вариантов
    """


