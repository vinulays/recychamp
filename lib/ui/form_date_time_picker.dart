import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDateTimePicker extends StatelessWidget {
  final String title;
  final bool isRequired;
  final String formBuilderName;
  final String iconURL;
  final InputType inputType;

  const FormDateTimePicker(
      {super.key,
      required this.title,
      required this.isRequired,
      required this.formBuilderName,
      required this.iconURL,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: GoogleFonts.almarai(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                if (isRequired)
                  TextSpan(
                    text: '*',
                    style: GoogleFonts.almarai(
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
          FormBuilderDateTimePicker(
            name: formBuilderName,
            inputType: inputType,
            decoration: InputDecoration(
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 26, minWidth: 26),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 13, right: 10),
                child: SvgPicture.asset(
                  iconURL,
                ),
              ),
              contentPadding: const EdgeInsets.only(left: 15),
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
          )
        ],
      ),
    );
  }
}
