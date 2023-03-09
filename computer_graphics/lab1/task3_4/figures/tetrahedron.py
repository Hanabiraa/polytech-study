from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa


def tetrahedron():
    angle = 90
    x = 0
    y = 1
    z = 0
    glRotatef(angle, x, y, z)

    # масштаб
    glScalef(0.45, 0.45, 0.45)

    # отрисовка
    glutWireTetrahedron()
    glRotatef(-angle, x, y, z)
