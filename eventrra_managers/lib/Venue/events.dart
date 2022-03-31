// ignore_for_file: prefer_for_elements_to_map_fromiterable

import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  var colour;
  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    test obj1 = new test();
    final days = obj1.daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year - 50, kToday.month, kToday.day);
    final kLastDay = DateTime(kToday.year + 50, kToday.month, kToday.day);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Calendar"),
        ),
        body: Column(
          children: [
            TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, events) {
                  var c = _getEventsForDay(date);
                  if (c.length != 0) {
                    if (date.day < DateTime.now().day)
                      colour = Colors.green[500];
                    else
                      colour = Colors.red[400];

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('${date.day}'),
                          Container(
                            height: 8,
                            width: 8,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colour,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('${date.day}'),
                          Container(
                            height: 8,
                            width: 8,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index]}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

var kEvents;
var _kEventSource1, _kEventSource2;

class test {
  void testfunction() {
    int getHashCode(DateTime key) {
      return key.day * 1000000 + key.month * 10000 + key.year;
    }

    _kEventSource1 = Map.fromIterable(occupiedDates,
        key: (item) => DateTime.utc(
            item['FDate'].year, item['FDate'].month, item['FDate'].day),
        value: (item) => List.generate(
            1,
            (index) => Event(
                'Busy from date ${item['FDate'].day}/${item['FDate'].month}/${item['FDate'].year} - ${item['TDate'].day}/${item['TDate'].month}/${item['TDate'].year} due to ${item['Reason']} .')));

    _kEventSource2 = Map.fromIterable(calenderDates,
        key: (item) => DateTime.utc(
            item['FDate'].year, item['FDate'].month, item['FDate'].day),
        value: (item) => List.generate(
            1,
            (index) => item['FDate'].isAfter(DateTime.now())
                ? Event(
                    '${item['EventType']} Event scheduled by ${item['Name']} from ${item['FDate'].day}/${item['FDate'].month}/${item['FDate'].year} - ${item['TDate'].day}/${item['TDate'].month}/${item['TDate'].year} .')
                : Event(
                    '${item['EventType']} Event completed by ${item['Name']} from ${item['FDate'].day}/${item['FDate'].month}/${item['FDate'].year} - ${item['TDate'].day}/${item['TDate'].month}/${item['TDate'].year} .')));

    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )
      ..addAll(_kEventSource1)
      ..addAll(_kEventSource2);
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }
}
