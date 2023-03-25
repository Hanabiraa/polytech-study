from dataclasses import dataclass


@dataclass
class TimerSettings:
    """
    настройки таймера для анимаций
    """
    timer_max = 250
    timer_cur = 0
    msecs_interval = 4
    animate = False


timer_settings = TimerSettings()
