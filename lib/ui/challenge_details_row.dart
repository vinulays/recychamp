import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengeDetailsRow extends StatelessWidget {
  final String iconURL;
  final String description;
  const ChallengeDetailsRow(
      {super.key, required this.iconURL, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(iconURL),
        const SizedBox(
          width: 10,
        ),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xA53D3D3D),
          ),
        )
      ],
    );
  }
}
