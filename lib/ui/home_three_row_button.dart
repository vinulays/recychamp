import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/screens/ParentAgreement/parent_agreement.dart';
import 'package:recychamp/screens/calendar/calendar_event.dart';

class HomeThreeRowButton extends StatelessWidget {
  final String iconURL;
  final String description;
  Widget widget;
  HomeThreeRowButton(
      {super.key,
      required this.iconURL,
      required this.description,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CalendarEvent()));
      },
      child: Container(
        width: 113.60,
        height: 113.60,
        padding: const EdgeInsets.all(8.41),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.83),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconURL),
            const SizedBox(
              height: 20,
            ),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF1E1E1E),
              ),
            )
          ],
        ),
      ),
    );
  }
}
