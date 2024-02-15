part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchChallengesEvent extends ChallengesEvent {}
