part of 'challenge_details_bloc.dart';

@immutable
sealed class ChallengeDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AcceptChallengeEvent extends ChallengeDetailsEvent {
  final String userID;
  final String challengeID;

  AcceptChallengeEvent(this.userID, this.challengeID);
}

class SubmitChallengeEvent extends ChallengeDetailsEvent {
  final Map<String, dynamic> formData;
  SubmitChallengeEvent(this.formData);
}
