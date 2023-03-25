from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from figures.cylinder import cylinder
from figures.tetrahedron import tetrahedron
from .display_figure import display_figure


# отрисовка фигуры
def display():
    glClear(GL_COLOR_BUFFER_BIT)  # очистка экрана
    glPushMatrix()  # Сохраняем текущее положение "камеры"
    display_figure(tetrahedron)
    glPopMatrix()  # Возвращаем сохраненное положение "камеры"

    glPushMatrix()
    display_figure(cylinder)
    glPopMatrix()

    glutSwapBuffers() # Выводим все нарисованное в памяти на экран
