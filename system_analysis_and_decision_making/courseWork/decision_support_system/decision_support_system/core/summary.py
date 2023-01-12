from decision_support_system.models import (
    DominanceMechanismResultsModel,
    LockMechanismResultsModel,
    TournamentMechanismResultsModel,
    KMaxMechanismResultsModel,
    SummaryModel
)


def calculate_summary(
        dominance_mechanism: DominanceMechanismResultsModel,
        lock_mechanism: LockMechanismResultsModel,
        tournament_mechanism: TournamentMechanismResultsModel,
        k_max_mechanism: KMaxMechanismResultsModel
) -> SummaryModel:
    summary = SummaryModel({})
    variants_count = len(dominance_mechanism.dominance_by_variant.keys())
    for variant_name in dominance_mechanism.dominance_by_variant.keys():
        rating_for_each_preference = []
        for place in [
            dominance_mechanism.dominance_by_variant[variant_name][1],
            lock_mechanism.lock_by_variant[variant_name][1],
            tournament_mechanism.tournament_by_variant[variant_name][1],
            k_max_mechanism.rating_and_place_by_variant[variant_name][1],
            k_max_mechanism.rating_and_place_by_variant_with_optimal[variant_name][1]
        ]:
            rating_for_each_preference.append(variants_count + 1 - place)
        summary.summary_rating_by_variant[variant_name] = rating_for_each_preference
    return summary
