from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from .figure_settings import sphere_settings as s


def sphere():
    """
    void glutWireSphere(GLdouble radius, GLint slices, GLint stacks);
    """

    # матрица вращения
    glRotatef(s.angle, 0, 1, 0)

    # отрисовка
    glutWireSphere(s.radius, s.slices, s.stacks)
