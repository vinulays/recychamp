import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentAgreementSection extends StatelessWidget {
  final String title;
  final String description;
  const ParentAgreementSection(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.almarai(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          description,
          style: GoogleFonts.almarai(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
