part of 'challenge_details_bloc.dart';

@immutable
sealed class ChallengeDetailsEvent extends Equatable {
  const ChallengeDetailsEvent();

  @override
  List<Object?> get props => [];
}

class AcceptChallengeEvent extends ChallengeDetailsEvent {
  const AcceptChallengeEvent();

  @override
  List<Object?> get props => [];
}
