from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

# отполированная сфера
class Sphere:
    x = -0.4
    y = 0.4
    z = 0
    radius = 0.25
    slices = 64
    stacks = 64
    angle = 70
    color = [0.2, 0.2, 0.4, 0.7]
    specular = [1., 1., 1., 1.]
    shininess = 100

    def __init__(self):
        ...

    def display(self):
        glTranslatef(
            self.x,
            self.y,
            self.z,
        )
        glRotatef(self.angle, 0, 1, 0)

        # отрисовка
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, self.color)  # отраженный свет
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, self.specular)  # коэффициент блеска
        glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, self.shininess)
        glutSolidSphere(self.radius, self.slices, self.stacks)


sphere = Sphere()