import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recychamp/models/challenge_category.dart';

class Challenge {
  String? id;
  String title;
  String description;
  String location;
  String country;
  String rules;
  DateTime startDateTime;
  DateTime endDateTime;
  int completedPercentage;
  int maximumParticipants;
  int registeredParticipants;
  String difficulty;
  String imageURL;
  String? type;
  double rating;
  DocumentReference? categoryRef;
  ChallengeCategory? category;
  DateTime? createdAt;

  Challenge(
      {this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.country,
      required this.rules,
      required this.startDateTime,
      required this.endDateTime,
      required this.completedPercentage,
      required this.maximumParticipants,
      required this.registeredParticipants,
      required this.difficulty,
      required this.imageURL,
      this.type,
      required this.rating,
      this.category,
      this.categoryRef,
      this.createdAt});
}
