import 'package:flutter/material.dart';
import 'package:recychamp/ui/bottom_app_bar.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    // * Client device data (screen height & width) for responsiveness
    var deviceData = MediaQuery.of(context);
    print(deviceData.size.height);
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: 430,
            height: 298, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.30000001192092896),
            ),
            child: Image.asset(
              'assets/images/Rectangle.png',
              fit: BoxFit.fill,
            ),
          ),
          const Positioned(
            top: 173,
            left: 0,
            bottom: 49,
            right: 100,
            child: Column(
              children: [
                Text(
                  'Welcome To The \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nCommunity!',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Almarai',
                    height: 0.04,
                    letterSpacing: -0.64,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 255,
            left: -20,
            bottom: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Share your challange outcomes and motivate others',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    height: 0.08,
                    letterSpacing: -0.28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
