class Submission {
  String? id;
  String challengeId;
  String userId;
  String description;
  List<String> imageURLs;
  double rating;
  String? experience;
  DateTime submittedAt;

  Submission(
      {this.id,
      required this.challengeId,
      required this.userId,
      required this.description,
      required this.imageURLs,
      this.experience,
      required this.rating,
      required this.submittedAt});
}
