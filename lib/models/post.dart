import 'package:flutter/foundation.dart' show immutable;

@immutable
class Post {
  final String postId;
  final String postUserId;
  final String description;
  final String postUrl;
  final DateTime createdAt;
  final List<String> likesList;
  final List<String> commentList;

  const Post(
      {required this.postId,
      required this.postUserId,
      required this.description,
      required this.postUrl,
      required this.createdAt,
      required this.likesList,
      required this.commentList});

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
