import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import 'package:recychamp/screens/EducationalResources/article_model.dart';
import 'package:recychamp/utils/articles_data.dart';

class ArticleContent extends StatelessWidget {
  final Article articlels;
  ArticleContent({required this.articlels});

  //final Article article=Article(articleImage: null, articleTitle: Null, description: null);
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    margin:
    EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05);
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
                    "${DateFormat('yyyy-MM-dd').format(articlels.modifiedDate)}",
                    style: kFontFamily(
                      color: const Color.fromRGBO(61, 61, 61, 0.65),
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                    style: kFontFamily(
                      color: const Color.fromRGBO(61, 61, 61, 0.65),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}