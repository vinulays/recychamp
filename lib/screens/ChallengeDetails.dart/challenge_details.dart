import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/ui/challenge_details_row.dart';

class ChallengeDetails extends StatefulWidget {
  final Challenge challenge;
  const ChallengeDetails({super.key, required this.challenge});

  @override
  State<ChallengeDetails> createState() => _ChallengeDetailsState();
}

class _ChallengeDetailsState extends State<ChallengeDetails> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
                child: Container(
                  width: double.infinity,
                  height: 292,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/challenge_details_thumbnail_dummy.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
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
              // * category badge
              Positioned(
                top: 192,
                left: 25.58,
                child: Container(
                  width: 101,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.83),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tree Planting",
                        style: GoogleFonts.almarai(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              // * challenge title
              Positioned(
                top: 234,
                left: 25.58,
                child: Text(
                  widget.challenge.title,
                  style: GoogleFonts.almarai(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              )
            ],
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
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
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: GoogleFonts.almarai(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //  * Challenge details row to display challenge details
                      const ChallengeDetailsRow(
                          iconURL:
                              "assets/icons/challenge_details_calendar.svg",
                          description: "Monday, 17 January 2024"),
                      const SizedBox(
                        height: 13,
                      ),
                      const ChallengeDetailsRow(
                          iconURL: "assets/icons/challenge_details_clock.svg",
                          description: "10.00 a.m - 04.00 p.m"),
                      const SizedBox(
                        height: 13,
                      ),
                      const ChallengeDetailsRow(
                          iconURL:
                              "assets/icons/challenge_details_location.svg",
                          description:
                              "Viharamahadevi Park, Colombo 07, Sri Lanka"),
                      const SizedBox(
                        height: 13,
                      ),
                      const ChallengeDetailsRow(
                          iconURL: "assets/icons/challenge_details_users.svg",
                          description: "10 out of 100 Participants Joined"),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'About Challenge',
                        style: GoogleFonts.almarai(
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
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante",
                        style: GoogleFonts.almarai(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Challenge Rules',
                        style: GoogleFonts.almarai(
                          color: const Color(0xFF1E1E1E),
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "1. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. \n\n2. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante.Lorem ipsum dolor sit amet\n\n3. consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante",
                        style: GoogleFonts.almarai(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
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
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.8),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 93.61, vertical: 17.88)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: Text(
                  "Join the Challenge",
                  style: GoogleFonts.almarai(
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
  }
}
