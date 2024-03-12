import 'package:flutter/foundation.dart' show immutable;
import 'package:recychamp/models/comment.dart';

@immutable
class Post {
  final String? postId;
  final String postUserId;
  final String title;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  final int likesCount;
  final List<Comment> commentList;

  const Post({
    this.postId,
    required this.title,
    required this.postUserId,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.likesCount,
    required this.commentList,
  });

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'postUserId': postUserId,
      'title': title,
      'description': description,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'commentList': commentList.map((comment) => comment.toJson()).toList(),
    };
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'postId': postId,
  //     'postUserId': postUserId,
  //     'content': content,
  //     'postType': postType,
  //     'postUrl': postUrl,
  //     'createdAt': createdAt.millisecondsSinceEpoch,
  //     'likeslist': likesList,
  //   };
  // }

  // // Factory method to create a Post from a map
  // factory Post.fromMap(Map<String, dynamic> map) {
  //   return Post(
  //       postId: map['postId'] ?? '',
  //       postUserId: map['postUserId'] ?? '',
  //       content: map['content'] ?? '',
  //       postType: map['postType'] ?? '',
  //       postUrl: map['postUrl'] ?? '',
  //       createdAt: DateTime.fromMillisecondsSinceEpoch(
  //         map['createdAt'] ?? 0,
  //       ),
  //       likesList: List<String>.from((map['likesList'] ?? [])));
  // }
}
