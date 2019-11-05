// Schedule.cpp

#include "Schedule.h"
#include <QDateTime>

/* Schedule:add ---------------------------------------------------------------
This adds JavaScript value v to the schedule, to be emitted in a timeout signal 
t milliseconds in the future, and returns its unique id. If t <= 0, it uses a 
value of 0, so it will be emitted on the next call to Schedule::service.     */

int32_t Schedule::add(int16_t t, QJSValue v) {

    if (t < 0)
        t = 0;
    int32_t id = ((t + int16_t(QDateTime::currentMSecsSinceEpoch()) << 16) 
            | ++count;
    sched[id] = v;
    return id;
    }

/* Schedule::remove -----------------------------------------------------------
This removes from the schedule the value specified by id, and returns the 
value, or undefined if it wasn't found.                                      */

QJSValue Schedule::remove(int32_t id) {

    auto i = sched.find(id);
    if (i == sched.end())
        return QJSValue();
    auto e = *i;
    sched.erase(i);
    if (sched.empty())
        count = 0;
    return e.second();
    }

/* Schedule::service ----------------------------------------------------------
This emits signals for any schedule values whose times have arrived, and then 
returns the number of milliseconds until the earliest time remaining in the 
schedule, or 0 if the schedule is empty. If nonzero, it means that this should 
be called again in that amount of time.                                      */

int16_t Schedule::service() {
    int16_t d;
    int16_t t;

    if (sched.empty())
        return 0;
    while (true) {
        t = QDateTime::currentMSecsSinceEpoch();
        d = t - sched.begin().first >> 16;
        if (d < 0)
            return -d;
        do {
            auto e = *sched.begin();
            sched.erase(sched.begin());
            emit timeout(e.first(), e.second());
            if (sched.empty()) {
                count = 0;
                return 0;
                }
            d = t - sched.begin().first >> 16;
            } while (d >= 0);
        }
    }
