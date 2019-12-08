#!/usr/bin/python

import psutil

x = psutil.cpu_count()

usagePerCpu = psutil.cpu_percent(interval=0.5, percpu=True)

usageString = " "
for cpu in usagePerCpu:
    if cpu < 10:
        usageString = usageString + "▁"
    elif cpu < 20:
        usageString = usageString + "▂"
    elif cpu < 30:
        usageString = usageString + "▃"
    elif cpu < 40:
        usageString = usageString + "▄"
    elif cpu < 50:
        usageString = usageString + "▅"
    elif cpu < 60:
        usageString = usageString + "▆"
    elif cpu < 70:
        usageString = usageString + "▇"
    else:
        usageString = usageString + "█"

print(usageString)