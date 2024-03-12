import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:recychamp/models/comment.dart';

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
        'postUserId': post.postUserId,
        'title': post.title,
        'description': post.description,
        'photoUrl': post.photoUrl,
        'createdAt': DateTime.now(),
        'likesCount': 0,
        'commentList': [],
      });
    } catch (e) {
      throw Exception('Failed to add post: $e');
    }
  }

  Future<List<Post>> searchPosts(String query) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('posts')
          .where('description', isGreaterThanOrEqualTo: query)
          .where('description', isLessThan: query + 'z')
          .get();

      List<Post> posts = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        Post post = Post(
          postId: doc.id,
          postUserId: data['postUserId'],
          title: data["title"],
          description: data['description'],
          photoUrl: data['postUrl'],
          createdAt: data['createdAt'].toDate(),
          likesCount: data['likesCount'],
          commentList: List<Comment>.from(data['commentList']),
        );
        posts.add(post);
      }
      return posts;
    } catch (e) {
      throw Exception('Failed to search posts: $e');
    }
  }

  Future<List<Post>> getAllPosts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('posts')
          .orderBy("createdAt", descending: true)
          .get();

      List<Post> posts = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        List<DocumentReference> commentRefs =
            List<DocumentReference>.from(data['commentList'] ?? []);

        List<Comment> comments = await getCommentsForPost(commentRefs);

        Post post = Post(
          postId: doc.id,
          postUserId: data['postUserId'],
          title: data["title"],
          description: data['description'],
          photoUrl: data['photoUrl'],
          createdAt: data['createdAt'].toDate(),
          likesCount: data['likesCount'],
          commentList: comments,
        );
        posts.add(post);
      }
      return posts;
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }

  Future<List<Comment>> getCommentsForPost(
      List<DocumentReference> commentRefs) async {
    try {
      List<Comment> comments = [];

      for (var ref in commentRefs) {
        DocumentSnapshot<Map<String, dynamic>> commentSnapshot =
            await ref.get() as DocumentSnapshot<Map<String, dynamic>>;

        Map<String, dynamic> data = commentSnapshot.data() ?? {};

        Comment comment = Comment(
            commentId: ref.id,
            commentUserId: data["commentUserId"],
            description: data["description"]);

        comments.add(comment);
      }
      return comments;
    } catch (e) {
      throw Exception('Failed to get comments: $e');
    }
  }

  // Future<Post?> getPostById(String postId) async {
  //   try {
  //     DocumentSnapshot postSnapshot =
  //         await _firestore.collection('posts').doc(postId).get();
  //     final Map<String, dynamic>? data =
  //         postSnapshot.data() as Map<String, dynamic>?;
  //     if (data != null) {
  //       return Post(
  //         postId: data['postId'],
  //         postUserId: data['postUserId'],
  //         description: data['description'],
  //          photoUrl: data['postUrl'],
  //         createdAt: data['createdAt'].toDate(),
  //         likesList: List<String>.from(data['likesList']),
  //         commentList: List<String>.from(data['commentList']),
  //       );
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to get post: $e');
  //   }
  // }

  // Future<void> updatePost(Post post) async {
  //   try {
  //     await _firestore.collection('posts').doc(post.postId).update({
  //       'description': post.description,
  //       'postUrl': post.postUrl,
  //       'likesList': post.likesList,
  //       'commentList': post.commentList,
  //     });
  //   } catch (e) {
  //     throw Exception('Failed to update post: $e');
  //   }
  // }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
      // Also delete associated media from storage if applicable
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
}
