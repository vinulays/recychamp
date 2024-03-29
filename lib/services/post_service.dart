import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:recychamp/models/comment.dart';

import 'package:recychamp/models/post.dart';

class PostService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  PostService({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _storage = storage,
        _auth = auth;

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
        "likesList": [],
      });
    } catch (e) {
      throw Exception('Failed to add post: $e');
    }
  }

  // Future<void> addCommentToPost(String postId, String comment) async {
  //   try {
  //     await _firestore.collection('posts').doc(postId).update({
  //       'commentList': FieldValue.arrayUnion([await addComment(comment)]),
  //     });
  //   } catch (e) {
  //     print('Error adding comment: $e');
  //   }
  // }

  Future<void> addComment(String postId, String text) async {
    try {
      final User? user = _auth?.currentUser;
      final userId = user?.uid;

      await _firestore.collection('comments').add(
          {'commentUserId': userId, 'description': text, "postId": postId});

      final postRef = _firestore.collection('posts').doc(postId);
      final postDoc = await postRef.get();

      final currentCommentCount = postDoc['commentCount'] ?? 0;
      final newCommentCount = currentCommentCount + 1;

      // Update the post document with the new comment count
      await postRef.update({'commentCount': newCommentCount});
    } catch (e) {
      throw Exception('Error adding comment: $e');
    }
  }

  Future<List<Post>> searchPosts(String query) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot;

      if (query != "") {
        querySnapshot = await _firestore
            .collection('posts')
            .where('description', isEqualTo: query)
            .get();
      } else {
        querySnapshot = await _firestore.collection('posts').get();
      }

      List<Post> posts = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        Post post = Post(
            postId: doc.id,
            postUserId: data['postUserId'],
            title: data["title"],
            description: data['description'],
            photoUrl: data['photoUrl'],
            createdAt: data['createdAt'].toDate(),
            likesCount: data['likesCount'],
            // commentList: comments,
            likesList: List<String>.from(data["likesList"]));

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

        Post post = Post(
          postId: doc.id,
          postUserId: data['postUserId'],
          title: data["title"],
          description: data['description'],
          photoUrl: data['photoUrl'],
          createdAt: data['createdAt'].toDate(),
          likesCount: data['likesCount'],
          // commentList: comments,
          commentCount: data["commentCount"],
          likesList: List<String>.from(data["likesList"]),
        );
        posts.add(post);
      }
      return posts;
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }

  Future<List<Comment>> getCommentByPostId(String postId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .get();

      List<Comment> comments = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        Comment comment = Comment(
            commentId: doc.id,
            postId: data["postId"],
            description: data["description"],
            commentUserId: data["commentUserId"]);

        comments.add(comment);
      }
      return comments;
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
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
      final User? user = _auth?.currentUser;
      final userId = user?.uid;

      DocumentReference postRef =
          _firestore.collection("posts").doc(post.postId);

      await postRef.update({
        "likesList": FieldValue.arrayUnion([userId]),
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> dislikePost(Post post) async {
    try {
      final User? user = _auth?.currentUser;
      final userId = user?.uid;

      DocumentReference postRef =
          _firestore.collection("posts").doc(post.postId);

      await postRef.update({
        "likesList": FieldValue.arrayRemove([userId]),
      });

      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isPostLiked(Post post) async {
    // Get the current user's ID
    String? userId = _auth?.currentUser?.uid;
    if (userId == null) {
      // If the user is not logged in, return false
      return false;
    }

    // Check if the post is liked by the current user
    DocumentSnapshot snapshot = await _firestore
        .collection('posts')
        .doc(post.postId)
        .collection('likes')
        .doc(userId)
        .get();

    // Return true if the post is liked, false otherwise
    return snapshot.exists;
  }

  Future<void> deleteComment(String commentId, String postId) async {
    try {
      DocumentReference commentRef =
          _firestore.collection("comments").doc(commentId);

      await commentRef.delete();

      final postRef = _firestore.collection('posts').doc(postId);
      final postDoc = await postRef.get();

      final currentCommentCount = postDoc['commentCount'] ?? 0;
      final newCommentCount = currentCommentCount - 1;

      // Update the post document with the new comment count
      await postRef.update({'commentCount': newCommentCount});
    } catch (e) {
      throw Exception('Failed to delete comment: $e');
    }
  }
}
