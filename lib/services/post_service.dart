import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:recychamp/models/comment.dart';

import 'package:recychamp/models/post.dart';

class PostService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> addCommentToPost(String postId, String comment) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'commentList': FieldValue.arrayUnion([await addComment(comment)]),
      });
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  Future<DocumentReference> addComment(String text) async {
    try {
      final User? user = _auth.currentUser;

      final userId = user?.uid;

      DocumentReference commentRef =
          await _firestore.collection('comments').add({
        'commentUserId': userId,
        'description': text,
        // Add any other fields you need for your comment
      });
      return commentRef;
    } catch (e) {
      print('Error adding comment: $e');
      throw e;
    }
  }

  Future<List<Post>> searchPosts(String query) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('posts')
          .where('description', isEqualTo: query)
          .get();

      List<Post> posts = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        List<DocumentReference> commentRefs =
            List<DocumentReference>.from(data['commentList']);

        List<Comment> comments = await getCommentsForPost(commentRefs);

        Post post = Post(
          postId: doc.id,
          postUserId: data['postUserId'],
          title: data["title"],
          description: data['description'],
          photoUrl: data['postUrl'],
          createdAt: data['createdAt'].toDate(),
          likesCount: data['likesCount'],
          commentList: comments,
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
            List<DocumentReference>.from(data['commentList']);

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
        DocumentSnapshot commentSnapshot = await ref.get();

        if (commentSnapshot.exists) {
          Map<String, dynamic> data =
              commentSnapshot.data() as Map<String, dynamic>;

          Comment comment = Comment(
              commentId: ref.id,
              commentUserId: data["commentUserId"],
              description: data["description"]);

          comments.add(comment);
          // print(ref.id);
          // print(data["commentUserId"]);
          // print(data["description"]);
        }
      }
      return comments;
    } catch (e) {
      throw Exception('Failed to get comments: $e');
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

  Future<void> updatePost(Post post) async {
    try {
      DocumentReference postRef =
          _firestore.collection("posts").doc(post.postId);

      await postRef.update({
        "title": post.title,
        'description': post.description,
        // 'photoUrl': post.photoUrl,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> likePost(Post post) async {
    try {
      DocumentReference postRef =
          _firestore.collection("posts").doc(post.postId);

      await postRef.update({
        "likes": post.likesCount! + 1,
      });
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dislikePost(Post post) async {
    try {
      DocumentReference postRef =
          _firestore.collection("posts").doc(post.postId);

      await postRef.update({
        "likes": post.likesCount! - 1,
      });
    } catch (e) {
      rethrow;
    }
  }
}
