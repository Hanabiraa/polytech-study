from OpenGL.GL import *  # noqa
from OpenGL.GLU import *  # noqa
from OpenGL.GLUT import *  # noqa

from core.keys_handler import keyboard_handler
from config.animate_settings import timer_settings

from figures.small_cube import small_cube

# анимации
def timer_func(val):
    """
    void glutTimerFunc(unsigned int msecs,
                   void (*func)(int value), value);

    glutTimerFunc registers the timer callback func to be triggered in at least msecs milliseconds. The value parameter to the timer callback will be the value of the value parameter to glutTimerFunc. Multiple timer callbacks at same or differing times may be registered simultaneously.

    The number of milliseconds is a lower bound on the time before the callback is generated. GLUT attempts to deliver the timer callback as soon as possible after the expiration of the callback's time interval.

    There is no support for canceling a registered callback. Instead, ignore a callback based on its value parameter when it is triggered.
    """

    if not timer_settings.animate:
        glutTimerFunc(500, timer_func, 0)
        return

    # если превышено максимально время - сброс анимации, а также ее остановка (повторная возможна на пробел)
    if timer_settings.timer_cur > timer_settings.timer_max:
        # stop animate, return to init position
        keyboard_handler(b" ", None, None)
        timer_settings.timer_cur = 0

        small_cube.x = -0.4
        small_cube.y = 1.4
        small_cube.z = .4
        small_cube.angle = 0
        small_cube.return_second = True
        small_cube.selected_edge = 3

        glutPostRedisplay()
    else:
        timer_settings.timer_cur += 1

    print(timer_settings.timer_cur)

    if timer_settings.animate:
        if timer_settings.timer_cur < 185:
            if small_cube.angle > -90:
                small_cube.selected_edge = 3
                small_cube.angle -= 1
            else:
                small_cube.x += 0.8
                small_cube.angle = 0
        elif timer_settings.timer_cur < 200:
            small_cube.return_second = True
            small_cube.selected_edge = 3
            small_cube.angle -= 0.8
            small_cube.y -= 0.007
        elif timer_settings.timer_cur < 220:
            small_cube.return_second = True
            small_cube.selected_edge = 3
            small_cube.angle -= 0.8
            small_cube.y -= 0.009
        elif timer_settings.timer_cur < 225:
            small_cube.return_second = True
            small_cube.selected_edge = 3
            small_cube.angle -= 1.5
            small_cube.y -= 0.012
        elif timer_settings.timer_cur < 400 and small_cube.y >= -0.312:
            small_cube.return_second = True
            small_cube.selected_edge = 3
            small_cube.angle -= 0.8
            small_cube.x += 0.004
            small_cube.y -= 0.015
        elif timer_settings.timer_cur < 400:
            if small_cube.angle < -90:
                small_cube.return_second = True
                small_cube.selected_edge = 3
                small_cube.angle += 2
                if small_cube.y >= - 1:
                    small_cube.y -= 0.02
            else:
                timer_settings.timer_cur = 506
                small_cube.angle = 0
                small_cube.x += 0.8
        elif 600 <= timer_settings.timer_cur < 900:
            small_cube.return_second = False
            small_cube.selected_edge = 6
            if small_cube.angle < 90:
                small_cube.angle += 2


    glutPostRedisplay()
    glutTimerFunc(10, timer_func, 0)