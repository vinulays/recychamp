import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:recychamp/models/challenge.dart";
import 'package:recychamp/screens/ChallengeDetails/challenge_details.dart';
import "package:recychamp/screens/Challenges/bloc/challenges_bloc.dart";
import "package:recychamp/ui/challenge_card.dart";
import "package:recychamp/ui/challenge_filters_bottom_sheet.dart";
import "package:recychamp/utils/challenges.dart";

class Challenges extends StatefulWidget {
  const Challenges({super.key});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  List<Challenge> challenges = challengeList;

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder: (context, state) {
        final challengesBloc = BlocProvider.of<ChallengesBloc>(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
            onRefresh: () async {
              challengesBloc.add(FetchChallengesEvent());
            },
            child: Column(
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
                            "Challenges",
                            style: GoogleFonts.almarai(
                              // color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      // todo Settings button (must link to settings page)
                      SvgPicture.asset(
                        "assets/icons/Settings.svg",
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  child: TextField(
                    style: GoogleFonts.almarai(
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(14),
                        prefixIconConstraints:
                            const BoxConstraints(maxHeight: 26, minWidth: 26),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 13, right: 10),
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                          ),
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 26, minWidth: 26),
                        // todo filter icon must open filter menu
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              // * filter bottom drawer
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ChallengeFiltersBottomSheet();
                                  });
                            },
                            child: SvgPicture.asset(
                              "assets/icons/filter.svg",
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xffE6EEEA),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.62),
                        ),
                        hintStyle: GoogleFonts.almarai(
                            fontSize: 17, color: const Color(0xff75A488)),
                        hintText: "Search Challenges"),
                  ),
                ),

                // * if challenges are loading, displays a loading circle
                if (state is ChallengesLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 5,
                        color: Color(0xff75A488),
                      ),
                    ),
                  ),
                if (state is ChallengesLoaded)
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.challenges.length,
                        itemBuilder: (BuildContext context, index) {
                          // * Gesture detector to navigate to details page when clicked on a challenge card
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChallengeDetails(
                                    challenge: state.challenges[index],
                                  ),
                                ),
                              );
                            },
                            child: ChallengeCard(
                              challenge: state.challenges[index],
                            ),
                          );
                        }),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
