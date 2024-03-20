import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/screens/ChallengeDetails/bloc/challenge_details_bloc.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import 'package:recychamp/screens/Challenges/challenges.dart';
import 'package:recychamp/services/challenge_service.dart';
import 'package:recychamp/utils/event_data.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';

class CalendarEvent extends StatefulWidget {
  const CalendarEvent({super.key});

  @override
  State<CalendarEvent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CalendarEvent> {
  List<Challenge> challenges = [];
  List<Challenge> _selectedEvents = [];
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();

    getChallenges();
  }

  Future<void> getChallenges() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('challenges').get();

      // Convert the document snapshots to Challenge objects
      List<Challenge> challengesResult = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Challenge challenge = Challenge(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          location: data['location'],
          country: data['country'],
          rules: data['rules'],
          startDateTime: data['startDateTime'].toDate(),
          endDateTime: data['endDateTime'].toDate(),
          maximumParticipants: data['maximumParticipants'],
          acceptedParticipants: List<String>.from(data[
              "acceptedParticipants"]), // * converting dynamic array to string array
          submittedParticipants: List<String>.from(data[
              "submittedParticipants"]), // * converting dynamic array to string array
          difficulty: data['difficulty'],
          imageURL: data['imageURL'],
          type: data['type'],
          rating: double.parse(data['rating']
              .toString()), // * converting firebase number format to double format
          categoryId: data["categoryId"],
        );

        challengesResult.add(challenge);
      }

      setState(() {
        challenges = challengesResult;
      });
    } catch (e) {
      throw Exception("Failed to get challenges: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    //var deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0XFF75A488),
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
                              Colors.white, BlendMode.srcIn),
                        ),
                      ),
                      const SizedBox(width: 270),
                      const Icon(
                        Icons.settings,
                        color: Colors.white,
                      )
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
                      const SizedBox(width: 110),
                      Text(
                        DateFormat('MMM yyyy').format(_selectedDay),
                        style: kFontFamily(
                            color: kFontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 130,
                color: const Color(0XFF75A488),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 29, left: 29, top: 15, bottom: 5),
                  child: Center(
                    child: Column(
                      children: [
                        TableCalendar(
                          focusedDay: _selectedDay,
                          firstDay: DateTime.utc(2020, 1, 1),
                          lastDay: DateTime.utc(2030, 12, 31),
                          calendarFormat: CalendarFormat.week,
                          onFormatChanged: (format) {},
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              // Check if selectedDay is not null
                              if (selectedDay != null) {
                                // Check if selectedDay is equal to firstDay or lastDay

                                // assigning the selected date
                                _selectedDay = selectedDay;

                                // assigning selected challenge to the selected challenges array
                                _selectedEvents = challenges
                                    .where((challenge) =>
                                        challenge.startDateTime != null &&
                                        challenge.endDateTime != null &&
                                        (challenge.startDateTime
                                                .isBefore(selectedDay) ||
                                            challenge.startDateTime
                                                .isAtSameMomentAs(
                                                    selectedDay)) &&
                                        (challenge.endDateTime
                                                .isAfter(selectedDay) ||
                                            challenge.endDateTime
                                                .isAtSameMomentAs(selectedDay)))
                                    .toList();
                              }
                            });
                          },
                          selectedDayPredicate: (day) =>
                              isSameDay(day, _selectedDay),
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
                            isTodayHighlighted: true,
                            selectedDecoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            todayDecoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            weekendTextStyle: TextStyle(color: Colors.white),
                            weekendDecoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            holidayDecoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            rangeStartDecoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            rangeEndDecoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            defaultDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                            ),
                            selectedTextStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: FractionallySizedBox(
                  //rounded corner box

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
                    child: _buildChallengeDetails(_selectedEvents),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildChallengeDetails(List<Challenge> selectedChallenges) {
    if (selectedChallenges.isNotEmpty) {
      return ListView.builder(
        itemCount: selectedChallenges.length,
        itemBuilder: (context, index) {
          return eventDetails(eventDetails_: selectedChallenges[index]);
        },
      );
    } else {
      return Center(
        child: Text(
          'No challenges for selected date',
          style: kFontFamily(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }

  Widget eventDetails({required Challenge eventDetails_}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40.1),
            child: Image.network(
              eventDetails_.imageURL,
              width: 822.4,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            eventDetails_.title,
            style: kFontFamily(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            eventDetails_.location,
            style: kFontFamily(
              color: const Color.fromARGB(116, 116, 116, 1),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            eventDetails_.description,
            style: kFontFamily(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(bottom: 15, top: 10),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                 

                  // Handle join button click
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.8),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 17.88)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: Text(
                  "Join Now",
                  style: kFontFamily(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
