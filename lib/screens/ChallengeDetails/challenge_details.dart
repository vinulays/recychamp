import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/screens/ChallengeDetails/bloc/challenge_details_bloc.dart';
import 'package:recychamp/screens/ChallengeForm/challenge_form.dart';
import 'package:recychamp/screens/ChallengeSubmissionForm/challenge_submission_form.dart';
import 'package:recychamp/screens/ChallengeSubmissionView/bloc/submission_view_bloc.dart';
import 'package:recychamp/screens/ChallengeSubmissionView/challenge_submission_view.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/ParentAgreement/parent_agreement.dart';
import 'package:recychamp/ui/challenge_details_row.dart';
import 'package:recychamp/utils/challenge_categories.dart';

class ChallengeDetails extends StatefulWidget {
  const ChallengeDetails({super.key});

  @override
  State<ChallengeDetails> createState() => _ChallengeDetailsState();
}

class _ChallengeDetailsState extends State<ChallengeDetails> {
  String? userRole;
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  // todo: get user details from the user state
  Future<void> getUserRole() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        String? role = await userSnapshot.get("role");

        setState(() {
          userRole = role;
          userId = user.uid;
        });
      }
    } catch (error) {
      throw Exception("Error getting role: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Challenge? challenge;

    String? challengeType;
    String? startDateTime;
    String? endDateTime;
    DateTime currentDateTime = DateTime.now();

    List<String> acceptedParticipants;
    List<String> submittedParticipants;
    bool? isAccepted;
    bool? isSubmitted;

    List<String>? ruleList;

    var isDialOpen = ValueNotifier<bool>(false);

    // * Wrapping the widget with the bloc builder
    return BlocBuilder<ChallengeDetailsBloc, ChallengeDetailsState>(
      builder: (context, state) {
        if (state is ChallengeLoaded) {
          challenge = state.challenge;
          ruleList = state.challenge.rules.split(";");
          challengeType = state.challenge.type;
          startDateTime = state.challenge.startDateTime.toString();
          endDateTime = state.challenge.endDateTime.toString();
          acceptedParticipants = state.challenge.acceptedParticipants;
          submittedParticipants = state.challenge.submittedParticipants;
          isAccepted = acceptedParticipants.contains(userId);
          isSubmitted = submittedParticipants.contains(userId);
        }
        return Scaffold(
          floatingActionButton: (userRole == "admin" || userRole == "organizer")
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 12),
                  child: SpeedDial(
                    openCloseDial: isDialOpen,
                    icon: Icons.settings,
                    activeIcon: Icons.close,
                    backgroundColor: const Color(0xFF75A488),
                    foregroundColor: Colors.white,
                    buttonSize: const Size(63, 63),
                    childrenButtonSize: const Size(73, 73),
                    spaceBetweenChildren: 10,
                    direction: SpeedDialDirection.up,
                    children: [
                      SpeedDialChild(
                          child: const Icon(Icons.edit),
                          backgroundColor: const Color(0xFF75A488),
                          foregroundColor: Colors.white,
                          onTap: () {
                            showGeneralDialog(
                                context: context,
                                barrierColor: Colors.white,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return ChallengeForm(
                                    challenge: challenge,
                                    isUpdate: true,
                                  );
                                });
                          },
                          shape: const CircleBorder()),
                      if (userRole == "admin")
                        SpeedDialChild(
                            child: const Icon(Icons.delete),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text(
                                        "Delete the Challenge",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      content: Text(
                                        "This action cannot be undone. Do you really want to delete this challenge?",
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "No",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              context
                                                  .read<ChallengesBloc>()
                                                  .add(
                                                    DeleteChallengeEvent(
                                                        challenge!.id!),
                                                  );

                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Yes",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14),
                                            )),
                                      ],
                                    );
                                  });
                            },
                            shape: const CircleBorder()),
                    ],
                  ),
                )
              : Container(),
          backgroundColor: Colors.white,
          body: (state is ChallengeLoaded)
              ? Column(
                  children: [
                    // * challenge thumbnail
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcATop,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: const Alignment(0.01, 0),
                              end: const Alignment(0.02, 0.80),
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black
                              ],
                            ).createShader(bounds);
                          },
                          child: CachedNetworkImage(
                            imageUrl: state.challenge.imageURL,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 292,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        // * back button to challenges list
                        Positioned(
                          top: 41.86,
                          left: 25.58,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("assets/icons/go_back.svg"),
                          ),
                        ),
                        //  * offline / online badge
                        Positioned(
                          top: 41.86,
                          left: 300,
                          child: Container(
                            width: 75,
                            height: 25,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.83),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AvatarGlow(
                                  glowColor: ((currentDateTime.isAfter(
                                              challenge!.startDateTime)) &&
                                          currentDateTime.isBefore(
                                              state.challenge.endDateTime))
                                      ? Colors.green
                                      : Colors.red,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: ((currentDateTime.isAfter(
                                                  challenge!.startDateTime)) &&
                                              currentDateTime.isBefore(
                                                  challenge!.endDateTime))
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ((currentDateTime.isAfter(
                                              challenge!.startDateTime)) &&
                                          currentDateTime.isBefore(
                                              state.challenge.endDateTime))
                                      ? "online"
                                      : "offline",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // * category badge
                        Positioned(
                          top: 192,
                          left: 25.58,
                          child: Container(
                            height: 25,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.83),
                              ),
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    challengeCategories
                                        .firstWhere((category) =>
                                            category.id ==
                                            state.challenge.categoryId)
                                        .name,
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // * challenge title
                        Positioned(
                          top: 234,
                          left: 25.58,
                          child: Text(
                            state.challenge.title,
                            style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),

                    // * If challenge/event is accepted, display the progress bar
                    if (isAccepted!)
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                horizontal: deviceSize.width * 0.05),
                            height: 76,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.83),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: (isSubmitted!)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          (Text(
                                            "You have completed this ${challengeType == "challenge" ? "challenge" : "event"}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black),
                                          )),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          const Icon(
                                            Icons.check_circle_outline_rounded,
                                            color: Colors.green,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      (currentDateTime.isAfter(
                                                  challenge!.startDateTime) &&
                                              currentDateTime.isBefore(
                                                  challenge!.endDateTime))
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'You have ',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.6499999761581421),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${Jiffy.parse(endDateTime!).diff(Jiffy.parse(currentDateTime.toString()), unit: Unit.day).toString()} days',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.6499999761581421),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' to complete the challenge !',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.6499999761581421),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : (currentDateTime.isAfter(
                                                  challenge!.endDateTime))
                                              ? (Text(
                                                  "Challenge is ended :(",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ))
                                              : (Text(
                                                  "Challenge is not started yet :(",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                )),

                                      // * Displaying the progress bar only if the current date is in between start date and end date
                                      if (currentDateTime.isAfter(
                                              challenge!.startDateTime) &&
                                          currentDateTime
                                              .isBefore(challenge!.endDateTime))
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: deviceSize.width * 0.01,
                                              right: deviceSize.width * 0.01,
                                              bottom: 5),
                                          child: LinearPercentIndicator(
                                            barRadius:
                                                const Radius.circular(16.83),
                                            lineHeight: 20.0,
                                            // * (totalDays - remainingDays) / totalDays
                                            percent: (Jiffy.parse(endDateTime!)
                                                        .diff(
                                                            Jiffy.parse(
                                                                startDateTime!),
                                                            unit: Unit.day) -
                                                    Jiffy.parse(endDateTime!)
                                                        .diff(
                                                            Jiffy.parse(
                                                                currentDateTime
                                                                    .toString()),
                                                            unit: Unit.day)) /
                                                Jiffy.parse(endDateTime!).diff(
                                                    Jiffy.parse(startDateTime!),
                                                    unit: Unit.day),
                                            animation: true,
                                            animationDuration: 1000,
                                            backgroundColor:
                                                const Color(0xffC8E8D5),
                                            progressColor:
                                                const Color(0xff75A488),
                                          ),
                                        )
                                    ],
                                  ),
                          ),
                        ],
                      ),

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceSize.width * 0.05),
                        // * Scroll bar to assist user when scrolling
                        child: ScrollbarTheme(
                          data: const ScrollbarThemeData(
                            crossAxisMargin: -13,
                            mainAxisMargin: 30,
                          ),
                          child: Scrollbar(
                            radius: const Radius.circular(16.83),
                            thickness: 10,
                            child: ListView(
                              children: [
                                Text(
                                  "Details",
                                  style: GoogleFonts.poppins(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //  * Challenge details row to display challenge details
                                ChallengeDetailsRow(
                                  iconURL:
                                      "assets/icons/challenge_details_calendar.svg",
                                  description:
                                      "${Jiffy.parse(startDateTime!).format(pattern: "do MMMM yyyy")} - ${Jiffy.parse(endDateTime!).format(pattern: "do MMMM yyyy")}",
                                ),

                                const SizedBox(
                                  height: 13,
                                ),
                                ChallengeDetailsRow(
                                    iconURL:
                                        "assets/icons/challenge_details_clock.svg",
                                    description: challengeType == "event"
                                        ? "${Jiffy.parse(startDateTime!).format(pattern: "hh:mm a").toLowerCase()} - ${Jiffy.parse(endDateTime!).format(pattern: "hh:mm a").toLowerCase()}"
                                        : "${Jiffy.parse(endDateTime!).diff(Jiffy.parse(startDateTime!), unit: Unit.day).toString()} days duration"),
                                const SizedBox(
                                  height: 13,
                                ),
                                ChallengeDetailsRow(
                                    iconURL:
                                        "assets/icons/challenge_details_location.svg",
                                    description:
                                        "${state.challenge.location}, ${state.challenge.country}"),
                                const SizedBox(
                                  height: 13,
                                ),
                                ChallengeDetailsRow(
                                    iconURL:
                                        "assets/icons/challenge_details_users.svg",
                                    description:
                                        "${state.challenge.acceptedParticipants.length} out of ${state.challenge.maximumParticipants} Participants Joined"),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  (challengeType == "event")
                                      ? 'About Event'
                                      : "Instructions",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF1E1E1E),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                //  * challenge description
                                Text(
                                  state.challenge.description,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (ruleList!.isNotEmpty)
                                  Text(
                                    challengeType == "challenge"
                                        ? 'Challenge Rules'
                                        : "Event Rules",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF1E1E1E),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      List.generate(ruleList!.length, (index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}. ${ruleList![index]}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ],
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // * displaying the accept/submit button only if the signed user role is parent
                    // * current date should be after the challenge start date
                    if ((userRole == "parent" &&
                            currentDateTime.isAfter(challenge!.startDateTime) &&
                            currentDateTime.isBefore(challenge!.endDateTime)) ||
                        isSubmitted!)
                      Container(
                        margin: EdgeInsets.all(deviceSize.width * 0.05),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              // * If not accepteed, Parent agreement form (open in a fullscreen dialog). Otherwise submit form
                              if (!isAccepted!) {
                                showGeneralDialog(
                                    context: context,
                                    barrierColor: Colors.white,
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return ParentAgreement(
                                        onAccept: () {
                                          context
                                              .read<ChallengeDetailsBloc>()
                                              .add(AcceptChallengeEvent(
                                                  state.challenge.id!));
                                        },
                                      );
                                    });
                              } else if (isAccepted! && !isSubmitted!) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChallengeSubmission(
                                              challenge: state.challenge,
                                            )));
                              } else if (isSubmitted!) {
                                context.read<SubmissionViewBloc>().add(
                                    FetchSubmissionEvent(state.challenge.id!));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChallengeSubmissionView(
                                              challenge: state.challenge,
                                            )));
                              }
                              // todo add challenge submit form
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.8),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 17.88)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text(
                              (!isAccepted!)
                                  ? "Join the Challenge"
                                  : (isSubmitted!)
                                      ? "View Submission"
                                      : "Submit the Challenge",
                              style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                  ],
                )
              : (state is ChallengeLoading)
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 5,
                        color: Color(0xff75A488),
                      ),
                    )
                  : Container(),
        );
      },
    );
  }
}
