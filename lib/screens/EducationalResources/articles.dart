import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:recychamp/screens/EducationalResources/article_content.dart';
import 'package:recychamp/models/article_model.dart';
import 'package:recychamp/screens/EducationalResources/bloc/article_details_bloc.dart';
import 'package:recychamp/services/article_service.dart';
import 'package:recychamp/ui/article_filter.dart';
import 'package:recychamp/ui/article_form.dart';

class EducationalResource extends StatefulWidget {
  const EducationalResource({super.key});

  @override
  State<EducationalResource> createState() => _EducationalResourceState();
}

class _EducationalResourceState extends State<EducationalResource> {
  // late List<Article> allArticles = [];
  bool isExpanded = false;
  String? userRole;

  @override
  void initState() {
    super.initState();
    
    //  fetchArticles();
    if (mounted) {
      getUserRole();
    }
  }

  // // Define a function to add new articles
  // void addArticle(Article newArticle) {
  //   setState(() {
  //     allArticles.add(newArticle);
  //   });
  // }

  Future<void> getUserRole() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        String? role = userSnapshot.get("role");

        setState(() {
          userRole = role;
        });
      }
    } catch (error) {
      throw Exception("Error getting role: $error");
    }
  }

  // void fetchArticles() async {
  //   try {
  //     List<Article> articles = await ArticleService(
  //       firestore: FirebaseFirestore.instance,
  //       storage: FirebaseStorage.instance,
  //     ).getArticles();
  //     print('Fetched Articles: $articles');
  //     setState(() {
  //       // Filter articles where articleType is "Nature" and articleType is not null
  //       allArticles = articles;
  //     });
  //   } catch (e) {
  //     print('Error fetching articles: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return BlocBuilder<ArticleDetailsBloc, ArticleDetailsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: (userRole == "admin" || userRole == "organizer")
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      // Navigate to the new page where users can add articles
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AricleForms(), // Replace with your new page widget
                        ),
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
                )
              : Container(),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  child: Row(
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
                      Text("Articles",
                          style: kFontFamily(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      const SizedBox(width: 180),
                      const Icon(Icons.settings)
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
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
                                    return const ArticleFilter();
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
                        hintText: "Search Articles"),
                  ),
                ),
                if (state is ArticleDetailsLoading)
                 
                   Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 5,
                        color: Color(0xff75A488),
                      ),
                    ),
                  
                if (state is ArticleDetailsLoaded)
                  Column(
                    children: [
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceData.size.width * 0.05),
                        child: Row(
                          children: [
                            Text("Nature",
                                style: kFontFamily(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 280,
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceData.size.width * 0.05),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.articles.length,
                          separatorBuilder: (context, _) =>
                              const SizedBox(width: 0),
                          itemBuilder: (context, index) {
                            Article article = state.articles[index];
                            // Check if articles are being printed
                            if (article.articleType == "Nature") {
                              return articleCard(articleData: article);
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceData.size.width * 0.05),
                        child: Row(
                          children: [
                            Text("Plants and Trees",
                                style: kFontFamily(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 280,
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceData.size.width * 0.05),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.articles.length,
                          separatorBuilder: (context, _) =>
                              const SizedBox(width: 0),
                          itemBuilder: (context, index) {
                            Article article = state.articles[index];
                            // Check if articles are being printed
                            if (article.articleType == "PlantTrees") {
                              return articleCard(articleData: article);
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceData.size.width * 0.05),
                        child: Row(
                          children: [
                            Text("Recycling methods",
                                style: kFontFamily(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 280,
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceData.size.width * 0.05),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.articles.length,
                          separatorBuilder: (context, _) =>
                              const SizedBox(width: 0),
                          itemBuilder: (context, index) {
                            Article article = state.articles[index];
                            // Check if articles are being printed
                            if (article.articleType == "Recycling") {
                              return articleCard(articleData: article);
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  )

                //------

                //---------

                //-------------

                // Container(
                //   height: 50,
                //   margin: EdgeInsets.symmetric(
                //       horizontal: deviceData.size.width * 0.05),
                //   child: Row(
                //     children: [
                //       Text("Eco-Friendly Products",
                //           style: kFontFamily(
                //             color: Colors.black,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w700,
                //           )),
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 280,
                //   margin: EdgeInsets.symmetric(
                //       horizontal: deviceData.size.width * 0.05),
                //   child: ListView.separated(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: allArticles.length,
                //     separatorBuilder: (context, _) => const SizedBox(width: 12),
                //     itemBuilder: (context, index) {
                //       Article article = allArticles[index];
                //       // Check if articles are being printed
                //       if (article.articleType == "Eco-Friendly-Products") {
                //         return articleCard(articleData: article);
                //       } else {
                //         return Container();
                //       }
                //     },
                //   ),
                // ),

                //---

                // Container(
                //   height: 50,
                //   margin: EdgeInsets.symmetric(
                //       horizontal: deviceData.size.width * 0.05),
                //   child: Row(
                //     children: [
                //       Text("Recycling Challenges",
                //           style: kFontFamily(
                //             color: Colors.black,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w700,
                //           )),
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 280,
                //   margin: EdgeInsets.symmetric(
                //       horizontal: deviceData.size.width * 0.05),
                //   child: ListView.separated(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: allArticles.length,
                //     separatorBuilder: (context, _) => const SizedBox(width: 12),
                //     itemBuilder: (context, index) {
                //       Article article = allArticles[index];
                //       // Check if articles are being printed
                //       if (article.articleType == "RecyChallenges") {
                //         return articleCard(articleData: article);
                //       } else {
                //         return Container();
                //       }
                //     },
                //   ),
                // ),

                // //----
                // Container(
                //   height: 50,
                //   margin: EdgeInsets.symmetric(
                //       horizontal: deviceData.size.width * 0.05),
                //   child: Row(
                //     children: [
                //       Text("Others",
                //           style: kFontFamily(
                //             color: Colors.black,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w700,
                //           )),
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 280,
                //   margin: EdgeInsets.symmetric(
                //       horizontal: deviceData.size.width * 0.05),
                //   child: ListView.separated(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: allArticles.length,
                //     separatorBuilder: (context, _) => const SizedBox(width: 0),
                //     itemBuilder: (context, index) {
                //       Article article = allArticles[index];
                //       // Check if articles are being printed
                //       if (article.articleType == "Others") {
                //         return articleCard(articleData: article);
                //       } else {
                //         return Container();
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget articleCard({required Article articleData}) => Container(
        //  margin: const EdgeInsets.only(horizontal: 15),
        width: 250,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.83),
              child: Material(
                child: Ink.image(
                  image: NetworkImage(articleData.articleImage),
                  width: 230,
                  height: 140,
                  padding: const EdgeInsetsDirectional.only(start: 9.0),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleContent(
                          articlels: articleData,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(16.83),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Text(
                maxLines: 3,
                articleData.articleTitle,
                style: kFontFamily(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
                softWrap: true,
              ),
            ),
            const SizedBox(
              width: 12,
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Text(
                articleData.description,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
}
