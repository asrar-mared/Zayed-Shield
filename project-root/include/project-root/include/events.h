#ifndef EVENTS_H
#define EVENTS_H

#define EVENT_KEYPRESS 1

void init_events();
void dispatch_event(int event_type, int data);

#endif
