import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EducationalResource extends StatefulWidget {
  const EducationalResource({super.key});

  @override
  State<EducationalResource> createState() => _EducationalResourceState();
}

class _EducationalResourceState extends State<EducationalResource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
