import 'package:flutter/material.dart';
import 'package:recychamp/screens/calendar/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEvent extends StatefulWidget {
  const CalendarEvent({super.key});

  @override
  State<CalendarEvent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CalendarEvent> {
  late DateTime _selectedDay;
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _events = {};
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
      child: Column(
        children: [
          Container(
            color: const Color(0XFF75A488),
            child: const Padding(
              padding: EdgeInsets.only(right: 29.61, left: 29.61, top: 54.96),
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 270),
                  Icon(Icons.settings)
                ],
              ),
            ),
          ), //amuthu color

          Container(
            color: const Color(0XFF75A488),
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 29.61, left: 29.61, top: 12),
              child: Row(
                children: [
                  Text(
                    "Select Date",
                    style: kFontFamily(
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(width: 130),
                  const Text(
                    "Jan 2024",
                    style: TextStyle(color: kFontColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          Container(
            color: const Color(0XFF75A488),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 29.61, left: 29.61, top: 15, bottom: 30),
              child: Center(
                child: Column(
                  children: [
                    TableCalendar(
                      focusedDay: _selectedDay,
                      firstDay: DateTime.utc(2024, 1, 1),
                      lastDay: DateTime.utc(2024, 12, 31),
                      calendarFormat: CalendarFormat.week,
                      onFormatChanged: (format) {},
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _selectedEvents = _events[selectedDay] ?? [];
                        });
                      },
                      eventLoader: (day) {
                        return _events[day] ?? [];
                      },
                      headerStyle: HeaderStyle(
                        titleTextStyle: const TextStyle(fontSize: 0),
                        formatButtonTextStyle:
                            const TextStyle().copyWith(color: Colors.white),
                        formatButtonShowsNext: false,
                        formatButtonVisible: false,
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.white),
                        weekendStyle: TextStyle(color: Colors.white),
                      ),
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        selectedDecoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
