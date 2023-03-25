from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from config.settings import settings  # noqa
from core import display  # noqa
from core.keys_handler import special_keys_handler, keyboard_handler   # noqa

def main():
    # настройка opengl
    settings()

    # отрисовка
    glutDisplayFunc(display.display)

    # триггер при нажатии на клавиши
    glutSpecialFunc(special_keys_handler)
    glutKeyboardFunc(keyboard_handler)

    # Запускаем основной цикл
    glutMainLoop()


if __name__ == "__main__":
    main()
