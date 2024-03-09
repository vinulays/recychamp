part of 'challenges_bloc.dart';

sealed class ChallengesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ChallengesInitial extends ChallengesState {}

class ChallengesLoading extends ChallengesState {}

class ChallengesLoaded extends ChallengesState {
  final List<Challenge> challenges;

  ChallengesLoaded(this.challenges);

  @override
  List<Object?> get props => [challenges];
}

class ChallengesError extends ChallengesState {}

class ChallengeAdding extends ChallengesState {}

class ChallengeAdded extends ChallengesState {}

class ChallengeAddingError extends ChallengesState {
  final String errorMessage;

  ChallengeAddingError(this.errorMessage);
}

class ChallengeUpdating extends ChallengesState {}

class ChallengeUpdated extends ChallengesState {}

class ChallengeUpdatingError extends ChallengesState {
  final String errorMessage;

  ChallengeUpdatingError(this.errorMessage);
}

class ChallengeDeleting extends ChallengesState {}

class ChallengeDeleted extends ChallengesState {}

class ChallengeDeletingError extends ChallengesState {
  final String errorMessage;

  ChallengeDeletingError(this.errorMessage);
}

class ChallengesSearching extends ChallengesState {
  @override
  List<Object?> get props => [];
}
