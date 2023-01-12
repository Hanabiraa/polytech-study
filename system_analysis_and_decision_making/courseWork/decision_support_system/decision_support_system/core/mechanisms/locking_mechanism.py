from decision_support_system.models import BinaryRelationModels, LockModel, LockModels, LockMechanismResultsModel


async def calculate_lock(df: BinaryRelationModels) -> LockModels:
    lock_models = LockModels(
        {},
        df.variant_names,
        df.variants_count,
        df.preference_names,
        df.preference_count
    )
    for preference, model in df.binary_relation_by_preference.items():
        lock_model = LockModel(
            preference,
            [],
            df.variant_names,
            df.variants_count,
            model.weight_coefficient
        )
        for i in range(model.variants_count):
            flag = True
            for j in range(model.variants_count):
                if i != j and model.binary_relation_matrix[j][i] != 0:
                    flag = False
                    break
            if flag:
                lock_model.lock_matrix.append(i)
        lock_models.lock_by_preference[preference] = lock_model
    return lock_models


async def calculate_lock_results_by_variant(df: LockModels) -> LockMechanismResultsModel:
    lock_mechanism = LockMechanismResultsModel({})
    for variant in df.variant_names:
        """
        0 индекс в списке - количество баллов с учетом всего
        1 индекс в списке - место в общем зачете
        """
        lock_mechanism.lock_by_variant[variant] = [0, -1]

    for preference, model in df.lock_by_preference.items():
        for lock_variant_idx in model.lock_matrix:
            lock_mechanism.lock_by_variant[
                model.variant_names[lock_variant_idx]
            ][0] += model.weight_coefficient

    # подсчет места для каждого из вариантов
    sorted_variants = sorted(lock_mechanism.lock_by_variant.items(),
                             key=lambda x: x[1][0],
                             reverse=True
                             )
    place = 1
    for idx, variant in enumerate(sorted_variants):
        if idx == 0:
            lock_mechanism.lock_by_variant[variant[0]][1] = place
            place += 1
            continue

        if sorted_variants[idx - 1][1][0] != variant[1][0]:
            lock_mechanism.lock_by_variant[variant[0]][1] = place
            place += 1
        else:
            lock_mechanism.lock_by_variant[variant[0]][1] = place - 1

    return lock_mechanism
