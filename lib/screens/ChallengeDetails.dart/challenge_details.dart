import 'package:flutter/material.dart';
import 'package:recychamp/models/challenge.dart';

class ChallengeDetails extends StatefulWidget {
  final Challenge challenge;
  const ChallengeDetails({super.key, required this.challenge});

  @override
  State<ChallengeDetails> createState() => _ChallengeDetailsState();
}

class _ChallengeDetailsState extends State<ChallengeDetails> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          // * challenge thumbnail
          Container(
            width: double.infinity,
            height: 292,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage("assets/images/challenge_details_thumbnail_dummy.png"),
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
