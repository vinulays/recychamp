part of 'challenge_details_bloc.dart';

sealed class ChallengeDetailsState extends Equatable {
  // final bool isAccepted;
  @override
  List<Object?> get props => [];
}

final class ChallengeDetailsInitial extends ChallengeDetailsState {
  ChallengeDetailsInitial();
}

class ChallengeLoading extends ChallengeDetailsState {}

class ChallengeLoaded extends ChallengeDetailsState {
  final Challenge challenge;

  ChallengeLoaded(this.challenge);

  @override
  List<Object> get props => [challenge];
}

class ChallengeLoadingError extends ChallengeDetailsState {
  final String message;

  ChallengeLoadingError(this.message);

  @override
  List<Object> get props => [message];
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
