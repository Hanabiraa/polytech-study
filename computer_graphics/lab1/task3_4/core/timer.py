from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from core.keys_handler import keyboard_handler
from core.core_settings import timer_settings
from figures.figure_settings import tetrahedron_settings

# анимации
def timer_func(val):
    """
    void glutTimerFunc(unsigned int msecs,
                   void (*func)(int value), value);

    glutTimerFunc registers the timer callback func to be triggered in at least msecs milliseconds. The value parameter to the timer callback will be the value of the value parameter to glutTimerFunc. Multiple timer callbacks at same or differing times may be registered simultaneously.

    The number of milliseconds is a lower bound on the time before the callback is generated. GLUT attempts to deliver the timer callback as soon as possible after the expiration of the callback's time interval.

    There is no support for canceling a registered callback. Instead, ignore a callback based on its value parameter when it is triggered.
    """

    # если превышено максимально время - сброс анимации, а также ее остановка (повторная возможна на пробел)
    if timer_settings.timer_cur > timer_settings.timer_max:
        # stop animate, return to init position
        keyboard_handler(b" ", None, None)
        timer_settings.timer_cur = 0
        tetrahedron_settings.scale_x = 0.25
        tetrahedron_settings.scale_y = 0.25
        tetrahedron_settings.scale_z = 0.25
        tetrahedron_settings.angle = 90
        glutPostRedisplay()
    else:
        timer_settings.timer_cur += 1

    if timer_settings.animate:
        tetrahedron_settings.scale_x += 0.001
        tetrahedron_settings.scale_y += 0.001
        tetrahedron_settings.scale_z += 0.001
        tetrahedron_settings.angle += 1
    glutPostRedisplay()
    glutTimerFunc(10, timer_func, 0)
