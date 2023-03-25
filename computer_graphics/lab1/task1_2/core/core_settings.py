from dataclasses import dataclass


@dataclass
class TimerSettings:
    timer_max = 120
    timer_cur = 0
    msecs_interval = 10
    animate = False


timer_settings = TimerSettings()
