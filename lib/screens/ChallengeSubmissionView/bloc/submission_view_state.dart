part of 'submission_view_bloc.dart';

sealed class SubmissionViewState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SubmissionViewInitial extends SubmissionViewState {}

class SubmissionLoading extends SubmissionViewState {}

class SubmissionLoaded extends SubmissionViewState {
  final Submission submission;

  SubmissionLoaded(this.submission);

  @override
  List<Object> get props => [submission];
}

class SubmissionLoadingError extends SubmissionViewState {
  final String errorMessage;

  SubmissionLoadingError(this.errorMessage);
}
