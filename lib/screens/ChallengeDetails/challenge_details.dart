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
import 'package:recychamp/screens/ChallengeSubmission/challenge_submission.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/ParentAgreement/parent_agreement.dart';
import 'package:recychamp/ui/challenge_details_row.dart';
import 'package:recychamp/utils/challenge_categories.dart';

class ChallengeDetails extends StatefulWidget {
  final Challenge challenge;
  const ChallengeDetails({super.key, required this.challenge});

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

    String? challengeType = widget.challenge.type;
    String startDateTime = widget.challenge.startDateTime.toString();
    String endDateTime = widget.challenge.endDateTime.toString();
    DateTime currentDateTime = DateTime.now();

    List<String> acceptedParticipants = widget.challenge.acceptedParticipants;
    List<String> ruleList = widget.challenge.rules.split(";");

    var isDialOpen = ValueNotifier<bool>(false);

    // * Wrapping the widget with the bloc builder
    return BlocBuilder<ChallengeDetailsBloc, ChallengeDetailsState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: (userRole == "admin" || userRole == "organizer")
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 80, right: 12),
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
                                    challenge: widget.challenge,
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
                                                        widget.challenge.id!),
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
          body: Column(
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
                        colors: [Colors.black.withOpacity(0), Colors.black],
                      ).createShader(bounds);
                    },
                    child: CachedNetworkImage(
                      imageUrl: widget.challenge.imageURL,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 292,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
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
                  //  * offline / online badge (if only the type is a challenge)
                  if (challengeType == "challenge")
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
                                          widget.challenge.startDateTime)) &&
                                      currentDateTime.isBefore(
                                          widget.challenge.endDateTime))
                                  ? Colors.green
                                  : Colors.red,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: ((currentDateTime.isAfter(widget
                                              .challenge.startDateTime)) &&
                                          currentDateTime.isBefore(
                                              widget.challenge.endDateTime))
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
                                          widget.challenge.startDateTime)) &&
                                      currentDateTime.isBefore(
                                          widget.challenge.endDateTime))
                                  ? "online"
                                  : "offline",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w700),
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
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              challengeCategories
                                  .firstWhere((category) =>
                                      category.id ==
                                      widget.challenge.categoryId)
                                  .name,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w400),
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
                      widget.challenge.title,
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  )
                ],
              ),

              // * If challenge is accepted, display the progress bar
              // todo: check the logged user has accepted the challenge
              if (acceptedParticipants.contains(userId) &&
                  challengeType == "challenge")
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'You have ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: '3 days',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' to complete the challenge !',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: deviceSize.width * 0.01),
                            child: LinearPercentIndicator(
                              barRadius: const Radius.circular(16.83),
                              lineHeight: 20.0,
                              percent: 0.35,
                              animation: true,
                              animationDuration: 1000,
                              backgroundColor: const Color(0xffC8E8D5),
                              progressColor: const Color(0xff75A488),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
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
                                "${Jiffy.parse(startDateTime).format(pattern: "do MMMM yyyy")} - ${Jiffy.parse(endDateTime).format(pattern: "do MMMM yyyy")}",
                          ),

                          const SizedBox(
                            height: 13,
                          ),
                          ChallengeDetailsRow(
                              iconURL:
                                  "assets/icons/challenge_details_clock.svg",
                              description: challengeType == "event"
                                  ? "${Jiffy.parse(startDateTime).format(pattern: "hh:mm a").toLowerCase()} - ${Jiffy.parse(endDateTime).format(pattern: "hh:mm a").toLowerCase()}"
                                  : "${Jiffy.parse(endDateTime).diff(Jiffy.parse(startDateTime), unit: Unit.day).toString()} days duration"),
                          const SizedBox(
                            height: 13,
                          ),
                          ChallengeDetailsRow(
                              iconURL:
                                  "assets/icons/challenge_details_location.svg",
                              description:
                                  "${widget.challenge.location}, ${widget.challenge.country}"),
                          const SizedBox(
                            height: 13,
                          ),
                          ChallengeDetailsRow(
                              iconURL:
                                  "assets/icons/challenge_details_users.svg",
                              description:
                                  "${widget.challenge.acceptedParticipants.length} out of ${widget.challenge.maximumParticipants} Participants Joined"),
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
                            widget.challenge.description,
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (ruleList.isNotEmpty)
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
                            children: List.generate(ruleList.length, (index) {
                              return Column(
                                children: [
                                  Text(
                                    "${index + 1}. ${ruleList[index]}",
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
              Container(
                margin: EdgeInsets.all(deviceSize.width * 0.05),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // * If not accepteed, Parent agreement form (open in a fullscreen dialog). Otherwise submit form
                      if (!acceptedParticipants.contains(userId)) {
                        showGeneralDialog(
                            context: context,
                            barrierColor: Colors.white,
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return ParentAgreement(
                                onAccept: () {
                                  context.read<ChallengeDetailsBloc>().add(
                                      AcceptChallengeEvent(
                                          userId!, widget.challenge.id!));
                                },
                              );
                            });
                      } else if (acceptedParticipants.contains(userId)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChallengeSubmission(
                                      challenge: widget.challenge,
                                    )));
                      }
                      // todo add challenge submit form
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
                      (!acceptedParticipants.contains(userId))
                          ? "Join the Challenge"
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
          ),
        );
      },
    );
  }
}
