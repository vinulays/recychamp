import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengeForm extends StatefulWidget {
  const ChallengeForm({super.key});

  @override
  State<ChallengeForm> createState() => _ChallengeFormState();
}

class _ChallengeFormState extends State<ChallengeForm> {
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
                  "Add a Challenge",
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
              child: SingleChildScrollView(
                child: FormBuilder(
                  child: Column(children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
