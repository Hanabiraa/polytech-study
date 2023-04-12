from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from figures.light import light # noqa
from .camera import camera # noqa
from config.animate_settings import timer_settings

# обработка спеицальных клавиш для изменения позиции источника света(стрелки)
def special_keys_handler(key, *args):
    # если достиг границы, то идет переворот камеры
    if key == GLUT_KEY_UP and glutGetModifiers() == 1:
        camera.eye_pos[2] += camera.delta
    elif key == GLUT_KEY_DOWN and glutGetModifiers() == 1:
        camera.eye_pos[2] -= camera.delta

    elif key == GLUT_KEY_RIGHT:
        camera.eye_pos[0] += camera.delta
    elif key == GLUT_KEY_LEFT:
        camera.eye_pos[0] -= camera.delta

    elif key == GLUT_KEY_UP:
        camera.eye_pos[1] += camera.delta
    elif key == GLUT_KEY_DOWN:
        camera.eye_pos[1] -= camera.delta

    glutPostRedisplay()


# обработка клавиш клавиатуры
def keyboard_handler(key, *args):
    # интенсивность источника освещения
    if key == b' ':
        timer_settings.animate = not timer_settings.animate

    # цвет света источника освещения
    elif key in [b'r', b'g', b'b']:
        if key == b'r':
            light.color[0] = 0 \
                if light.color[0] + light.color_delta > 1 \
                else light.color[0] + light.color_delta
        elif key == b'g':
            light.color[1] = 0 \
                if light.color[1] + light.color_delta > 1 \
                else light.color[1] + light.color_delta
        elif key == b'b':
            light.color[2] = 0 \
                if light.color[2] + light.color_delta > 1 \
                else light.color[2] + light.color_delta

    # позиция источника освещения
    elif key in [b'w', b'a', b's', b'd']:
        if key == b'w':
            light.pos[1] += light.pos_delta
        elif key == b's':
            light.pos[1] -= light.pos_delta
        elif key == b'd':
            light.pos[0] += light.pos_delta
        elif key == b'a':
            light.pos[0] -= light.pos_delta

    glutPostRedisplay()
