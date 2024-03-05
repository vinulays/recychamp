part of 'challenge_details_bloc.dart';

@immutable
sealed class ChallengeDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AcceptChallengeEvent extends ChallengeDetailsEvent {
  final String challengeID;

  AcceptChallengeEvent(this.challengeID);
}

class SubmitChallengeEvent extends ChallengeDetailsEvent {
  final Map<String, dynamic> formData;
  SubmitChallengeEvent(this.formData);
}
