from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from .figure_settings import teapot_settings as s


def teapot():
    glutWireTeapot(s.size)
