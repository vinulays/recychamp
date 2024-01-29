import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/models/challenge.dart';

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
            margin: EdgeInsets.all(deviceSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        "assets/icons/challenge_details_calendar.svg"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Monday, 17 January 2024",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xA53D3D3D),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        "assets/icons/challenge_details_clock.svg"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "10.00 a.m - 04.00 p.m",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xA53D3D3D),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        "assets/icons/challenge_details_location.svg"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Viharamahadevi Park, Colombo 07, Sri Lanka",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xA53D3D3D),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
