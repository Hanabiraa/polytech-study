from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from figures.figure_settings import sphere_settings, teapot_settings


def display_figure(figure):
    """
    смещение по x, y, z
    отрисовка фигуры
    возврат обратно в центр окна
    """
    match figure.__name__:
        case "teapot":
            glTranslatef(
                teapot_settings.x,
                teapot_settings.y,
                teapot_settings.z,
            )
            figure()
            glTranslatef(
                -teapot_settings.x,
                -teapot_settings.y,
                -teapot_settings.z,
            )
        case "sphere":
            glTranslatef(
                sphere_settings.x,
                sphere_settings.y,
                sphere_settings.z,
            )
            figure()
            glTranslatef(
                -sphere_settings.x,
                -sphere_settings.y,
                -sphere_settings.z,
            )
