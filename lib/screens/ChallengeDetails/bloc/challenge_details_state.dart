part of 'challenge_details_bloc.dart';

@immutable
sealed class ChallengeDetailsState extends Equatable {
  // final bool isAccepted;
  @override
  List<Object?> get props => [];
}

final class ChallengeDetailsInitial extends ChallengeDetailsState {
  ChallengeDetailsInitial();
}

class ChallengeAccepting extends ChallengeDetailsState {}

class ChallengeAccepted extends ChallengeDetailsState {}

class ChallengeAcceptingError extends ChallengeDetailsState {
  final String errorMessage;
  ChallengeAcceptingError(this.errorMessage);
}

class ChallengeSubmitting extends ChallengeDetailsState {}

class ChallengeSubmitted extends ChallengeDetailsState {}

class ChallengeSubmittingError extends ChallengeDetailsState {
  final String errorMessage;
  ChallengeSubmittingError(this.errorMessage);
}
