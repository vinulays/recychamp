part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCommentsEvent extends CommentEvent {
  final String postId;

  FetchCommentsEvent(this.postId);
}

class AddCommentEvent extends CommentEvent {
  final Map<String, dynamic> formData;

  AddCommentEvent(this.formData);

  @override
  List<Object?> get props => [formData];
}

class DeleteCommentEvent extends CommentEvent {
  final String commentId;

  DeleteCommentEvent(this.commentId);

  @override
  List<Object?> get props => [commentId];
}
