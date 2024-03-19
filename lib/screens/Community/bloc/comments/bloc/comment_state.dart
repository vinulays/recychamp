part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comment> comments;

  CommentLoaded(this.comments);

  @override
  List<Object?> get props => [comments];
}

class CommentsError extends CommentState {
  final String errorMessage;

  CommentsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class CommentAdding extends CommentState {}

class CommentAdded extends CommentState {}

class CommentAddingError extends CommentState {
  final String errorMessage;

  CommentAddingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
