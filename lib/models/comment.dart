class Comment {
  final String commentId;
  final String commentUserId;
  final String description;
  final String postId;

  Comment(
      {required this.commentId,
      required this.postId,
      required this.commentUserId,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'commentUserId': commentUserId,
      'description': description,
    };
  }
}
