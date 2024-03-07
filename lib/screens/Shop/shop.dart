import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:recychamp/ui/shop_filter.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                      colorFilter:
                          const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Shop",
                      style: GoogleFonts.poppins(
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
                                return const ShopFilter();
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
                    hintText: "Search Items"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
