from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from core.load_texture import read_texture

from figures.big_cube import big_cube
from figures.small_cube import small_cube

_WINDOW_X_SIZE = 700
_WINDOW_Y_SIZE = 700

texture_1_id = None
texture_2_id = None


def settings():
    """
    Глобальные настройки opengl
    """
    global _WINDOW_X_SIZE
    global _WINDOW_Y_SIZE

    # Инициализация OpenGl
    glutInit(sys.argv)

    # Настройки дисплея
    # glutInitDisplayMode(GLUT_RGBA | GLUT_DEPTH)
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB | GLUT_DEPTH)

    # Указываем начальный размер окна (ширина, высота)
    glutInitWindowSize(_WINDOW_X_SIZE, _WINDOW_Y_SIZE)

    # Указываем начальное положение окна относительно левого верхнего угла экрана
    glutInitWindowPosition((glutGet(GLUT_SCREEN_WIDTH) - _WINDOW_X_SIZE) // 2,
                           (glutGet(GLUT_SCREEN_HEIGHT) - _WINDOW_Y_SIZE) // 2)

    # заголовок окна
    glutCreateWindow(b"lab2")

    # настройка света
    glEnable(GL_LIGHTING)  # включение освещения
    glEnable(GL_LIGHT0)  # включение первого источника света
    glEnable(GL_NORMALIZE)  # приведение нормалей к единичной длине

    glEnable(GL_DEPTH_TEST)  # если тест глубины пройден - сохранить значения глубины
    glEnable(GL_ALPHA_TEST)  # тоже самое, но для альфа-канала
    # настройка камеры
    glViewport(0, 0, _WINDOW_X_SIZE, _WINDOW_Y_SIZE)

    # загрузка и установка текстуры
    big_cube.set_texture_id(read_texture("./assets/img.png"))
    small_cube.set_texture_id(read_texture("./assets/t.png"))
