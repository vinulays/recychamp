import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/calendar/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_svg/svg.dart';

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

    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0XFF75A488),
          body:


              // padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
              Column(
            children: [
              Container(
                height: 80,
                color: const Color(0XFF75A488),
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 0, left: 29, top: 54.96),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/go_back.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        ),
                      ),
                      const SizedBox(width: 270),
                      const Icon(Icons.settings)
                    ],
                  ),
                ),
              ), //amuthu color

              Container(
                height: 50,
                color: const Color(0XFF75A488),
                child: Padding(
                  padding: const EdgeInsets.only(right: 0, left: 29, top: 12),
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
                height: 150,
                color: const Color(0XFF75A488),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 29, left: 29, top: 15, bottom: 30),
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
                              // if (state is ChallengesLoaded) {
                              //   state.challenges

                              // }
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
                            leftChevronVisible: false,
                            rightChevronVisible: false,
                            leftChevronIcon: const Icon(Icons
                                .chevron_left), // You can customize the icons if needed
                            rightChevronIcon: const Icon(Icons.chevron_right),
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
              ),

              Expanded(
                child: FractionallySizedBox(
                    //rounded corner box
                    // heightFactor: 0.4,
                    child: Container(
                  width: double.infinity,
                  // height: double.infinity,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(42.07),
                        topRight: Radius.circular(42.07),
                      ),
                    ),
                  ),
                )),
              )
            ],
          ),
        );
      },
    );
  }
}
