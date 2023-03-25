from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa


# текстурированный цилиндр
class Cylinder:
    x = 0.4
    y = 0.4
    z = 0
    radius = 0.15
    height = 0.5
    slices = 64
    stacks = 64
    angle = 45
    color = [0.3, 0.6, 0.1, 1.]

    def __init__(self):
        ...

    def display(self):
        glTranslatef(
            self.x,
            self.y,
            self.z,
        )
        glRotatef(self.angle, 1, 1, 0)

        # включения поддержки текстурированного объекта
        glEnable(GL_TEXTURE_2D)

        # текстурирование
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, self.color) # задаем дифуззию
        glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE) # режим текстуры
        glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP) # как генерировать текстуру
        glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP) # как генерировать текстуру
        qobj = gluNewQuadric() # готовая текстура для объекта
        gluQuadricTexture(qobj, GL_TRUE)

        # отрисовка
        gluCylinder(qobj, self.radius, self.radius, self.height, self.slices,
                    self.stacks)  # построение цилиндра без дисков
        glRotatef(180, 1, 0, 0)  # поворот на 180 по х
        gluDisk(qobj, 0.0, self.radius, self.slices, 1)  # построение первого диска
        glRotatef(180, 1, 0, 0)  # поворот на 180 по х
        glTranslatef(0.0, 0.0, self.height)  # смещение на высоту по z
        gluDisk(qobj, 0.0, self.radius, self.slices, 1)  # построение второго диска
        glTranslatef(0.0, 0.0, -self.height)  # смещение на высоту по z

        gluDeleteQuadric(qobj)  # удаление сгенерированной текстуры

        # отключение поддержки текстурированного объекта
        glDisable(GL_TEXTURE_2D)


cylinder = Cylinder()
