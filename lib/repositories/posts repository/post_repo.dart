import 'package:recychamp/models/comment.dart';
import 'package:recychamp/models/post.dart';
import 'package:recychamp/services/post_service.dart';

class PostRepository {
  final PostService _postService;

  PostRepository({required PostService postService})
      : _postService = postService;

  Future<void> addPost(Post post) async {
    await _postService.addPost(post);
  }

  Future<void> addComment(String postId, String text) async {
    await _postService.addComment(postId, text);
  }

  Future<void> deletePost(String postId) async {
    await _postService.deletePost(postId);
  }

  Future<void> deleteComment(String commentId, String postId) async {
    await _postService.deleteComment(commentId, postId);
  }

  Future<List<Post>> getAllPosts() async {
    try {
      return await _postService.getAllPosts();
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  Future<List<Post>> searchPosts(String query) async {
    try {
      return await _postService.searchPosts(query);
    } catch (e) {
      throw Exception('Failed to search posts: $e');
    }

    // Future<List<Post>> applyFilters(Set<String> filters) async {
    //   try {
    //     return await _postService.applyFilters(filters);
    //   } catch (e) {
    //     throw Exception('Failed to apply filters: $e');
    //   }
    // }
  }

  Future<List<Comment>> getCommentsByPostId(String postId) async {
    try {
      return await _postService.getCommentByPostId(postId);
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }
}
