from .core.read_data import (
    Reader
)
from decision_support_system.core.mechanisms import (
    calculate_binary_relations,
    calculate_k_max_options,
    calculate_k_max_rating,
    calculate_dominance,
    calculate_lock,
    calculate_tournament
)


def main():
    files_reader = Reader()
    df = files_reader(
        matrix_row_names_path="./decision_support_system/input_data/feature_names_for_matrix_rows.csv",
        matrix_path="./decision_support_system/input_data/matrix.csv",
        choice_function_path="./decision_support_system/input_data/choice_function.csv",
        weight_coefficients_path="./decision_support_system/input_data/weight_coefficients.csv"
    )
    print(df)
    df_binary = calculate_binary_relations(df)
    print(df_binary)
    df_k_max = calculate_k_max_options(df_binary)
    print(df_k_max)
    df_dominance = calculate_dominance(df_binary)
    print(df_dominance)
    df_lock = calculate_lock(df_binary)
    print(df_lock)
    df_tournament = calculate_tournament(df_binary)
    print(df_tournament)

    df_rate = calculate_k_max_rating(df_k_max)
    print(df_rate)