from decision_support_system.models import BinaryRelationModels, TournamentModel, TournamentModels


def calculate_tournament(df: BinaryRelationModels) -> TournamentModels:
    tournament_models = TournamentModels(
        {},
        df.variant_names,
        df.variants_count,
        df.preference_names,
        df.preference_count
    )
    for preference, model in df.binary_relation_by_preference.items():
        tournament_model = TournamentModel(
            preference,
            [],
            df.variant_names,
            df.variants_count
        )
        for i in range(model.variants_count):
            sum = 0
            for j in range(model.variants_count):
                if i == j:
                    continue
                if model.binary_relation_matrix[i][j] == 1:
                    if model.binary_relation_matrix[j][i] == 0:
                        sum += model.weight_coefficient
                    elif model.binary_relation_matrix[j][i] == 1:
                        sum += model.weight_coefficient / 2
            tournament_model.tournament_matrix.append(sum)
        tournament_models.tournament_by_preference[preference] = tournament_model
    return tournament_models
