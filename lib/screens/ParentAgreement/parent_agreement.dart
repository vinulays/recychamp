import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/ui/parent_agreement_section.dart';

class ParentAgreement extends StatefulWidget {
  const ParentAgreement({super.key});

  @override
  State<ParentAgreement> createState() => _ParentAgreementState();
}

class _ParentAgreementState extends State<ParentAgreement> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
        child: Column(
          children: [
            const SizedBox(
              height: 41.86,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Text(
                  "Parent Agreement",
                  style: GoogleFonts.almarai(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ScrollbarTheme(
                data: const ScrollbarThemeData(
                  crossAxisMargin: -13,
                  mainAxisMargin: 30,
                ),
                child: Scrollbar(
                  radius: const Radius.circular(16.83),
                  thickness: 10,
                  child: ListView(
                    children: const [
                      Column(
                        children: [
                          // * Agreement sections
                          ParentAgreementSection(
                            title: "Child Protection",
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante",
                          ),
                          ParentAgreementSection(
                            title: "Privacy",
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // * Accept and reject buttons
            Container(
              margin: EdgeInsets.symmetric(vertical: deviceSize.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          side: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xffFFFFFF),
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        const Color(0xff000000),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      fixedSize: MaterialStateProperty.all(
                        const Size(167, 63),
                      ),
                    ),
                    child: Text(
                      "Decline",
                      style: GoogleFonts.almarai(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
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
                        const Color(0xff000000),
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        const Color(0xffFFFFFF),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      fixedSize: MaterialStateProperty.all(
                        const Size(167, 63),
                      ),
                    ),
                    child: Text(
                      "Accept",
                      style: GoogleFonts.almarai(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
