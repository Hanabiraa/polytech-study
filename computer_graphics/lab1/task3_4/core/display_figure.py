from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from figures.figure_settings import tetrahedron_settings, cylinder_settings


# отрисовка отдельной фигуры
def display_figure(figure):
    """
    смещение по x, y, z
    отрисовка фигуры
    возврат обратно в центр окна
    (для каждой фигуры)
    """
    match figure.__name__:
        case "tetrahedron":
            glTranslatef(
                tetrahedron_settings.x,
                tetrahedron_settings.y,
                tetrahedron_settings.z,
            )
            figure()
            glTranslatef(
                -tetrahedron_settings.x,
                -tetrahedron_settings.y,
                -tetrahedron_settings.z,
            )
        case "cylinder":
            glTranslatef(
                cylinder_settings.x,
                cylinder_settings.y,
                cylinder_settings.z,
            )
            figure()
            glTranslatef(
                -cylinder_settings.x,
                -cylinder_settings.y,
                -cylinder_settings.z,
            )
