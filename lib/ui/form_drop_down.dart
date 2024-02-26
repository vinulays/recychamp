import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDropDown extends StatelessWidget {
  final String title;
  final bool isRequired;
  final String formBuilderName;
  final List<DropdownMenuItem<String>> items;
  final String? Function(String?)? validators;

  const FormDropDown(
      {super.key,
      required this.title,
      required this.isRequired,
      required this.formBuilderName,
      required this.items,
      this.validators});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                if (isRequired)
                  TextSpan(
                    text: '*',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFF0000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderDropdown(
            enableFeedback: true,
            items: items,
            name: formBuilderName,
            decoration: InputDecoration(
              errorStyle: GoogleFonts.poppins(
                  fontSize: 14, color: const Color(0xffba000d)),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xffba000d), width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xffba000d), width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.zero,
              prefix: Container(width: 15),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF75A488), width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF75A488), width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: validators,
          ),
        ],
      ),
    );
  }
}
