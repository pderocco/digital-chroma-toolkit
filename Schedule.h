// Schedule.h

#ifndef SCHEDULE_H
#define SCHEDULE_H

#include <cstdint>
#include <map>
#include <QJSValue>
#include <QObject>
#include <QQuickItem>

/* Schedule class -------------------------------------------------------------
This allows JavaScript values (QJSValue type) to be added to a schedule to be 
emitted in timeout signals at some point in the future. Times are int16_t 
values with millisecond resolution, so the schedule is limited to a little over 
16 seconds in the future. Items added to the schedule are uniquely identified 
by int32_t ids that consist of the absolute time in the top 16 bits, and a 
count value in the bottom 16 bits that increments for each value but is reset 
to zero whenever the schedule is empty. This means that continuously keeping 
the schedule busy will eventually wrap the count, possibly losing signals.   */

class Schedule: public QObject {

    Q_OBJECT

    static uint16_t count = 0;

    // circ_lt -- for comparing int32_t values on a circular scale
    struct circ_lt {
        bool operator()(int32_t a, int32_t b) {
            return int32_t(a - b) < 0;
            }
        };

    map<int32_t, QJSValue, circ_lt> sched;

public:

    Schedule(QObject* p = nullptr): QObject(p) {}

    Q_INVOKABLE int32_t add(int16_t t, QJSValue v);
    Q_INVOKABLE QJSValue remove(int32_t id);
    Q_INVOKABLE int16_t service();

signals:

    void timeout(int32_t id, QJSValue i);
    };

#endif // SCHEDULE_H
