from decision_support_system.models import BinaryRelationModels, DominanceModel, DominanceModels

def calculate_dominance(df: BinaryRelationModels) -> DominanceModels:
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
            df.variants_count
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

