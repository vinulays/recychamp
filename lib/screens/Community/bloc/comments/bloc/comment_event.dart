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
  final String postId;
  final String text;

  AddCommentEvent(this.postId, this.text);

  @override
  List<Object?> get props => [];
}

class DeleteCommentEvent extends CommentEvent {
  final String commentId;
  final String postId;

  DeleteCommentEvent(this.commentId, this.postId);

  @override
  List<Object?> get props => [];
}
