part of 'challenges_bloc.dart';

sealed class ChallengesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchChallengesEvent extends ChallengesEvent {}

class AddChallengeEvent extends ChallengesEvent {
  final Map<String, dynamic> formData;

  AddChallengeEvent(this.formData);
}

class UpdateChallengeEvent extends ChallengesEvent {
  final Map<String, dynamic> formData;

  UpdateChallengeEvent(this.formData);
}

class DeleteChallengeEvent extends ChallengesEvent {
  final String challengeId;

  DeleteChallengeEvent(this.challengeId);
}

class ApplyFiltersEvent extends ChallengesEvent {
  final Set<String> filters;
  final bool isCompleted;

  ApplyFiltersEvent(this.filters, this.isCompleted);
}

class ResetChallengesEvent extends ChallengesEvent {}

class SearchChallengesEvent extends ChallengesEvent {
  final String query;

  SearchChallengesEvent(this.query);

  @override
  List<Object?> get props => [query];
}
