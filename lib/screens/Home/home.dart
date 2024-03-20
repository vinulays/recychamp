import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "package:recychamp/screens/Challenges/challenges.dart";
import "package:recychamp/screens/Community/community.dart";
import "package:recychamp/screens/Dashboard/dashboard.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // * Dashboard is selected as home screen
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    // * Add appropriate screens as commented below
    Challenges(), // * Challenges
    Challenges(), // * Challenges
    Dashboard(), // * Dashboard
    Community(), // * Community
    Community(), // * Community
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/challenges.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/challenges.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/search-low-opacity.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/search-low-opacity.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/home.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/home.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/community.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/community.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/notifications.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/notifications.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              label: 'Notifications',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        resizeToAvoidBottomInset: false,
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
