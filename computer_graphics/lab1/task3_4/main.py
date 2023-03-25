from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from config.settings import settings  # noqa
from core import display  # noqa
from core import keys_handler  # noqa
from core import reshape  # noqa
from core import timer  # noqa

def main():
    # настройка opengl
    settings()

    # отрисовка
    glutDisplayFunc(display.display)

    # триггер при нажатии на клавиши
    glutKeyboardFunc(keys_handler.keyboard_handler)

    # анимация
    glutTimerFunc(500, timer.timer_func, 0)
    # Запускаем основной цикл
    glutMainLoop()


if __name__ == "__main__":
    main()
