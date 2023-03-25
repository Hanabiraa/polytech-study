from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from core.keys_handler import keyboard_handler
from core.core_settings import timer_settings as s
from figures.figure_settings import sphere_settings, teapot_settings


def timer_func(val):
    """
    void glutTimerFunc(unsigned int msecs,
                   void (*func)(int value), value);

    glutTimerFunc registers the timer callback func to be triggered in at least msecs milliseconds. The value parameter to the timer callback will be the value of the value parameter to glutTimerFunc. Multiple timer callbacks at same or differing times may be registered simultaneously.

    The number of milliseconds is a lower bound on the time before the callback is generated. GLUT attempts to deliver the timer callback as soon as possible after the expiration of the callback's time interval.

    There is no support for canceling a registered callback. Instead, ignore a callback based on its value parameter when it is triggered.
    """

    if s.timer_cur > s.timer_max:
        # stop animate, return to init position
        keyboard_handler(b" ", None, None)
        s.timer_cur = 0
        sphere_settings.y = 0
        teapot_settings.x = 0
        glutPostRedisplay()
    else:
        s.timer_cur += 1

    if s.animate:
        sphere_settings.y -= 0.005
        teapot_settings.x += 0.005

    glutPostRedisplay()
    glutTimerFunc(10, timer_func, 0)
