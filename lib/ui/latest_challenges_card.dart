import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/models/challenge.dart';

class LatestChallengeCard extends StatelessWidget {
  final Challenge challenge;
  const LatestChallengeCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          left: deviceWidth * 0.05,
          right: deviceWidth * 0.05,
          bottom: deviceWidth * 0.02),
      width: double.infinity,
      height: 100.98,
      padding: const EdgeInsets.all(8.41),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.83),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: challenge.imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  height: 84.15,
                  width: 84.15,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.62))),
                ),
                placeholder: (context, url) => const Center(
                  // child: CircularProgressIndicator(),
                  child: SizedBox(
                    height: 84.15,
                    width: 84.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // Container(
              //   width: 84.15,
              //   height: 84.15,
              //   decoration: ShapeDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(challenge.imageURL),
              //       fit: BoxFit.fill,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12.62),
              //     ),
              //   ),
              // ),
              const SizedBox(
                width: 27.35,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      challenge.title,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1E1E1E),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      challenge.location,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF747474),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 17,
                        height: 16,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFFFB61D),
                          shape: StarBorder(
                            points: 5,
                            innerRadiusRatio: 0.38,
                            pointRounding: 0.53,
                            valleyRounding: 0,
                            rotation: 0,
                            squash: 0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: 24.19,
                        height: 21.04,
                        child: Text(
                          challenge.rating.toString(),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF1E1E1E),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
