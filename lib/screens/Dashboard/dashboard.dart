import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/screens/ChallengeDetails/bloc/challenge_details_bloc.dart';
import 'package:recychamp/screens/ChallengeDetails/challenge_details.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/Shop/shop.dart';
import 'package:recychamp/screens/Calendar/calendar_event.dart';
import 'package:recychamp/screens/EducationalResources/articles.dart';
import 'package:recychamp/ui/home_three_row_button.dart';
import 'package:recychamp/ui/latest_challenges_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xff75A488),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: deviceData.size.width * 0.07),
                // * Headline row with settings button
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // * Headline left column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // todo greeting must change according to the time of the day
                        Text(
                          "Good Morning",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Susan Clay",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    // todo Settings button (must link to settings page)
                    SvgPicture.asset(
                      "assets/icons/Settings.svg",
                      height: 24,
                      width: 24,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 58,
              ),
              Expanded(
                // * Curved section
                child: FractionallySizedBox(
                  // heightFactor: 0.85,
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
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // * Profile picture frame
                        Positioned(
                          height: 84.15,
                          top: -84.15 / 2,
                          child: Container(
                            width: 84.15,
                            height: 84.15,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(0.00, 1.00),
                                end: Alignment(0, -1),
                                colors: [
                                  Color(0xFFFEAA42),
                                  Color(0xFFFBA33F),
                                  Color(0xFFF59838),
                                  Color(0xFFF29135),
                                  Color(0xFFF18F34),
                                  Color(0xFFF28F3E),
                                  Color(0xFFF38E5A),
                                  Color(0xFFF68D88),
                                  Color(0xFFF78C9B),
                                  Color(0xFFF08672)
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.83),
                              ),
                            ),
                          ),
                        ),
                        // * remaining content
                        Column(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 50),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/gold-medal.svg",
                                      height: 32.08,
                                      width: 32.08,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 75,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "Your fresh and green comfortable ",
                                                    style: GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF1E1E1E),
                                                        fontSize: 27,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  TextSpan(
                                                    text: "place",
                                                    style: GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF75A488),
                                                        fontSize: 27,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),

                                          // * 3 button row
                                          SizedBox(
                                            height: 113.60,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      deviceData.size.width *
                                                          0.05),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HomeThreeRowButton(
                                                    iconURL:
                                                        "assets/icons/home-article.svg",
                                                    description: "Articles",
                                                    widget:
                                                        EducationalResource(),
                                                  ),
                                                  HomeThreeRowButton(
                                                    iconURL:
                                                        "assets/icons/home-cart.svg",
                                                    description: "Visit Shop",
                                                    widget: Shop(),
                                                  ),
                                                  HomeThreeRowButton(
                                                    iconURL:
                                                        "assets/icons/home-calendar.svg",
                                                    description: "Calendar",
                                                    widget: CalendarEvent(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 25,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      deviceData.size.width *
                                                          0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Latest Challenges",
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF1E1E1E),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // * Latest Challenges

                                          if (state is ChallengesLoaded)
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    state.challenges.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      final challengeId = state
                                                          .challenges[index].id;
                                                      context
                                                          .read<
                                                              ChallengeDetailsBloc>()
                                                          .add(FetchChallengeDetailsEvent(
                                                              challengeId!));

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChallengeDetails(
                                                            challenge: state
                                                                    .challenges[
                                                                index],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: LatestChallengeCard(
                                                        challenge: state
                                                            .challenges[index]),
                                                  );
                                                },
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
