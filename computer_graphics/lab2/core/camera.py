from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa


class Camera:
    eye_pos = [0.0, -0.5, 3.]
    center_pos = [0., 0., 0.]
    up_direction = [0., 1., 0.]
    delta = 0.1

    def __init__(self):
        ...


camera = Camera()