from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

def sphere():
    """
    void glutWireSphere(GLdouble radius, GLint slices, GLint stacks);

    radius - The radius of the sphere.
    slices - The number of subdivisions around the Z axis (similar to lines of longitude).
    stacks -The number of subdivisions along the Z axis (similar to lines of latitude).
    """

    # матрица вращения
    angle = 70
    glRotatef(angle, 0, 1, 0)

    # отрисовка
    glutWireSphere(0.25, 10, 10)