import 'dart:ffi';

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
  List<String> acceptedParticipants;
  String difficulty;
  String imageURL;
  String? type;
  double rating;
  String categoryId;
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
      required this.acceptedParticipants,
      required this.difficulty,
      required this.imageURL,
      this.type,
      required this.rating,
      required this.categoryId,
      this.createdAt});
}
