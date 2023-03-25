from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from .figure_settings import cylinder_settings as s


def cylinder():
    glRotatef(s.angle, 1, 1, 0)

    glutWireCylinder(s.radius, s.height, s.slices, s.stacks)

    glRotatef(-s.angle, 1, 1, 0)
