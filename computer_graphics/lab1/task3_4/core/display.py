from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from figures.tetrahedron import tetrahedron
from figures.cylinder import cylinder


def shift(figure, x, y, z):
    """
    смещение по x, y, z
    отрисовка фигуры
    возврат обратно в центр окна
    """
    glTranslatef(x, y, z)
    figure()
    glTranslatef(-x, -y, -z)


# отрисовка фигуры
def display():
    glClear(GL_COLOR_BUFFER_BIT)  # очистка экрана
    glPushMatrix()  # Сохраняем текущее положение "камеры"

    # каркасный чайник
    shift(cylinder, 0.5, 0.7, 0)

    # каркасная сфера
    shift(tetrahedron, -0.5, -0.3, 0)

    glPopMatrix()  # Возвращаем сохраненное положение "камеры"
    glutSwapBuffers()  # Выводим все нарисованное в памяти на экран
