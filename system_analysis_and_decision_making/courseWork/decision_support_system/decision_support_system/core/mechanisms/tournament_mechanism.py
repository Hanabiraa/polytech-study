from decision_support_system.models import BinaryRelationModels, TournamentModel, TournamentModels, \
    TournamentMechanismResultsModel


async def calculate_tournament(df: BinaryRelationModels) -> TournamentModels:
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
            df.variants_count,
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


async def calculate_tournament_results_by_variant(df: TournamentModels) -> TournamentMechanismResultsModel:
    tournament_mechanism = TournamentMechanismResultsModel({})
    for variant in df.variant_names:
        """
        0 индекс в списке - количество баллов с учетом всего
        1 индекс в списке - место в общем зачете
        """
        tournament_mechanism.tournament_by_variant[variant] = [0, -1]

    for preference, model in df.tournament_by_preference.items():
        for variant_name, variant_value in zip(df.variant_names, model.tournament_matrix):
            tournament_mechanism.tournament_by_variant[variant_name][0] += variant_value

    # подсчет места для каждого из вариантов
    sorted_variants = sorted(tournament_mechanism.tournament_by_variant.items(),
                             key=lambda x: x[1][0],
                             reverse=True
                             )
    place = 1
    for idx, variant in enumerate(sorted_variants):
        if idx == 0:
            tournament_mechanism.tournament_by_variant[variant[0]][1] = place
            place += 1
            continue

        if sorted_variants[idx - 1][1][0] != variant[1][0]:
            tournament_mechanism.tournament_by_variant[variant[0]][1] = place
            place += 1
        else:
            tournament_mechanism.tournament_by_variant[variant[0]][1] = place - 1

    return tournament_mechanism
