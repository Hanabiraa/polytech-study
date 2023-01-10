from .core.read_data import (
    Reader
)
from decision_support_system.core.mechanisms.binary_relation_calc import calculate_binary_relations
from decision_support_system.core.mechanisms.k_max_mechanism import calculate_k_max_options
from decision_support_system.core.mechanisms.k_max_optimal_mechanism import calculate_k_max_optimal_options

def main():
    files_reader = Reader()
    df = files_reader(
        matrix_row_names_path="./decision_support_system/input_data/feature_names_for_matrix_rows.csv",
        matrix_path="./decision_support_system/input_data/matrix.csv",
        choice_function_path="./decision_support_system/input_data/choice_function.csv",
        weight_coefficients_path="./decision_support_system/input_data/weight_coefficients.csv"
    )
    print(df)
    df = calculate_binary_relations(df)
    print(df)
    df = calculate_k_max_options(df)
    print(df)


