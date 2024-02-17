part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesState {}

final class ChallengesInitial extends ChallengesState {}

class ChallengesLoading extends ChallengesState {}

class ChallengesLoaded extends ChallengesState {
  final List<Challenge> challenges;

  ChallengesLoaded(this.challenges);
}

class ChallengesError extends ChallengesState {}

class ChallengeAdding extends ChallengesState {}

class ChallengeAdded extends ChallengesState {
  final List<Challenge> updatedChallenges;

  ChallengeAdded(this.updatedChallenges);
}

class ChallengeAddingError extends ChallengesState {
  final String errorMessage;

  ChallengeAddingError(this.errorMessage);
}
