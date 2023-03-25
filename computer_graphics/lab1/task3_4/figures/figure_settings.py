from dataclasses import dataclass

"""
Настройки фигур
"""
@dataclass
class TetrahedronSettings:
    x = -0.1
    y = -0.3
    z = 0
    scale_x = 0.25
    scale_y = 0.25
    scale_z = 0.25
    angle = 90


@dataclass
class CylinderSettings:
    x = 0.5
    y = 0.7
    z = 0
    radius = 0.15
    height = 0.5
    slices = 10
    stacks = 10
    angle = 45


tetrahedron_settings = TetrahedronSettings()
cylinder_settings = CylinderSettings()
