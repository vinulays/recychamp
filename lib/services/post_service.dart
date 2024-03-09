import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recychamp/models/post.dart';

class PostService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  PostService({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = storage;

  Future<void> addPost(Post post) async {
    try {
      await _firestore.collection('posts').doc(post.postId).set({
        'postId': post.postId,
        'postUserId': post.postUserId,
        'description': post.description,
        'postUrl': post.postUrl,
        'createdAt': post.createdAt,
        'likesList': post.likesList,
        'commentList': post.commentList,
      });
    } catch (e) {
      throw Exception('Failed to add post: $e');
    }
  }

  Future<Post?> getPostById(String postId) async {
    try {
      DocumentSnapshot postSnapshot =
          await _firestore.collection('posts').doc(postId).get();
      final Map<String, dynamic>? data =
          postSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        return Post(
          postId: data['postId'],
          postUserId: data['postUserId'],
          description: data['description'],
          postUrl: data['postUrl'],
          createdAt: data['createdAt'].toDate(),
          likesList: List<String>.from(data['likesList']),
          commentList: List<String>.from(data['commentList']),
        );
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to get post: $e');
    }
  }

  Future<void> updatePost(Post post) async {
    try {
      await _firestore.collection('posts').doc(post.postId).update({
        'description': post.description,
        'postUrl': post.postUrl,
        'likesList': post.likesList,
        'commentList': post.commentList,
      });
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
      // Also delete associated media from storage if applicable
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
}
