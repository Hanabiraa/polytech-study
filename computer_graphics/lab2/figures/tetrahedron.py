from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

# полупрозрачный тетраэдр
class Tetrahedron:
    x = -0.1
    y = -0.3
    z = 0
    scale_x = 0.35
    scale_y = 0.35
    scale_z = 0.35
    angle = 90
    color = [0.90, 0., 0.45, 0.6]
    specular = [0., 0., 0., 0.]

    def __init__(self):
        ...

    def display(self):
        glTranslatef(
            self.x,
            self.y,
            self.z,
        )
        glRotatef(self.angle, 0, 1, 0)
        glRotatef(self.angle, 0, 0, 1)

        # масштаб
        glScalef(self.scale_x, self.scale_y, self.scale_z)

        # включение прозрачности
        glEnable(GL_BLEND)
        # glBlendFunc(GL_ONE, GL_ONE)
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
        # отрисовка
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, self.color)  # отраженный свет
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, self.specular)
        glutSolidTetrahedron()

        # выключение прозрачности
        glDisable(GL_BLEND)

tetrahedron = Tetrahedron()
