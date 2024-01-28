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
          )
        ],
      ),
    );
  }
}
