class Challenge {
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

  Challenge(
    this.title,
    this.description,
    this.location,
    this.country,
    this.rules,
    this.startDateTime,
    this.endDateTime,
    this.completedPercentage,
    this.maximumParticipants,
    this.registeredParticipants,
    this.difficulty,
    this.imageURL, [
    this.type,
  ]);
}
