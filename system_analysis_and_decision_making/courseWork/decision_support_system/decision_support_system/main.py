import asyncio

from decision_support_system.core import (
    Reader,
    Writer,
    calculate_binary_relations,
    calculate_summary
)
from decision_support_system.core.mechanisms import (
    calculate_k_max_options,
    calculate_k_max_results_by_variant,
    calculate_dominance,
    calculate_dominance_results_by_variant,
    calculate_lock,
    calculate_lock_results_by_variant,
    calculate_tournament,
    calculate_tournament_results_by_variant
)


async def runner():
    files_reader = Reader()

    # MAIN TEST DATA
    df = files_reader(
        matrix_row_names_path="./decision_support_system/input_data/test_data/preference_names_for_matrix_rows.csv",
        matrix_path="./decision_support_system/input_data/test_data/matrix.csv",
        choice_function_path="./decision_support_system/input_data/test_data/choice_function.csv",
        weight_coefficients_path="./decision_support_system/input_data/test_data/weight_coefficients.csv"
    )

    # ORIGINAL RESEARCH DATA
    # df = files_reader(
    #     matrix_row_names_path="./decision_support_system/input_data/my_data_for_course_work/preference_names_for_matrix_rows.csv",
    #     matrix_path="./decision_support_system/input_data/my_data_for_course_work/matrix.csv",
    #     choice_function_path="./decision_support_system/input_data/my_data_for_course_work/choice_function.csv",
    #     weight_coefficients_path="./decision_support_system/input_data/my_data_for_course_work/weight_coefficients.csv"
    # )

    # MODIFIED RESEARCH DATA: EQUAL WEIGHT COEFFICIENTS
    # df = files_reader(
    #     matrix_row_names_path="./decision_support_system/input_data/research/without_coef/preference_names_for_matrix_rows.csv",
    #     matrix_path="./decision_support_system/input_data/research/without_coef/matrix.csv",
    #     choice_function_path="./decision_support_system/input_data/research/without_coef/choice_function.csv",
    #     weight_coefficients_path="./decision_support_system/input_data/research/without_coef/weight_coefficients.csv"
    # )

    # MODIFIED RESEARCH DATA: DELETE MOST VALUED PREFERENCES AND LEADERS FROM ORIGINAL RESEARCH
    # df = files_reader(
    #     matrix_row_names_path="./decision_support_system/input_data/research/without_leaders/preference_names_for_matrix_rows.csv",
    #     matrix_path="./decision_support_system/input_data/research/without_leaders/matrix.csv",
    #     choice_function_path="./decision_support_system/input_data/research/without_leaders/choice_function.csv",
    #     weight_coefficients_path="./decision_support_system/input_data/research/without_leaders/weight_coefficients.csv"
    # )

    df_binary = calculate_binary_relations(df)

    df_k_max = await calculate_k_max_options(df_binary)
    df_dominance = await calculate_dominance(df_binary)
    df_lock = await calculate_lock(df_binary)
    df_tournament = await calculate_tournament(df_binary)

    df_k_max_by_variant = await calculate_k_max_results_by_variant(df_k_max)
    df_dominance_by_variant = await calculate_dominance_results_by_variant(df_dominance)
    df_lock_by_variant = await calculate_lock_results_by_variant(df_lock)
    df_tournament_by_variant = await calculate_tournament_results_by_variant(df_tournament)

    df_summary = calculate_summary(
        df_dominance_by_variant,
        df_lock_by_variant,
        df_tournament_by_variant,
        df_k_max_by_variant
    )

    writer = Writer()
    writer(
        dir_to_save="./decision_support_system/output_data",
        raw_df=df,
        binary_rel_df=df_binary,
        dominance_df=df_dominance,
        dominance_df_by_variant=df_dominance_by_variant,
        lock_df=df_lock,
        lock_df_by_variant=df_lock_by_variant,
        tournament_df=df_tournament,
        tournament_df_by_variant=df_tournament_by_variant,
        k_max_df=df_k_max,
        k_max_df_by_variant=df_k_max_by_variant,
        summary_df=df_summary
    )


def main():
    asyncio.run(runner())
