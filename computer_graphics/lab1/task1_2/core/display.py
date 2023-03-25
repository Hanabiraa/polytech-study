from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from figures.sphere import sphere
from figures.teapot import teapot
from .display_figure import display_figure


# отрисовка фигуры
def display():
    glClear(GL_COLOR_BUFFER_BIT)  # очистка экрана
    glPushMatrix()  # Сохраняем текущее положение "камеры"

    display_figure(teapot)
    display_figure(sphere)

    glPopMatrix()  # Возвращаем сохраненное положение "камеры"
    glutSwapBuffers()  # Выводим все нарисованное в памяти на экран
