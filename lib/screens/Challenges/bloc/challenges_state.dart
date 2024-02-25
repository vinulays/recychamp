part of 'challenges_bloc.dart';

@immutable
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
