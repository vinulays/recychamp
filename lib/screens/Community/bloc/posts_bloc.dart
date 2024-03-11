import 'package:bloc/bloc.dart';
import 'package:recychamp/models/post.dart';
import 'package:recychamp/repositories/posts%20repository/post_repo.dart';
import 'package:recychamp/screens/Community/bloc/posts_event.dart';
import 'package:recychamp/screens/Community/bloc/posts_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc({required PostRepository repository})
      : _postRepository = repository,
        super(PostInitial()) {
    on<FetchPostsEvent>(_mapFetchPostsEventToState);
    on<AddPostEvent>(_mapAddPostEventToState);
    on<SearchPostsEvent>(_mapSearchPostsEventToState);
  }

  Future<void> _mapFetchPostsEventToState(
      FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await _postRepository.getAllPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError("Failed to fetch posts: $e"));
    }
  }

  Future<void> _mapAddPostEventToState(
      AddPostEvent event, Emitter<PostState> emit) async {
    emit(PostAdding());
    try {
      await _postRepository.addPost(event.formData as Post);
      emit(PostAdded());
      add(FetchPostsEvent()); // Fetch updated posts
    } catch (e) {
      emit(PostAddingError("Failed to add post: $e"));
    }
  }

  Future<void> _mapSearchPostsEventToState(
      SearchPostsEvent event, Emitter<PostState> emit) async {
    emit(PostsSearching());
    try {
      final searchResult = await _postRepository.searchPosts(event.query);
      emit(PostLoaded(searchResult));
    } catch (e) {
      emit(PostError("Failed to search posts: $e"));
    }
  }
}
