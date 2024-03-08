import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:recychamp/ui/challenge_filters_bottom_sheet.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Colors.black.withOpacity(0.10000000149011612),
          ),
          borderRadius: BorderRadius.circular(12.62),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBpY3xlbnwwfHwwfHx8MA%3D%3D"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.32,
                      ),
                    ),
                    const Text(
                      'Posted Jan 7',
                      style: TextStyle(
                        color: Color(0xFF747474),
                        fontSize: 11,
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.22,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'I  completed this challenge! omg!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w700,
                letterSpacing: -0.40,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 200,
              decoration: ShapeDecoration(
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1677756430573-b48460510e0e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZWNvZnJpZW5kbHl8ZW58MHx8MHx8fDA%3D"),
                      fit: BoxFit.cover),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.83))),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante',
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 14,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(
                  size: 30,
                  circleColor:
                      const CircleColor(start: Colors.red, end: Colors.red),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Colors.red,
                    dotSecondaryColor: Colors.red,
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      CupertinoIcons.heart_fill,
                      color: isLiked ? Colors.red : Colors.grey,
                      size: 30,
                    );
                  },
                  likeCount: 665,
                  // countBuilder: (int count, bool isLiked, String text) {
                  //   var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                  //   Widget result;
                  //   if (count == 0) {
                  //     result = Text(
                  //       "love",
                  //       style: TextStyle(color: color),
                  //     );
                  //   } else
                  //     result = Text(
                  //       text,
                  //       style: TextStyle(color: color),
                  //     );
                  //   return result;
                  // },
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListView(children: [
                                    Container(
                                      margin: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                width: 46,
                                                height: 46,
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww"),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.black
                                                          .withOpacity(0.15)),
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 7),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Chamoth Mendis",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        Text(
                                                          "gshkjkl  jjblbljknlknklnlk lknlknlknklnknk sdhardkkkdbnbjkbsajkbcjk asguiguisgdui ashjdbj",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: deviceData.size.width * 0.05),
                                  child: TextField(
                                    onSubmitted: (query) {},
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(14),
                                        suffixIconConstraints:
                                            const BoxConstraints(
                                                maxHeight: 26, minWidth: 26),
                                        suffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: InkWell(
                                            onTap: () {},
                                            child: const Icon(Icons.send),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xffE6EEEA),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(12.62),
                                        ),
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 17,
                                            color: const Color(0xff75A488)),
                                        hintText: "Comment as Chamoth Mendis"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.comment_rounded,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Comments (57)",
                        style: GoogleFonts.poppins(fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
