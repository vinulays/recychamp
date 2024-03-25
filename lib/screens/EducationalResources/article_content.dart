import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:recychamp/screens/Calendar/constants.dart';
import 'package:recychamp/models/article_model.dart';
import 'package:recychamp/ui/article_form_update.dart';
import 'package:recychamp/screens/EducationalResources/bloc/article_details_bloc.dart';

class ArticleContent extends StatefulWidget {
  final Article articlels;

  ArticleContent({required this.articlels});

  @override
  _ArticleContentState createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  String? userRole;

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  Future<void> getUserRole() async {
    //fetch user from firebase
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
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: (userRole == "admin" || userRole == "organizer")
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        // navigate to update form
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateArticleForm(
                            article: widget.articlels,
                          ),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFF75A488),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                )
              : Container(),
          body: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.articlels.articleImage,
                    width: MediaQuery.of(context).size.width,
                    height: 262,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    ), // Placeholder widget while loading
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Positioned(
                    top: 41.9,
                    left: 25.6,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/go_back.svg",
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 42,
                    right: 35,
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 24,
                    ),
                  )
                ],
              ),
              Row(children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: deviceData.size.width * 0.05),
                    child: Text(
                      widget.articlels.articleTitle,
                      style: kFontFamily(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceData.size.width * 0.05),
                    child: Text(
                      widget.articlels.content,
                      style: kFontFamily(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
