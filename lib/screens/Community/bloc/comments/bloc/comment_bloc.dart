import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recychamp/models/comment.dart';
import 'package:recychamp/repositories/posts%20repository/post_repo.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final PostRepository _postRepository;

  CommentBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(CommentInitial()) {
    on<FetchCommentsEvent>((event, emit) async {
      emit(CommentLoading());
      try {
        final comments =
            await _postRepository.getCommentsByPostId(event.postId);
        emit(CommentLoaded(comments));
      } catch (e) {
        emit(CommentsError("Failed to fetch comments: $e"));
      }
    });

    on<AddCommentEvent>((event, emit) async {
      emit(CommentAdding());
      try {
        await _postRepository.addComment(event.postId, event.text);

        add(FetchCommentsEvent(event.postId));
      } catch (e) {
        emit(CommentsError("Failed to add comment: $e"));
      }
    });

    on<DeleteCommentEvent>((event, emit) async {
      emit(CommentDeleting());
      try {
        await _postRepository.deleteComment(event.commentId, event.postId);

        add(FetchCommentsEvent(event.postId));
      } catch (e) {
        emit(CommentsError("Failed to delete comment: $e"));
      }
    });
  }
}
