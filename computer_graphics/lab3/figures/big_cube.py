from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

import numpy as np

# текстурированный цилиндр
class BigCube:
    x = 0.0
    y = 0.0
    z = 0
    angle = 0
    scale = [1.0, 1.0, 1.0]

    vertices = ((-1, -1, -1), (1, -1, -1), (1, 1, -1), (-1, 1, -1), (-1, -1, 1), (1, -1, 1), (1, 1, 1), (-1, 1, 1))
    faces = ((0, 1, 2, 3), (3, 2, 6, 7), (7, 6, 5, 4), (4, 5, 1, 0), (0, 3, 7, 4), (1, 2, 6, 5))
    texcoords = ((0, 0), (1, 0), (1, 1), (0, 1))

    # Идентификатор текстуры
    texture_id = 0

    def __init__(self):
        ...

    def set_texture_id(self, id):
        self.texture_id = id

    def display(self):
        glTranslatef(
            self.x,
            self.y,
            self.z,
        )
        glRotatef(self.angle, 1, 1, 0)
        glScale(*self.scale)

        # включения поддержки текстурированного объекта
        glEnable(GL_TEXTURE_2D)

        glBindTexture(GL_TEXTURE_2D, self.texture_id)
        glBegin(GL_QUADS)
        for face in self.faces:
            for i, vertex in enumerate(face):
                glTexCoord2fv(self.texcoords[i])
                glVertex3fv(self.vertices[vertex])
        glEnd()

        # отключение поддержки текстурированного объекта
        glDisable(GL_TEXTURE_2D)

big_cube = BigCube()
