from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa


# конфигурация источника света
class Light:
    pos = [0., 0., 4., 1.]
    pos_delta = 0.1
    attenuation = 0.3
    attenuation_delta = 0.1
    color = [0.8, 0.8, 0.8]
    color_delta = 0.05
    angle = 0

    def __init__(self):
        ...

    def display(self):
        glRotatef(self.angle, 1., 0., 0.)
        glLightfv(GL_LIGHT0, GL_DIFFUSE, self.color)
        glLightfv(GL_LIGHT0, GL_POSITION, self.pos)
        glLightf(GL_LIGHT0, GL_CONSTANT_ATTENUATION, self.attenuation)
        glLightf(GL_LIGHT0, GL_LINEAR_ATTENUATION, 0.1)


light = Light()
