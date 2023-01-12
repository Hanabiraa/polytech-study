from decision_support_system.core.mechanisms.k_max_optimal_mechanism import calculate_k_max_optimal_options
from decision_support_system.models import BinaryRelationModels, KMaxModels, KMaxModel, KMaxMechanismResultsModel


async def calculate_k_max_options(df: BinaryRelationModels) -> KMaxModels:
    """
    Расчет вариантов k-max механизма и последующий расчет k-max оптимальных вариантов
    """
    k_max_models = KMaxModels({}, df.variant_names, df.variants_count)
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
        k_max_model = KMaxModel(
            preference,
            variant_vector,
            [],
            df.variant_names,
            model.weight_coefficient
        )
        k_max_models.k_max_matrix_by_preference[preference] = k_max_model

    df = await calculate_k_max_optimal_options(k_max_models)
    return df


async def calculate_k_max_results_by_variant(df: KMaxModels) -> KMaxMechanismResultsModel:
    k_max_mechanism = KMaxMechanismResultsModel({}, {})
    for variant in df.variant_names:
        """
        0 индекс в списке - количество баллов с учетом всего
        1 индекс в списке - место в общем зачете
        """
        k_max_mechanism.rating_and_place_by_variant[variant] = [0, -1]
        k_max_mechanism.rating_and_place_by_variant_with_optimal[variant] = [0, -1]

    for preference, model in df.k_max_matrix_by_preference.items():
        for (variant_name, variant_values, k_max_optimal_check) in zip(model.variant_names,
                                                                       model.k_max_matrix,
                                                                       model.k_max_optimal_check):
            k_max_mechanism.rating_and_place_by_variant[variant_name][0] += sum(
                map(lambda x: x * model.weight_coefficient, variant_values)
            )

            if k_max_optimal_check in [1, 2, 3, 4]:
                k_max_mechanism.rating_and_place_by_variant_with_optimal[variant_name][0] += sum(
                    map(lambda x: x * model.weight_coefficient, variant_values)
                )

    # подсчет места для k_max без оптимального
    sorted_variants = sorted(k_max_mechanism.rating_and_place_by_variant.items(),
                             key=lambda x: x[1][0],
                             reverse=True
                             )
    place = 1
    for idx, variant in enumerate(sorted_variants):
        if idx == 0:
            k_max_mechanism.rating_and_place_by_variant[variant[0]][1] = place
            place += 1
            continue

        if sorted_variants[idx - 1][1][0] != variant[1][0]:
            k_max_mechanism.rating_and_place_by_variant[variant[0]][1] = place
            place += 1
        else:
            k_max_mechanism.rating_and_place_by_variant[variant[0]][1] = place - 1

    # подсчет места для k_max с оптимальным
    sorted_variants = sorted(k_max_mechanism.rating_and_place_by_variant_with_optimal.items(),
                             key=lambda x: x[1][0],
                             reverse=True
                             )
    place = 1
    for idx, variant in enumerate(sorted_variants):
        if idx == 0:
            k_max_mechanism.rating_and_place_by_variant_with_optimal[variant[0]][1] = place
            place += 1
            continue
        if sorted_variants[idx - 1][1][0] != variant[1][0]:
            k_max_mechanism.rating_and_place_by_variant_with_optimal[variant[0]][1] = place
            place += 1
        else:
            k_max_mechanism.rating_and_place_by_variant_with_optimal[variant[0]][1] = place - 1
    return k_max_mechanism
