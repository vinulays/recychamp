import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/screens/ChallengeDetails/bloc/challenge_details_bloc.dart';
import 'package:recychamp/screens/ChallengeDetails/challenge_details.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/EducationalResources/article_content.dart';
import 'package:recychamp/screens/EducationalResources/bloc/article_details_bloc.dart';
import 'package:recychamp/ui/challenge_trending_card.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
// * 0.05
    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Discover",
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "This Week Trends 🔥",
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    style: GoogleFonts.poppins(
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
                        filled: true,
                        fillColor: const Color(0xffE6EEEA),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.62),
                        ),
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 17, color: const Color(0xff75A488)),
                        hintText: "Challenges, Articles, or Items"),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hot Challenges",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is ChallengesLoaded)
                      SizedBox(
                        height: 300,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.challenges.length,
                          separatorBuilder: (context, _) =>
                              const SizedBox(width: 5),
                          itemBuilder: (context, index) {
                            // Check if articles are being printed

                            return GestureDetector(
                              onTap: () {
                                context.read<ChallengeDetailsBloc>().add(
                                    FetchChallengeDetailsEvent(
                                        state.challenges[index].id!));

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChallengeDetails(),
                                  ),
                                );
                              },
                              child: ChallengeTrendCard(
                                  challenge: state.challenges[index]),
                            );
                          },
                        ),
                      ),
                    Text(
                      "Trending Articles",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<ArticleDetailsBloc, ArticleDetailsState>(
                        builder: (context, state) {
                      if (state is ArticleDetailsLoaded) {
                        return Column(
                          children: List.generate(
                            state.articles.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleContent(
                                      articlels: state.articles[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                width: double.infinity,
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
                                  children: [
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: state
                                              .articles[index].articleImage,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 104.15,
                                            width: 104.15,
                                            decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.62))),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                            // child: CircularProgressIndicator(),
                                            child: SizedBox(
                                              height: 104.15,
                                              width: 104.15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CircularProgressIndicator()
                                                ],
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.articles[index]
                                                    .articleType,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                state.articles[index]
                                                    .articleTitle,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    })
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
