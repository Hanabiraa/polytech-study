from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from .core_settings import timer_settings


# обработка клавиш (запуск анимации при нажатии на пробел)
def keyboard_handler(key, x, y):
    if key == b' ':
        timer_settings.animate = not timer_settings.animate
