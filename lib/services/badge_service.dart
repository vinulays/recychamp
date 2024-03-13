import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BadgeService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  BadgeService({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future<int> getUserSubmissionCount() async {
    try {
      User? user = _auth.currentUser;
      final userId = user?.uid;

      QuerySnapshot querySnapshot = await _firestore
          .collection('submissions')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.length;
    } catch (e) {
      throw Exception('Error getting user submissions: $e');
    }
  }

  Future<String> getBadgeForSubmissionCount(int submissionCount) async {
    Map<int, String> badgeThresholds = {
      0: 'bronze',
      5: 'silver',
      10: 'gold',
      20: 'diamond',
      40: 'ultimate',
    };

    // * Finding the highest submission number that the user has reached
    int highestThreshold = 0;
    for (int threshold in badgeThresholds.keys) {
      if (submissionCount >= threshold) {
        highestThreshold = threshold;
      }
    }

    // * Returning the badge for the highest submission number reached
    return badgeThresholds[highestThreshold] ?? 'No Badge';
  }
}
