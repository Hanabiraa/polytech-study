import numpy as np

from decision_support_system.models import BinaryRelationModels, KMaxModels, KMaxModel
from decision_support_system.core.mechanisms.k_max_optimal_mechanism import calculate_k_max_optimal_options


def calculate_k_max_options(df: BinaryRelationModels) -> KMaxModels:
    """
    Расчет вариантов k-max механизма и последующий расчет k-max оптимальных вариантов
    """
    k_max_models = KMaxModels({}, df.variants_count)
    for preference, model in df.binary_relation_by_preference.items():
        variant_vector = [[0 for _ in range(4)] for _ in range(model.variants_count)]
        for i in range(model.variants_count):
            HR0, ER, NK = 0, 0, 0
            for j in range(model.variants_count):
                if i == j:
                    continue
                if model.binary_relation_matrix[i][j] == 1:
                    HR0 += 1 if model.binary_relation_matrix[j][i] == 0 else 0
                    ER += 1 if model.binary_relation_matrix[j][i] == 1 else 0
                elif model.binary_relation_matrix[i][j] == -1:
                    NK += 1

            variant_vector[i][0] = HR0 + ER + NK
            variant_vector[i][1] = HR0 + NK
            variant_vector[i][2] = HR0 + ER
            variant_vector[i][3] = HR0
        k_max_model = KMaxModel(preference, variant_vector, [], df.variant_names)
        k_max_models.k_max_matrix_by_preference[preference] = k_max_model
    return calculate_k_max_optimal_options(k_max_models)
