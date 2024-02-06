part of 'challenge_details_bloc.dart';

@immutable
sealed class ChallengeDetailsState {
  final bool isAccepted;

  const ChallengeDetailsState({required this.isAccepted});
}

final class ChallengeDetailsInitial extends ChallengeDetailsState {
  const ChallengeDetailsInitial({required super.isAccepted});
}
