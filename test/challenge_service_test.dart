import 'dart:io';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recychamp/models/submission.dart';
import 'package:recychamp/services/challenge_service.dart';
import 'package:path/path.dart' as path;

void main() {
  late ChallengeService challengeService;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;

  Map<String, dynamic> formData = {
    "title": "Beach Clean Challenge",
    "description": "Hi description",
    "location": "Galle Face",
    "country": "Sri Lanka",
    "rules": "Hi rules",
    "startDate": DateTime.now(),
    "startTime": DateTime.now(),
    "endDate": DateTime.now(),
    "endTime": DateTime.now(),
    "maximumParticipants": "100",
    "acceptedParticipants": [],
    "submittedParticipants": [],
    "difficulty": "high",
    "imageURL": "https://hi-image.png",
    "rating": 5,
    "categoryId": "3",
    "type": "Event"
  };

  setUpAll(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    mockFirebaseStorage = MockFirebaseStorage();
    challengeService = ChallengeService(
        storage: mockFirebaseStorage, firestore: fakeFirebaseFirestore);
  });
  test("adding and getting challenges from firebase", () async {
    await fakeFirebaseFirestore.collection("challenges").doc("123").set({
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

    final challenges = await challengeService.getChallenges();

    expect(challenges.length, 1);
  });

  test("updating challenge title in firebase", () async {
    const challengeId = "123";

    // * form data to be updated
    final updatedData = {
      "id": challengeId,
      "title": "Beach Cleanup Challenge",
      "description": "Hi description",
      "location": "Galle Face",
      "country": "Sri Lanka",
      "rules": "Hi rules",
      "startDate": DateTime.now(),
      "startTime": DateTime.now(),
      "endDate": DateTime.now(),
      "endTime": DateTime.now(),
      "maximumParticipants": "100",
      "acceptedParticipants": [],
      "submittedParticipants": [],
      "difficulty": "high",
      "imageURL": "https://hi-image.png",
      "rating": 5,
      "categoryId": "3",
      "type": "Event"
    };

    await fakeFirebaseFirestore.collection("challenges").doc(challengeId).set({
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

    // * updating the challenge via challenge service
    await challengeService.updateChallenge(updatedData);

    // * getting the challenge by id via challenge service
    final updatedChallenge =
        await challengeService.getChallengeById(challengeId);

    expect(updatedChallenge.title, "Beach Cleanup Challenge");
  });

  test("deleting challenge from firebse", () async {
    const challengeId = "123";

    final tempDir = Directory.systemTemp;
    final tempFilePath = path.join(tempDir.path, 'test_image.jpg');
    final tempFile = File(tempFilePath);

    // * creating and uploading a fake image
    await tempFile.writeAsBytes([1, 3, 4, 41, 4, 525, 52, 113, 141, 141, 14]);
    final imageData = await tempFile.readAsBytes();
    const imageURL = "images/image.jpg";

    final storageRef = mockFirebaseStorage.ref().child(imageURL);

    final uploadTask = storageRef.putData(imageData);
    await uploadTask;

    final downloadUrl = await storageRef.getDownloadURL();

    await fakeFirebaseFirestore.collection("challenges").doc(challengeId).set({
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
      "imageURL": downloadUrl,
      "rating": 0,
      "categoryId": formData["categoryId"],
      "createdAt": DateTime.now(),
      "type": formData["type"]
    });

    await challengeService.deleteChallenge(challengeId);

    final challenges = await challengeService.getChallenges();

    expect(challenges.length, 0);
  });

  test("accept a challenge", () async {
    const challengeId = "123";
    const userId = "1";

    await fakeFirebaseFirestore.collection("challenges").doc(challengeId).set({
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
      "imageURL": "https://hi-image.png",
      "rating": 0,
      "categoryId": formData["categoryId"],
      "createdAt": DateTime.now(),
      "type": formData["type"]
    });

    await challengeService.acceptChallenge(challengeId, userId);

    final challengeSnapshot = await fakeFirebaseFirestore
        .collection('challenges')
        .doc(challengeId)
        .get();

    final acceptedParticipants =
        challengeSnapshot.data()!['acceptedParticipants'] as List;

    // * checking whether accpetedParicipants list contains the user id.
    expect(acceptedParticipants.contains(userId), isTrue);
  });

  test("submit a challenge", () async {
    const challengeId = "123";
    const userId = "1";

    final submissonData = {
      'description': 'Challenge description',
      'imageURLs': [],
      'rating': 5.0, // Rating example
      'experience': 'Great experience',
    };

    await fakeFirebaseFirestore.collection("challenges").doc(challengeId).set({
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
      "imageURL": "https://hi-image.png",
      "rating": 0,
      "categoryId": formData["categoryId"],
      "createdAt": DateTime.now(),
      "type": formData["type"]
    });

    await challengeService.submitChallenge(userId, submissonData, challengeId);

    final challengeSnapshot = await fakeFirebaseFirestore
        .collection('challenges')
        .doc(challengeId)
        .get();

    final submittedParticipants =
        challengeSnapshot.data()!['submittedParticipants'] as List;
    final rating = challengeSnapshot.data()!['rating'];

    Submission? submission =
        await challengeService.getSubmission(userId, challengeId);

    // * checking the submission is saved in firebase
    expect(submission != null, isTrue);

    // * checking the user id is added to the submitted participants list in the submitted challenge
    expect(submittedParticipants.contains(userId), isTrue);

    // * checking the updated rating of the submitted challenge
    expect(rating, 5.0);
  });
}
