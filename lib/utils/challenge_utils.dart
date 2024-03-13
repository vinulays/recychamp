import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getImageSize(File image) async {
  int sizeInBytes = await image.length();
  String sizeString;
  if (sizeInBytes < 1024) {
    sizeString = '${sizeInBytes}B';
  } else if (sizeInBytes < 1024 * 1024) {
    sizeString = '${(sizeInBytes / 1024).toStringAsFixed(2)}KB';
  } else {
    sizeString = '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(2)}MB';
  }
  return sizeString;
}

Future<double?> getAverageRatingForChallenge(String challengeId) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('submissions')
        .where('challengeId', isEqualTo: challengeId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      double totalRating = 0;
      int numberOfSubmissions = querySnapshot.docs.length;

      for (QueryDocumentSnapshot submissionDoc in querySnapshot.docs) {
        totalRating += submissionDoc['rating'] ?? 0;
      }

      return totalRating / numberOfSubmissions;
    } else {
      return null;
    }
  } catch (e) {
    throw Exception('Error fetching submissions: $e');
  }
}
