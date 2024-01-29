import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    //Screen Responsiveness
    var deviceData = MediaQuery.of(context);
    print(deviceData.size.height);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Image with text overlay
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 430,
              height: 298,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Rectangle.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 173, left: 30, right: 163, bottom: 0),
                  child: const Text(
                    'Hello to my',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Almarai',
                      height: 0.04,
                      letterSpacing: -0.64,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 210, left: 30, right: 163, bottom: 0),
                child: const Text(
                  'Community!',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Almarai',
                    height: 0.04,
                    letterSpacing: -0.64,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 240, left: 30, right: 0, bottom: 0),
                child: const Text(
                  'Share your challange outcomes and motivate others',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Almarai',
                    height: 0.04,
                    letterSpacing: -0.28,
                  ),
                ),
              ),
            ),
          ),

          // Post feed
          Positioned(
            top: 298,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  // Your post widgets go here
                  // Example post widget
                  Card(
                    child: ListTile(
                      title: Text('Post Title'),
                      subtitle: Text('Post Description'),
                    ),
                  ), // Card
                  // Add more post widgets as needed
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the floating action button
        },
        backgroundColor: const Color(0xFF75A488),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
