from dataclasses import dataclass
from typing import Dict, List
import numpy as np


@dataclass
class BinaryRelation:
    BinaryRelationByFeature: Dict[str, np.ndarray]
    BinaryRelationByRowIndex: List[np.ndarray]