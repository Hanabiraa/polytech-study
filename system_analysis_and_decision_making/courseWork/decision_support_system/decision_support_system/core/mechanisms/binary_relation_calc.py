from decision_support_system.models import RawData, BinaryRelation
import numpy as np
import pandas as pd

def calculate_binary_relations(dataframe: RawData) -> BinaryRelation:
    """
    Подсчет бинарных отношений для каждой из фичей
    """
    binary_relation_dataframe = BinaryRelation({}, [])
    for row_idx, row in enumerate(dataframe.matrix.to_numpy()):
        print(dataframe.matrix_row_names[row_idx])

        row_size = row.shape[0]
        binary_relation = np.zeros((row_size, row_size))
        for i in range(row_size):
            for j in range(row_size):
                if i == j:
                    binary_relation[(i, j)] = -1
                elif not dataframe.choice_function[row_idx] and row[i] <= row[j]:
                    binary_relation[(i, j)] = 1
                elif dataframe.choice_function[row_idx] and row[i] >= row[j]:
                    binary_relation[(i, j)] = 1

        binary_relation_dataframe.BinaryRelationByFeature[dataframe.matrix_row_names[row_idx]] = binary_relation
        binary_relation_dataframe.BinaryRelationByRowIndex.append(binary_relation)
    return binary_relation_dataframe