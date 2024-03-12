import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:recychamp/models/challenge.dart';

class ChallengeCard extends StatefulWidget {
  final Challenge challenge;
  const ChallengeCard({super.key, required this.challenge});

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.only(
          left: deviceData.size.width * 0.05,
          right: deviceData.size.width * 0.05,
          bottom: deviceData.size.width * 0.05),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.83),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0xFFE1E1E1),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // * Challenge thumbnail
          CachedNetworkImage(
            imageUrl: widget.challenge.imageURL,
            imageBuilder: (context, imageProvider) => Container(
              height: 170,
              decoration: ShapeDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.83))),
            ),
            placeholder: (context, url) => const SizedBox(
              height: 170,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          // * Title and percentage
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.challenge.title,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "${widget.challenge.location}, ${widget.challenge.country}",
                      style: GoogleFonts.poppins(
                        color: const Color(0xA53D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 0),
                  child: CircularPercentIndicator(
                    radius: 35.0,
                    lineWidth: 9.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: widget.challenge.acceptedParticipants.length /
                        widget.challenge.maximumParticipants,
                    center: Text(
                      "${((widget.challenge.acceptedParticipants.length / widget.challenge.maximumParticipants) * 100).round()}%",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                    ),
                    progressColor: const Color(0xFF75A488),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Text(
              widget.challenge.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.6000000238418579),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Difficulty: ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: widget.challenge.difficulty,
                          style: GoogleFonts.poppins(
                            color: (widget.challenge.difficulty == "High")
                                ? const Color(0xFFB53131)
                                : (widget.challenge.difficulty == "Low")
                                    ? const Color.fromARGB(255, 62, 200, 62)
                                    : const Color.fromARGB(255, 233, 233, 73),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/challenge_users.svg"),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.challenge.acceptedParticipants.length}/${widget.challenge.maximumParticipants}",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.4000000059604645),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
