from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa
import numpy as np

# Функция, которая находит центр ребра
def edge_center(v1, v2, ret_sec=True):
    if ret_sec:
        return v2
    return v1

# текстурированный цилиндр
class SmallCube:
    x = -0.4
    y = 1.4
    z = 0

    angle = 0 # угол

    # Ребра куба
    edges = np.array([
        [0, 1], [0, 2], [0, 4],
        [1, 3], [1, 5], [2, 3],
        [2, 6], [3, 7], [4, 5],
        [4, 6], [5, 7], [6, 7]
    ])

    selected_edge = 5  # номер выбранного ребра
    return_second = True

    scale = [0.4, 0.4, 0.4]

    vertices = np.array(((-1, -1, -1), (1, -1, -1), (1, 1, -1), (-1, 1, -1), (-1, -1, 1), (1, -1, 1), (1, 1, 1), (-1, 1, 1)))

    faces = (
        (0, 1, 2, 3),  # left
        (1, 5, 6, 2),  # front
        (3, 2, 6, 7),  # top
        (4, 5, 1, 0),  # back
        (4, 0, 3, 7),  # right
        (7, 6, 5, 4),  # bottom
    )
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
        glScale(*self.scale)

        self.__rotate()

        self.__draw_cube()


    def __rotate(self, custom_coord=None):
        # Находим координаты вершин выбранного ребра
        edge_vertices = self.vertices[self.edges[self.selected_edge]]

        # Находим координаты центра выбранного ребра
        edge_center_coord = edge_center(*edge_vertices, ret_sec=self.return_second)

        # Перемещаем куб так, чтобы центр выбранного ребра был в начале координат
        glTranslatef(*-edge_center_coord)

        # Находим вектор, параллельный выбранному ребру
        edge_vector = np.subtract(*edge_vertices)
        edge_length = np.linalg.norm(edge_vector)
        edge_direction = edge_vector / edge_length

        # Находим ось вращения - перпендикулярную плоскости выбранного ребра
        rotation_axis = np.cross(edge_direction, [0, 1, 0])
        rotation_axis /= np.linalg.norm(rotation_axis)

        # Поворачиваем куб на нужный угол вокруг оси вращения
        glRotatef(self.angle, *rotation_axis)

        # Перемещаем куб обратно в исходную позицию
        glTranslatef(*edge_center_coord)

    def __draw_cube(self):
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

small_cube = SmallCube()
