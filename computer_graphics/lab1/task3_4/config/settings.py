from OpenGL.GL import * # noqa
from OpenGL.GLU import * # noqa
from OpenGL.GLUT import * # noqa

_WINDOW_X_SIZE = 700
_WINDOW_Y_SIZE = 700


def settings():
    """
    Глобальные настройки opengl
    """
    global _WINDOW_X_SIZE
    global _WINDOW_Y_SIZE

    # Инициализация OpenGl
    glutInit(sys.argv)

    # Использовать двойную буферизацию и цвета в формате RGB (Красный, Зеленый, Синий)
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)

    # Указываем начальный размер окна (ширина, высота)
    glutInitWindowSize(_WINDOW_X_SIZE, _WINDOW_Y_SIZE)

    # Указываем начальное положение окна относительно левого верхнего угла экрана
    glutInitWindowPosition((glutGet(GLUT_SCREEN_WIDTH) - _WINDOW_X_SIZE) // 2,
                           (glutGet(GLUT_SCREEN_HEIGHT) - _WINDOW_Y_SIZE) // 2)

    # заголовок окна
    glutCreateWindow(b"task1_2")
