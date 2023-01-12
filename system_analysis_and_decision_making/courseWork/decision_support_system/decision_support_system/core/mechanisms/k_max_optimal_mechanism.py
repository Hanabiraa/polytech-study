from copy import deepcopy

from decision_support_system.models import KMaxModels


async def calculate_k_max_optimal_options(df: KMaxModels) -> KMaxModels:
    """
    проверка оптимальности k-max вариантов
    :param df:
    :return:
    """
    copy_df = deepcopy(df)
    for preference, model in df.k_max_matrix_by_preference.items():
        optimal_check_vector = [-1 for _ in range(df.variants_count)]
        for i in range(df.variants_count):
            for j in range(4):
                match j:
                    case 0:
                        if model.k_max_matrix[i][j] == df.variants_count:
                            optimal_check_vector[i] = 1
                    case 1:
                        if (
                                model.k_max_matrix[i][j] == (df.variants_count - 1) and
                                model.k_max_matrix[i][j] > model.k_max_matrix[i][j + 2]
                        ):
                            optimal_check_vector[i] = 2
                    case 2:
                        if (
                                model.k_max_matrix[i][j] == df.variants_count and
                                model.k_max_matrix[i][j] > model.k_max_matrix[i][j + 1]):
                            optimal_check_vector[i] = 3
                    case 3:
                        if (
                                (model.k_max_matrix[i][j] == (df.variants_count - 1)) and
                                (model.k_max_matrix[i][j] == model.k_max_matrix[i][j - 1]) and
                                (model.k_max_matrix[i][j] == model.k_max_matrix[i][j - 2])
                        ):
                            optimal_check_vector[i] = 4
                    case _:
                        optimal_check_vector[i] = 0
        copy_df.k_max_matrix_by_preference[preference].k_max_optimal_check = optimal_check_vector
    return copy_df
