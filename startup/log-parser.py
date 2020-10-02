#!/usr/bin/env python3
import datetime


events = []


class Event():
    def __init__(self, event, date):
        self.event = event
        self.date = date

    def __str__(self):
        return "{} {}".format(self.event, self.date)

    @property
    def working_day(self):
        offset_time = self.date - datetime.timedelta(hours=8)
        return offset_time.date()

    @classmethod
    def from_line(cls, line):
        event, timestamp = line.split()
        date = datetime.datetime.fromisoformat(timestamp)
        return cls(event, date)

with open("/home/jtm/.startups") as f:
    events = [Event.from_line(l) for l in f.readlines()]


assert events[0].event == "Up"

current_event = None

# Worked hours indexed by date
worked_hours = {}

for event in events:
    if current_event == None and event.event == "Down":
        raise Exception("Two down events in a row??")
    elif current_event == None and event.event == "Up":
        current_event = event
    elif current_event and event.event == "Down":
        time = event.date - current_event.date
        if event.working_day not in worked_hours:
            worked_hours[current_event.working_day] = time
        else:
            worked_hours[current_event.working_day] += time

        current_event = None


total_extra = 0
for d in sorted(worked_hours.keys()):
    delta = worked_hours[d].total_seconds() - \
        datetime.timedelta(hours=8).total_seconds()
    print("{} worked {}, delta {}mins".format(d, worked_hours[d], delta/60))

    total_extra += delta

print(total_extra/60/60)
