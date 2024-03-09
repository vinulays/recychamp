import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/screens/CreatePost/createpost.dart';
import 'package:recychamp/ui/post-card.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    //Screen Responsiveness
    var deviceData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              // Image with text overlay
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 430,
                  height: 290,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Rectangle.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 150, left: 30, right: 0, bottom: 0),
                      child: Text(
                        'Welcome To The',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.64,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 195, left: 30, right: 0, bottom: 0),
                    child: Text(
                      'Community!',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.64,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 240, left: 30, right: 0, bottom: 10),
                    child: Text(
                      'Share your challange outcomes and motivate others',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
            child: TextField(
              // * calling search event when user clicks ok on the keyboard after editing the search field
              onSubmitted: (query) {},

              style: GoogleFonts.poppins(
                fontSize: 17,
              ),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(14),
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 26, minWidth: 26),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 10),
                    child: InkWell(
                      // * search challenges when tapped search icon
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                      ),
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
                              return Container();
                              // return ChallengeFiltersBottomSheet(
                              //   applyFiltersCallBack: applyFilters,
                              //   initialFilters: selectedFilters,
                              //   initialCompletedSelected:
                              //       selectedIsCompleted,
                              // );
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
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, color: const Color(0xff75A488)),
                  hintText: "Search Posts"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const PostCard()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the floating action button
          showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext buildContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return const CreatePost();
            },
          );
        },
        backgroundColor: const Color(0xFF75A488),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
