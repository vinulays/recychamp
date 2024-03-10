import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/models/submission.dart';

class ChallengeService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ChallengeService(
      {required FirebaseStorage storage, required FirebaseFirestore firestore})
      : _firestore = firestore,
        _storage = storage;

  // * getting challenges from firebase
  Future<List<Challenge>> getChallenges() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('challenges')
          .orderBy("createdAt", descending: true)
          .get(const GetOptions(source: Source.server));
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
            acceptedParticipants: List<String>.from(data[
                "acceptedParticipants"]), // * converting dynamic array to string array
            submittedParticipants: List<String>.from(data[
                "submittedParticipants"]), // * converting dynamic array to string array
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

  Future<Challenge> getChallengeById(String challengeId) async {
    try {
      DocumentSnapshot challengeDoc =
          await _firestore.collection('challenges').doc(challengeId).get();
      if (challengeDoc.exists) {
        Map<String, dynamic> data = challengeDoc.data() as Map<String, dynamic>;

        Challenge challenge = Challenge(
            id: challengeDoc.id,
            title: data['title'],
            description: data['description'],
            location: data['location'],
            country: data['country'],
            rules: data['rules'],
            startDateTime: data['startDateTime'].toDate(),
            endDateTime: data['endDateTime'].toDate(),
            completedPercentage: data['completedPercentage'],
            maximumParticipants: data['maximumParticipants'],
            acceptedParticipants: List<String>.from(data[
                "acceptedParticipants"]), // * converting dynamic array to string array
            submittedParticipants: List<String>.from(data[
                "submittedParticipants"]), // * converting dynamic array to string array
            difficulty: data['difficulty'],
            imageURL: data['imageURL'],
            type: data['type'],
            rating: double.parse(data['rating']
                .toString()), // * converting firebase number format to double format
            categoryId: data["categoryId"]);

        return challenge;
      } else {
        throw Exception('Challenge with id $challengeId not found');
      }
    } catch (e) {
      // Handle errors if any
      throw Exception('Failed to get challenge: $e');
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
        "acceptedParticipants": [],
        "submittedParticipants": [],
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
      String imageURL = await challengeSnapshot.get("imageURL");

      await challengeRef.delete();

      // * deleting the image associated with the challenge
      Reference imageRef = FirebaseStorage.instance.refFromURL(imageURL);
      await imageRef.delete();
    } catch (e) {
      throw Exception('Failed to delete the challenge: $e');
    }
  }

  // * accept challenge in firebase
  Future<void> acceptChallenge(String challengeId, String userId) async {
    try {
      DocumentReference challengeRef =
          _firestore.collection("challenges").doc(challengeId);

      await challengeRef.update({
        'acceptedParticipants': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      throw Exception("Failed to accept challenge $e");
    }
  }

  // * submit challenge to firebase
  Future<void> submitChallenge(
      String userId, Map<String, dynamic> formData, String challengeId) async {
    List<String> imageURLs = [];

    try {
      DocumentReference challengeRef =
          _firestore.collection("challenges").doc(challengeId);

      // * uploading images to firestore and getting the URLs
      for (String imagePath in formData["imageURLs"]) {
        String fileExtension = imagePath.split(".").last;
        String imageName = DateTime.now().microsecondsSinceEpoch.toString();

        Reference ref = _storage
            .ref()
            .child("submissionImages")
            .child("$imageName.$fileExtension");

        File imageFile = File(imagePath);
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        imageURLs.add(downloadURL);
      }

      await _firestore.collection("submissions").add({
        "challengeId": challengeId,
        "userId": userId,
        "description": formData["description"],
        "imageURLs": imageURLs,
        "rating": formData["rating"],
        "experience": formData["experience"] ?? "Not Given",
        "submittedAt": DateTime.now()
      });

      // * adding user id to the submiitted participants array in the submitted challenge
      await challengeRef.update({
        'submittedParticipants': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      throw Exception("Failed to submit challenge: $e");
    }
  }

  // * getting submission using user id and challenge id from firebase
  Future<Submission?> getSubmission(String userId, String challengeId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('submissions')
          .where('userId', isEqualTo: userId)
          .where('challengeId', isEqualTo: challengeId)
          .limit(1) // * Limiting the query to retrieve only one document
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot submissionSnapshot = querySnapshot.docs.first;
        Map<String, dynamic> data =
            submissionSnapshot.data() as Map<String, dynamic>;

        Submission submission = Submission(
            id: submissionSnapshot.id,
            challengeId: challengeId,
            userId: userId,
            description: data["description"],
            imageURLs: List<String>.from(data["imageURLs"]),
            rating: data["rating"],
            submittedAt: data["submittedAt"].toDate(),
            experience: data["experience"]);

        return submission;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to fetch the submission: $e");
    }
  }
}
