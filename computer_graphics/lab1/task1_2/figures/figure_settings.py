from dataclasses import dataclass


@dataclass
class TeapotSettings:
    x = 0
    y = 0
    z = 0
    size = 0.25


@dataclass
class SphereSettings:
    x = 0
    y = 0
    z = 0
    radius = 0.25
    slices = 10
    stacks = 10
    angle = 70


teapot_settings = TeapotSettings()
sphere_settings = SphereSettings()
