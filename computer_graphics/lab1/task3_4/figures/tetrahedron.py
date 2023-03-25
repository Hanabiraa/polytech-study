from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from .figure_settings import tetrahedron_settings as s


def tetrahedron():
    glRotatef(s.angle, 0, 1, 0)

    # масштаб
    glScalef(s.scale_x, s.scale_y, s.scale_z)

    # отрисовка
    glutWireTetrahedron()
    glRotatef(-s.angle, 0, 1, 0)
