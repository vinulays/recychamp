import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recychamp/models/challenge_category.dart';

class ChallengeCategoryService {
  final FirebaseFirestore _firestore;

  ChallengeCategoryService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // * getting categories from firebase
  Future<List<ChallengeCategory>> getChallengeCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('challengeCategories')
          .orderBy('name')
          .get();
      List<ChallengeCategory> challengeCategories = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        ChallengeCategory challengeCategory =
            ChallengeCategory(id: doc.id, name: data['name']);
        challengeCategories.add(challengeCategory);
      }

      return challengeCategories;
    } catch (e) {
      throw Exception('Failed to fetch challenge categories');
    }
  }
}
