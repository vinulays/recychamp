import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import 'package:recychamp/screens/EducationalResources/article_model.dart';

class ArticleContent extends StatelessWidget {
  final Article articlels;
  ArticleContent({required this.articlels});

  //final Article article=Article(articleImage: null, articleTitle: Null, description: null);
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    // margin:
    // EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                articlels.articleImage,
                width: MediaQuery.of(context).size.width,
                height: 262,
                fit: BoxFit.cover,
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
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.05),
              child: Text(
                articlels.articleTitle,
                style: kFontFamily(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ]),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  child: Text(
                    "${DateFormat('d MMMM yyyy').format(articlels.modifiedDate)}",
                    style: kFontFamily(
                        color: const Color.fromRGBO(61, 61, 61, 0.65),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
            width: double.infinity,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  articlels.content,
                  style: kFontFamily(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                  textAlign: TextAlign.justify,
                )),
          )
        ],
      ),
    );
  }
}
