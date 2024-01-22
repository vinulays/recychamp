import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      elevation: 0,
      surfaceTintColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/challenges.svg")),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/search-low-opacity.svg",
              )),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/community.svg")),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/notifications.svg"),
          ),
        ],
      ),
    );
  }
}
