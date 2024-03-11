import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/screens/ChallengeSubmissionView/bloc/submission_view_bloc.dart';

class ChallengeSubmissionView extends StatefulWidget {
  final Challenge challenge;
  const ChallengeSubmissionView({super.key, required this.challenge});

  @override
  State<ChallengeSubmissionView> createState() =>
      _ChallengeSubmissionViewState();
}

class _ChallengeSubmissionViewState extends State<ChallengeSubmissionView> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<SubmissionViewBloc, SubmissionViewState>(
      builder: (context, state) {
        return Scaffold(
            body: (state is SubmissionLoaded)
                ? Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: deviceSize.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 41.86,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                "assets/icons/go_back.svg",
                                colorFilter: const ColorFilter.mode(
                                    Colors.black, BlendMode.srcIn),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Submission details",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: ScrollbarTheme(
                          data: const ScrollbarThemeData(
                            crossAxisMargin: -15,
                            mainAxisMargin: 30,
                          ),
                          child: Scrollbar(
                              radius: const Radius.circular(16.83),
                              thickness: 4,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Title: ",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.challenge.title,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black
                                                  .withOpacity(0.50),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Instructions: ",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.challenge.description,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black
                                                  .withOpacity(0.50),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Due Date & Time: ",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: Jiffy.parse(widget
                                                    .challenge.endDateTime
                                                    .toString())
                                                .format(
                                                    pattern:
                                                        "do MMMM yyyy hh:mm a"),
                                            style: GoogleFonts.poppins(
                                              color: Colors.black
                                                  .withOpacity(0.50),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Submitted Date & Time: ",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: Jiffy.parse(state
                                                    .submission.submittedAt
                                                    .toString())
                                                .format(
                                                    pattern:
                                                        "do MMMM yyyy hh:mm:ss a"),
                                            style: GoogleFonts.poppins(
                                              color: Colors.black
                                                  .withOpacity(0.50),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "Briefly describe what you did in this challenge: ",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: state.submission.description,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black
                                                  .withOpacity(0.50),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Submission Photos:",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 20,
                                      children: List.generate(
                                        state.submission.imageURLs.length,
                                        (index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: SizedBox(
                                              child: CachedNetworkImage(
                                                imageUrl: state.submission
                                                    .imageURLs[index],
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  height: 170,
                                                  decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.83))),
                                                ),
                                                placeholder: (context, url) =>
                                                    const SizedBox(
                                                  height: 170,
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircularProgressIndicator()
                                                    ],
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // * challenge rating
                                    Text(
                                      "Challenge Rating:",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      glow: false,
                                      initialRating: state.submission.rating,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemPadding:
                                          const EdgeInsets.only(right: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "Briefly describe your experiance in this challenge (optional): ",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: state.submission.experience,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black
                                                  .withOpacity(0.50),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )),
                        ))
                      ],
                    ),
                  )
                : (state is SubmissionLoading)
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                          strokeWidth: 5,
                          color: Color(0xff75A488),
                        ),
                      )
                    : (Container()));
      },
    );
  }
}
