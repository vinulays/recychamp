import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:recychamp/constants/collection_names.dart';
import 'package:recychamp/models/post.dart';
import 'package:uuid/uuid.dart';

@immutable
class PostRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  //Post Creation
  Future<String?> makePost({
    required String content,
    required File file,
    required String postType,
  }) async {
    try {
      final postId = const Uuid().v1();
      final postUserId = _auth.currentUser!.uid;
      final now = DateTime.now();

      //Post to Storage
      final fileUid = const Uuid().v1();
      final path = _storage.ref(postType).child(fileUid);
      final processSnapshot = await path.putFile(file);
      final downloadUrl = await processSnapshot.ref.getDownloadURL();

      // Creating a post
      Post post = Post(
        postId: postId,
        postUserId: postUserId,
        content: content,
        postType: postType,
        postUrl: downloadUrl,
        createdAt: now,
        likes: [],
      );

      // Put our post into the firestore
      _firestore
          .collection(CollectionNames.posts)
          .doc(postId)
          .set(post.toMap());

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  //Method to like  a post
  Future<String?> likePosts({
    required String postId,
    required List<String> likes,
  }) async {
    try {
      final userId = _auth.currentUser!.uid;

      if (likes.contains(userId)) {
        _firestore.collection(CollectionNames.posts).doc(postId);
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
