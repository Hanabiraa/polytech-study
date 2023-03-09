from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa


def cylinder():
    angle = 45
    glRotatef(angle, 1, 1, 0)

    glutWireCylinder(0.15, 0.5, 10, 10)

    glRotatef(-angle, 1, 1, 0)
