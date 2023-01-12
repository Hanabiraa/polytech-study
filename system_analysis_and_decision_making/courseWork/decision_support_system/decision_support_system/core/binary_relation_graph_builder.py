from decision_support_system.models import RawDataframeModel, BinaryRelationModel, BinaryRelationModels


def calculate_binary_relations(df: RawDataframeModel) -> BinaryRelationModels:
    """
    Подсчет бинарных отношений для каждого предпочтения
    """
    variants_count = len(df.matrix_col_names)
    preferences_count = len(df.matrix_row_names)
    binary_relation_models = BinaryRelationModels(
        {},
        df.matrix_col_names,
        variants_count,
        df.matrix_row_names,
        preferences_count
    )
    for row_idx, row, weight_coefficient in zip(range(len(df.matrix)), df.matrix, df.weight_coefficients):
        binary_relation = [[0 for _ in range(variants_count)] for _ in range(variants_count)]  # 2d list
        for i in range(variants_count):
            for j in range(variants_count):
                if i == j:
                    binary_relation[i][j] = -1
                elif not df.choice_function[row_idx] and row[i] <= row[j]:
                    binary_relation[i][j] = 1
                elif df.choice_function[row_idx] and row[i] >= row[j]:
                    binary_relation[i][j] = 1
        binary_relation_model = BinaryRelationModel(
            df.matrix_row_names[row_idx],
            binary_relation,
            df.matrix_col_names,
            variants_count,
            weight_coefficient
        )
        binary_relation_models.binary_relation_by_preference[binary_relation_model.preference] = binary_relation_model
    return binary_relation_models
