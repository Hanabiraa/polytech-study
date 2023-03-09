from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from config.settings import settings  # noqa
from core import display  # noqa
from core import reshape  # noqa
from core import keys_handler  # noqa


def main():
    # настройка opengl
    settings()

    # отрисовка
    glutDisplayFunc(display.display)

    # триггер при изменении окна
    #glutReshapeFunc(reshape.reshape)

    # триггер при нажатии на клавиши
    #glutSpecialFunc(keys_handler.keys_handler)

    # Запускаем основной цикл
    glutMainLoop()


if __name__ == "__main__":
    main()
