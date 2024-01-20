import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color(0xff75A488),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning",
                      style: GoogleFonts.almarai(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Susan Clay",
                      style: GoogleFonts.almarai(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                SvgPicture.asset(
                  "assets/icons/Settings.svg",
                  height: 24,
                  width: 24,
                )
              ],
            ),
          ),
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.85,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(42.07),
                            topRight: Radius.circular(42.07)))),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: -84.15 / 2,
                      child: Container(
                        width: 84.15,
                        height: 84.15,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, 1.00),
                            end: Alignment(0, -1),
                            colors: [
                              Color(0xFFFEAA42),
                              Color(0xFFFBA33F),
                              Color(0xFFF59838),
                              Color(0xFFF29135),
                              Color(0xFFF18F34),
                              Color(0xFFF28F3E),
                              Color(0xFFF38E5A),
                              Color(0xFFF68D88),
                              Color(0xFFF78C9B),
                              Color(0xFFF08672)
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.83),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/gold-medal.svg",
                            height: 32.08,
                            width: 32.08,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "Your fresh and green comfortable ",
                                        style: GoogleFonts.almarai(
                                            color: const Color(0xFF1E1E1E),
                                            fontSize: 27,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                        text: "place",
                                        style: GoogleFonts.almarai(
                                            color: const Color(0xFF75A488),
                                            fontSize: 27,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: deviceData.size.width * 0.07),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        style: GoogleFonts.almarai(
                                          fontSize: 17,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15),
                                            prefixIconConstraints:
                                                const BoxConstraints(
                                                    maxHeight: 26,
                                                    minWidth: 26),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 13, right: 10),
                                              child: SvgPicture.asset(
                                                "assets/icons/search.svg",
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xffE6EEEA),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(12.62),
                                            ),
                                            hintStyle: GoogleFonts.almarai(
                                                fontSize: 17,
                                                color: const Color(0xff75A488)),
                                            hintText: "Search Challenges"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: const ShapeDecoration(
                                          // color: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Color(0xff75A488)),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.62),
                                            ),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                            "assets/icons/filter.svg"),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
