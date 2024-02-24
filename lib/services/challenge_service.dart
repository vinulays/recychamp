import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/models/challenge_category.dart';

class ChallengeService {
  final FirebaseFirestore _firestore;

  ChallengeService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // * getting challenges from firebase
  Future<List<Challenge>> getChallenges() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('challenges')
          .orderBy("createdAt", descending: true)
          .get();
      List<Challenge> challenges = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        DocumentReference categoryRef = data['categoryRef'];

        // * Fetching the category document based on the reference
        DocumentSnapshot<Map<String, dynamic>> categoryDoc =
            await categoryRef.get() as DocumentSnapshot<Map<String, dynamic>>;

        // * Extracting category data from the category document
        Map<String, dynamic> categoryData = categoryDoc.data()!;
        ChallengeCategory category = ChallengeCategory(
          id: categoryDoc.id,
          name: categoryData['name'],
        );

        Challenge challenge = Challenge(
            id: doc.id,
            title: data['title'],
            description: data['description'],
            location: data['location'],
            country: data['country'],
            rules: data['rules'],
            startDateTime: data['startDateTime'].toDate(),
            endDateTime: data['endDateTime'].toDate(),
            completedPercentage: data['completedPercentage'],
            maximumParticipants: data['maximumParticipants'],
            registeredParticipants: data['registeredParticipants'],
            difficulty: data['difficulty'],
            imageURL: data['imageURL'],
            type: data['type'],
            rating: double.parse(data['rating'].toString()),
            category: category);

        challenges.add(challenge);
      }

      return challenges;
    } catch (e) {
      throw Exception('Failed to fetch challenges: $e');
    }
  }

  // * add challenge to firebase
  Future<void> addChallenge(Map<String, dynamic> formData) async {
    try {
      // Fetch the category document from Firestore
      DocumentReference? categoryRef;

      if (formData["categoryRef"] != null) {
        categoryRef = FirebaseFirestore.instance
            .collection('challengeCategories')
            .doc(formData['categoryRef']);
      }

      await _firestore.collection("challenges").add({
        "title": formData['title'],
        "description": formData["description"],
        "location": formData["location"],
        "country": formData["country"],
        "rules": formData["rules"],
        "startDateTime": DateTime(
            formData["startDate"].year,
            formData["startDate"].month,
            formData["startDate"].day,
            formData["startTime"].hour,
            formData["startTime"].minute),
        "endDateTime": DateTime(
            formData["endDate"].year,
            formData["endDate"].month,
            formData["endDate"].day,
            formData["endTime"].hour,
            formData["endTime"].minute),
        "completedPercentage": 0,
        "maximumParticipants": int.parse(formData["maximumParticipants"]),
        "registeredParticipants": 0,
        "difficulty": formData["difficulty"],
        "imageURL": formData["imageURL"],
        "rating": 0,
        "categoryRef": categoryRef,
        "createdAt": DateTime.now(),
        "type": formData["type"]
      });
    } catch (e) {
      rethrow;
    }
  }
}
