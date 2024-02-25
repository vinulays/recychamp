part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchChallengesEvent extends ChallengesEvent {}

class AddChallengeEvent extends ChallengesEvent {
  final Map<String, dynamic> formData;

  AddChallengeEvent(this.formData);
}
