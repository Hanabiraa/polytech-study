from decision_support_system.models import BinaryRelationModels, DominanceModel, DominanceModels, \
    DominanceMechanismResultsModel


async def calculate_dominance(df: BinaryRelationModels) -> DominanceModels:
    dominance_models = DominanceModels(
        {},
        df.variant_names,
        df.variants_count,
        df.preference_names,
        df.preference_count
    )
    for preference, model in df.binary_relation_by_preference.items():
        dominance_model = DominanceModel(
            preference,
            [],
            df.variant_names,
            df.variants_count,
            model.weight_coefficient
        )
        for i in range(model.variants_count):
            flag = True
            for j in range(model.variants_count):
                if i != j and model.binary_relation_matrix[i][j] != 1:
                    flag = False
                    break
            if flag:
                dominance_model.dominance_matrix.append(i)
        dominance_models.dominance_by_preference[preference] = dominance_model
    return dominance_models


async def calculate_dominance_results_by_variant(df: DominanceModels) -> DominanceMechanismResultsModel:
    dominance_mechanism = DominanceMechanismResultsModel({})
    for variant in df.variant_names:
        """
        0 индекс в списке - количество баллов с учетом всего
        1 индекс в списке - место в общем зачете
        """
        dominance_mechanism.dominance_by_variant[variant] = [0, -1]

    for preference, model in df.dominance_by_preference.items():
        for dominance_variant_idx in model.dominance_matrix:
            dominance_mechanism.dominance_by_variant[
                model.variant_names[dominance_variant_idx]
            ][0] += model.weight_coefficient

    # подсчет места для каждого из вариантов
    sorted_variants = sorted(dominance_mechanism.dominance_by_variant.items(),
                             key=lambda x: x[1][0],
                             reverse=True
                             )
    place = 1
    for idx, variant in enumerate(sorted_variants):
        if idx == 0:
            dominance_mechanism.dominance_by_variant[variant[0]][1] = place
            place += 1
            continue

        if sorted_variants[idx - 1][1][0] != variant[1][0]:
            dominance_mechanism.dominance_by_variant[variant[0]][1] = place
            place += 1
        else:
            dominance_mechanism.dominance_by_variant[variant[0]][1] = place - 1

    return dominance_mechanism
