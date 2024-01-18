import "package:carousel_slider/carousel_slider.dart";
import "package:dots_indicator/dots_indicator.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff75A488),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(42.07),
                      bottomRight: Radius.circular(42.07),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          enableInfiniteScroll: false,
                          height: MediaQuery.of(context).size.height * 0.77,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          }),
                      items: [1, 2, 3, 4].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.55,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                              "assets/images/welcome_girl.png"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 343,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Little Start, Grows into ',
                                                  style: GoogleFonts.almarai(
                                                    color:
                                                        const Color(0xFF1E1E1E),
                                                    fontSize: 27.35,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Something',
                                                  style: GoogleFonts.almarai(
                                                    color:
                                                        const Color(0xFF75A488),
                                                    fontSize: 27.35,
                                                    // fontFamily: 'Almarai',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' Big',
                                                  style: GoogleFonts.almarai(
                                                    color:
                                                        const Color(0xFF1E1E1E),
                                                    fontSize: 27.35,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 323,
                                          height: 47,
                                          child: Text(
                                            'Where Fun Meets Conservation in Every Challenge!',
                                            style: GoogleFonts.almarai(
                                              color: const Color(0xFF747474),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              letterSpacing: 0.50,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40, top: 10),
                      child: DotsIndicator(
                        dotsCount: 4,
                        position: _currentIndex,
                        decorator: DotsDecorator(
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            activeColor: const Color(0xFF1E1E1E)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff06564B),
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    const Color(0xffFFFFFF),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  fixedSize: MaterialStateProperty.all(
                    const Size(160, 52),
                  ),
                ),
                child: Text(
                  "Login",
                  style: GoogleFonts.almarai(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff227C70),
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    const Color(0xffFFFFFF),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  fixedSize: MaterialStateProperty.all(
                    const Size(160, 52),
                  ),
                ),
                child: Text(
                  "Register",
                  style: GoogleFonts.almarai(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
