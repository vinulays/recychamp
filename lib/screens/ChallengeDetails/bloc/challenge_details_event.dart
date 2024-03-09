part of 'challenge_details_bloc.dart';

sealed class ChallengeDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchChallengeDetailsEvent extends ChallengeDetailsEvent {
  final String challengeID;

  FetchChallengeDetailsEvent(this.challengeID);
}

class AcceptChallengeEvent extends ChallengeDetailsEvent {
  final String challengeID;

  AcceptChallengeEvent(this.challengeID);
}

class SubmitChallengeEvent extends ChallengeDetailsEvent {
  final Map<String, dynamic> formData;
  final String challengeId;
  SubmitChallengeEvent(this.formData, this.challengeId);
}
