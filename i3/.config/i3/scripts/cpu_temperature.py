#!/usr/bin/python

import psutil

temperatures = psutil.sensors_temperatures()

tempString = ""
coretemp = temperatures['coretemp']

for entry in coretemp:
    if 'Core' in entry.label:
        if entry.current < 20:
            tempString = tempString + "<span color='white'>▁</span>"
        elif entry.current < 30:
            tempString = tempString + "<span color='white'>▂</span>"
        elif entry.current < 40:
            tempString = tempString + "<span color='white'>▃</span>"
        elif entry.current < 50:
            tempString = tempString + "<span color='white'>▄</span>"
        elif entry.current < 60:
            tempString = tempString + "<span color='yellow'>▅</span>"
        elif entry.current < 70:
            tempString = tempString + "<span color='yellow'>▆</span>"
        elif entry.current < 80:
            tempString = tempString + "<span color='orange'>▇</span>"
        else:
            tempString = tempString + "<span color='red'>█</span>"

print(tempString)