from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from figures.light import light
from core.camera import camera

from figures.big_cube import big_cube
from figures.small_cube import small_cube


# отрисовка фигуры, перед этим сохраняя матрицу сцены
def _display_fig(display_func):
    glPushMatrix()
    display_func()
    glPopMatrix()


# отрисовка сцены (всех фигур)
def display():
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)  # очистка экрана

    # Настройки области видимости (камеры)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()

    # в кадр попадет все, что внутри усеченной пирамиды от 0.1 до 20 по направлению камеры
    gluPerspective(75., 1., 0.1, 20)

    # настройка положения зрения (камеры)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()
    gluLookAt(*camera.eye_pos, *camera.center_pos, *camera.up_direction)

    # постановка источника света
    _display_fig(light.display)

    # отрисовка фигур
    _display_fig(big_cube.display)
    _display_fig(small_cube.display)

    glutSwapBuffers()
