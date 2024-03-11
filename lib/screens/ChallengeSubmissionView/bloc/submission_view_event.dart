part of 'submission_view_bloc.dart';

sealed class SubmissionViewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSubmissionEvent extends SubmissionViewEvent {
  final String challengeId;

  FetchSubmissionEvent(this.challengeId);
}
