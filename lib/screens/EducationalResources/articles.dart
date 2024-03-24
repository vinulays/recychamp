import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:recychamp/screens/EducationalResources/article_content.dart';
import 'package:recychamp/models/article_model.dart';
import 'package:recychamp/screens/EducationalResources/bloc/article_details_bloc.dart';
import 'package:recychamp/screens/Settings/settings.dart';
import 'package:recychamp/services/article_service.dart';
import 'package:recychamp/ui/article_filter.dart';
import 'package:recychamp/ui/article_form.dart';
import 'package:test/test.dart';

class EducationalResource extends StatefulWidget {
  const EducationalResource({super.key});

  @override
  State<EducationalResource> createState() => _EducationalResourceState();
}

class _EducationalResourceState extends State<EducationalResource> {
  bool isExpanded = false;
  String? userRole;
  final TextEditingController _searchController = TextEditingController();
  late ArticleDetailsBloc _articleDetailsBloc;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getUserRole();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _articleDetailsBloc.add(ArticlesResetsEvent());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _articleDetailsBloc = BlocProvider.of<ArticleDetailsBloc>(context);
    super.didChangeDependencies();
  }

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

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return BlocBuilder<ArticleDetailsBloc, ArticleDetailsState>(
      builder: (context, state) {
        final articleBloc = BlocProvider.of<ArticleDetailsBloc>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: (userRole == "admin" || userRole == "organizer")
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AricleForms(), // add article
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
                      const SizedBox(width: 165),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  child: TextField(
                    onSubmitted: (query) {
                      articleBloc.add(SearchArticlesEvent(
                          _searchController.text)); // search
                    },
                    controller: _searchController,
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
                            // search when clicked search
                            onTap: () {
                              articleBloc.add(
                                  SearchArticlesEvent(_searchController.text));
                            },
                            child: SvgPicture.asset(
                              "assets/icons/search.svg",
                            ),
                          ),
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 26, minWidth: 26),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  // fillter bottom showed
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
                const SizedBox(
                  height: 20,
                ),
                if (state
                    is ArticleDetailsLoading) // loading when articles laoding

                  const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      strokeWidth: 5,
                      color: Color(0xff75A488),
                    ),
                  ),
                if (state
                    is ArticlesSearching) // loading when article searching
                  const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      strokeWidth: 5,
                      color: Color(0xff75A488),
                    ),
                  ),
                if (state is ArticleDetailsLoaded) // article loaded
                  (state.articles.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Column(
                            children: [
                              if (state.articles.any(
                                  (article) => article.articleType == "Nature"))
                                Container(
                                  margin: EdgeInsets.only(right: 9),
                                  height: 350,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.articles.length,
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(width: 0),
                                    itemBuilder: (context, index) {
                                      Article article = state.articles[index];
                                      if (article.articleType == "Nature") {
                                        return articleCard(
                                          articleData: article,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                              if (state.articles.any((article) =>
                                  article.articleType == "PlantTrees"))
                                Container(
                                  margin: EdgeInsets.only(right: 9),
                                  height: 350,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.articles.length,
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(width: 0),
                                    itemBuilder: (context, index) {
                                      Article article = state.articles[index];
                                      // Check if articles are being printed
                                      if (article.articleType == "PlantTrees") {
                                        return articleCard(
                                          articleData: article,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                              if (state.articles.any((article) =>
                                  article.articleType == "Eco-Friendly"))
                                Container(
                                  margin: EdgeInsets.only(right: 9),
                                  height: 350,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.articles.length,
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(width: 0),
                                    itemBuilder: (context, index) {
                                      Article article = state.articles[index];
                                      // Check if articles are being printed
                                      if (article.articleType ==
                                          "Eco-Friendly") {
                                        return articleCard(
                                          articleData: article,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                              if (state.articles.any((article) =>
                                  article.articleType == "Recy-Challenges"))
                                Container(
                                  margin: EdgeInsets.only(right: 9),
                                  height: 350,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.articles.length,
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(width: 0),
                                    itemBuilder: (context, index) {
                                      Article article = state.articles[index];
                                      // Check if articles are being printed
                                      if (article.articleType ==
                                          "Recy-Challenges") {
                                        return articleCard(
                                          articleData: article,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                              if (state.articles.any((article) =>
                                  article.articleType == "Recy-Guide"))
                                Container(
                                  margin: EdgeInsets.only(right: 9),
                                  height: 350,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.articles.length,
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(width: 0),
                                    itemBuilder: (context, index) {
                                      Article article = state.articles[index];
                                      // Check if articles are being printed
                                      if (article.articleType ==
                                          "Recy-Guides") {
                                        return articleCard(
                                          articleData: article,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                              if (state.articles.any(
                                  (article) => article.articleType == "Other"))
                                Container(
                                  margin: EdgeInsets.only(right: 9),
                                  height: 350,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.articles.length,
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(width: 0),
                                    itemBuilder: (context, index) {
                                      Article article = state.articles[index];
                                      // Check if articles are being printed
                                      if (article.articleType == "Other") {
                                        return articleCard(
                                          articleData: article,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: Center(
                                child: Text(
                                  "No Aricles found under that Search:(",
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget articleCard({required Article articleData}) => Container(
        width: 250,
        child: Column(
          children: [
            if (articleData.articleType == "Nature")
              Text(
                "Nature",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (articleData.articleType == "PlantTrees")
              Text(
                "Plant Trees",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (articleData.articleType == "Eco-Friendly")
              Text(
                "Eco-Friendly Products",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (articleData.articleType == "Recy-Challenges")
              Text(
                "Recycling Challenges",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (articleData.articleType == "Recy-Guides")
              Text(
                "Recycling Guides",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (articleData.articleType == "Other")
              Text(
                "Other",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.83),
              child: Material(
                child: CachedNetworkImage(
                  imageUrl: articleData.articleImage,
                  width: 230,
                  height: 140,
                  placeholder: (context, url) => const SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  // padding: const EdgeInsetsDirectional.only(start: 9.0),
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Ink.image(
                    image: imageProvider,
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
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
}
