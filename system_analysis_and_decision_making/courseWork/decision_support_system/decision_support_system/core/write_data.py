import pathlib
import shutil

from decision_support_system.models import (
    RawDataframeModel,
    BinaryRelationModels,
    DominanceModels,
    DominanceMechanismResultsModel,
    LockModels,
    LockMechanismResultsModel,
    TournamentModels,
    TournamentMechanismResultsModel,
    KMaxModels,
    KMaxMechanismResultsModel,
    SummaryModel
)


class Writer:
    """
    Класс для вывода всех данных, статистик и прочего
    """

    def __init__(self):
        ...

    def __call__(
            self,
            dir_to_save: str,
            raw_df: RawDataframeModel,
            binary_rel_df: BinaryRelationModels,
            dominance_df: DominanceModels,
            dominance_df_by_variant: DominanceMechanismResultsModel,
            lock_df: LockModels,
            lock_df_by_variant: LockMechanismResultsModel,
            tournament_df: TournamentModels,
            tournament_df_by_variant: TournamentMechanismResultsModel,
            k_max_df: KMaxModels,
            k_max_df_by_variant: KMaxMechanismResultsModel,
            summary_df: SummaryModel
    ) -> None:
        dir = pathlib.Path(dir_to_save)
        dir_for_preference = dir/"information_by_preference"
        if dir.is_dir():
            shutil.rmtree(str(dir))
        pathlib.Path.mkdir(dir)
        pathlib.Path.mkdir(dir_for_preference)

        for preference in binary_rel_df.preference_names:
            file_path = dir_for_preference / f"{preference.replace(' ', '_')}.txt"
            with file_path.open("w", encoding="utf-8") as f:
                summary_str = "\n\n".join(map(str ,[
                    raw_df,
                    binary_rel_df.binary_relation_by_preference[preference],
                    dominance_df.dominance_by_preference[preference],
                    lock_df.lock_by_preference[preference],
                    tournament_df.tournament_by_preference[preference],
                    k_max_df.k_max_matrix_by_preference[preference]
                ]))
                f.write(summary_str)

        file_path = dir / "Итоговый_отчет.txt"
        with file_path.open("w", encoding="utf-8") as f:
            summary_str = "\n\n".join(map(str, [
                dominance_df_by_variant,
                lock_df_by_variant,
                tournament_df_by_variant,
                k_max_df_by_variant,
                summary_df
            ]))
            f.write(summary_str)



