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
