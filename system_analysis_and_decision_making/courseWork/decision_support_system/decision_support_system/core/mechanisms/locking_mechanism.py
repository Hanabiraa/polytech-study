from decision_support_system.models import BinaryRelationModels, LockModel, LockModels

def calculate_lock(df: BinaryRelationModels) -> LockModels:
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
            df.variants_count
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