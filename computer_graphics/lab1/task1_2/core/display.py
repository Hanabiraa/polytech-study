from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from figures.sphere import sphere
from figures.teapot import teapot


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
    shift(teapot, 0.5, 0, 0)

    # каркасная сфера
    shift(sphere, 0, -0.3, 0)

    glPopMatrix()  # Возвращаем сохраненное положение "камеры"
    glutSwapBuffers()  # Выводим все нарисованное в памяти на экран
