class Submission {
  String? id;
  String challengeId;
  String userId;
  String description;
  List<String> imageURLs;
  double rating;
  String? experiance;

  Submission(
      {this.id,
      required this.challengeId,
      required this.userId,
      required this.description,
      required this.imageURLs,
      this.experiance,
      required this.rating});
}
