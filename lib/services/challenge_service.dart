import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recychamp/models/challenge.dart';

class ChallengeService {
  final FirebaseFirestore _firestore;

  ChallengeService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // * getting challenges from firebase
  Future<List<Challenge>> getChallenges() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('challenges').get();

      List<Challenge> challenges = querySnapshot.docs.map((doc) {
        // * mapping each result with the challenge model
        // * convert firebase timestamp to dateTime in flutter using toDate()
        Map<String, dynamic> data = doc.data();
        return Challenge(
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
            rating: data['rating']);
      }).toList();

      return challenges;
    } catch (e) {
      throw Exception('Failed to fetch challenges: $e');
    }
  }
}
