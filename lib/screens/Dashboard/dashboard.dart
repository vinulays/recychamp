import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/screens/ChallengeDetails/bloc/challenge_details_bloc.dart';
import 'package:recychamp/screens/ChallengeDetails/challenge_details.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/Dashboard/bloc/badge_bloc.dart';
import 'package:recychamp/screens/Shop/shop.dart';
import 'package:recychamp/screens/Calendar/calendar_event.dart';
import 'package:recychamp/screens/EducationalResources/articles.dart';
import 'package:recychamp/ui/home_three_row_button.dart';
import 'package:recychamp/ui/latest_challenges_card.dart';
import 'package:recychamp/screens/Settings/settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    final currentTime = DateTime.now();

    const morningTime = TimeOfDay(hour: 0, minute: 0);
    const noonTime = TimeOfDay(hour: 12, minute: 0);
    const eveningTime = TimeOfDay(hour: 18, minute: 0);

    // * creating the greeting message based on the current time of the day
    String greeting = '';
    if (currentTime.hour >= morningTime.hour &&
        currentTime.hour < noonTime.hour) {
      greeting = 'Good Morning';
    } else if (currentTime.hour >= noonTime.hour &&
        currentTime.hour < eveningTime.hour) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

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
                        Text(
                          greeting,
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

                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Settings.svg",
                        height: 24,
                        width: 24,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                    ),
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
                        // todo: replace with signed user photo url
                        Positioned(
                          height: 84.15,
                          top: -84.15 / 2,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://images.unsplash.com/photo-1582887122254-f271875d0594?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzB8fGtpZHxlbnwwfHwwfHx8MA%3D%3D",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 84.15,
                              width: 84.15,
                              decoration: ShapeDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.83))),
                            ),
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.83)),
                              height: 84.15,
                              width: 84.15,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [CircularProgressIndicator()],
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
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
                                    BlocBuilder<BadgeBloc, BadgeState>(
                                      builder: (context, state) {
                                        if (state is BadgeLoading) {
                                          return Center(
                                              child: SizedBox(
                                                  height: 32,
                                                  width: 32,
                                                  child: Container()));
                                        } else if (state is BadgeLoaded) {
                                          return SvgPicture.asset(
                                            "assets/icons/${state.badge}-medal.svg",
                                            height: 32.08,
                                            width: 32.08,
                                          );
                                        } else {
                                          return const Center(
                                              child: Icon(Icons.error));
                                        }
                                      },
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
                                                              const ChallengeDetails(),
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
