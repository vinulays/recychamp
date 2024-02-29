import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recychamp/models/challenge.dart';

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
            rating: double.parse(data['rating']
                .toString()), // * converting firebase number format to double format
            categoryId: data["categoryId"]);

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
      await _firestore.collection("challenges").add({
        "title": formData['title'],
        "description": formData["description"],
        "location": formData["location"],
        "country": formData["country"],
        "rules": formData["rules"],
        "startDateTime": DateTime(
            formData["startDate"]
                .year, // * combining selected dates and times to create the timestamp
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
        "maximumParticipants": int.parse(
            formData["maximumParticipants"]), // * converting string to integer
        "registeredParticipants": 0,
        "difficulty": formData["difficulty"],
        "imageURL": formData["imageURL"],
        "rating": 0,
        "categoryId": formData["categoryId"],
        "createdAt": DateTime.now(),
        "type": formData["type"]
      });
    } catch (e) {
      rethrow;
    }
  }

  // * update challenge in firebsae
  Future<void> updateChallenge(Map<String, dynamic> formData) async {
    try {
      DocumentReference challengeRef =
          _firestore.collection("challenges").doc(formData["id"]);

      await challengeRef.update({
        "title": formData['title'],
        "description": formData["description"],
        "location": formData["location"],
        "country": formData["country"],
        "rules": formData["rules"],
        "startDateTime": DateTime(
            formData["startDate"]
                .year, // * combining selected dates and times to create the timestamp
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
        "maximumParticipants": int.parse(
            formData["maximumParticipants"]), // * converting string to integer
        "difficulty": formData["difficulty"],
        "imageURL": formData["imageURL"],
        "categoryId": formData["categoryId"],
        "type": formData["type"]
      });
    } catch (e) {
      rethrow;
    }
  }

  // * delete challenge from firebase
  Future<void> deleteChallenge(String challengeId) async {
    try {
      DocumentReference challengeRef =
          _firestore.collection("challenges").doc(challengeId);

      DocumentSnapshot challengeSnapshot = await challengeRef.get();
      String imageURL = challengeSnapshot.get("imageURL");

      await challengeRef.delete();

      // * deleting the image associated with the challenge
      Reference imageRef = FirebaseStorage.instance.refFromURL(imageURL);
      await imageRef.delete();
    } catch (e) {
      throw Exception('Failed to delete the challenge: $e');
    }
  }
}
