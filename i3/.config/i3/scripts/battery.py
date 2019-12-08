#!/usr/bin/python

import psutil

battery = psutil.sensors_battery()

if not battery:
    print(battery)
else:
    batteryString = ''
    if battery.percent < 5:
        batteryString = '<span color="red"></span>'
    elif battery.percent < 20:
        batteryString = '<span color="orange"></span>'
    elif battery.percent < 40:
        batteryString = '<span color="yellow"></span>'
    elif battery.percent < 60:
        batteryString = '<span color="white"></span>'
    elif battery.percent < 80:
        batteryString = '<span color="white"></span>'
    else:
        batteryString = '<span color="white"></span>'
    batteryString = batteryString + ' ' + battery.percent
    print(batteryString)