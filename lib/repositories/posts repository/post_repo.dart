import 'package:recychamp/models/post.dart';
import 'package:recychamp/services/post_service.dart';

class PostRepository {
  final PostService _postService;

  PostRepository({required PostService postService})
      : _postService = postService;

  Future<void> addPost(Post post) async {
    await _postService.addPost(post);
  }


  // Future<Post?> getPostById(String postId) async {
  //   return _postService.getPostById(postId);
  // }

  // Future<void> updatePost(Post post) async {
  //   await _postService.updatePost(post);
  // }

  // Future<void> deletePost(String postId) async {
  //   await _postService.deletePost(postId);
  // }

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

//   Future<Post?> getPostById(String postId) async {
//     return _postService.getPostById(postId);
//   }

//   Future<void> updatePost(Post post) async {
//     await _postService.updatePost(post);
//   }

//   Future<void> deletePost(String postId) async {
//     await _postService.deletePost(postId);

//   }

  // Future<List<Post>> applyFilters(Set<String> filters) async {
  //   try {
  //     return await _postService.applyFilters(filters);
  //   } catch (e) {
  //     throw Exception('Failed to apply filters: $e');
  //   }
  // }
}




















// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart' show immutable;
// import 'package:recychamp/constants/collection_names.dart';
// import 'package:recychamp/models/post.dart';
// import 'package:uuid/uuid.dart';

// @immutable
// class PostRepository {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final _storage = FirebaseStorage.instance;

//   //Post Creation
//   Future<String?> makePost({
//     required String postContent,
//     required File postFile,
//     required String postType,
//   }) async {
//     try {
//       final postId = const Uuid().v1();
//       final postUserId = _auth.currentUser!.uid;
//       final now = DateTime.now();

//       //Post to Storage
//       final fileUid = const Uuid().v1();
//       final path = _storage.ref(postType).child(fileUid);
//       final processSnapshot = await path.putFile(postFile);
//       final downloadUrl = await processSnapshot.ref.getDownloadURL();

//       // Creating a post
//       Post post = Post(
//         postId: postId,
//         postUserId: postUserId,
//         content: postContent,
//         postType: postType,
//         postUrl: downloadUrl,
//         createdAt: now,
//         likesList: [],
//       );

//       // Put our post into the firestore
//       _firestore
//           .collection(CollectionNames.posts)
//           .doc(postId)
//           .set(post.toMap());

//       return null;
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   //Method to like  a post
//   Future<String?> likePosts({
//     required String postId,
//     required List<String> likesList,
//   }) async {
//     try {
//       final userId = _auth.currentUser!.uid;

//       if (likesList.contains(userId)) {
//         likesList.remove(userId);
//       } else {
//         likesList.add(userId);
//       }

//       // Update likes in Firestore
//       await _firestore
//           .collection(CollectionNames.posts)
//           .doc(postId)
//           .update({'likesList': likesList});
//       return null;
//     } catch (e) {
//       return e.toString();
//     }
//   }
// }
