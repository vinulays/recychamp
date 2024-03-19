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
  }

  // Future<void> _mapAddPostEventToState(
  //     AddCommentEvent event, Emitter<CommentState> emit) async {
  //   emit(PostAdding());
  //   try {
  //     await _postRepository.addPost(event.formData as Post);
  //     emit(PostAdded());
  //     add(FetchPostsEvent()); // Fetch updated posts
  //   } catch (e) {
  //     emit(PostAddingError("Failed to add post: $e"));
  //   }
  // }
}
