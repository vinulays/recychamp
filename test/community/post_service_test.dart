// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:recychamp/models/comment.dart';
// import 'package:recychamp/models/post.dart';
// import 'package:recychamp/services/post_service.dart';

// void main() {
//   late PostService postService;
//   late FakeFirebaseFirestore fakeFirebaseFirestore;
//   late MockFirebaseStorage mockFirebaseStorage;
  

//   setUpAll(() {
//     fakeFirebaseFirestore = FakeFirebaseFirestore();
//     mockFirebaseStorage = MockFirebaseStorage();
//     postService = PostService(
//       firestore: fakeFirebaseFirestore,
//       storage: mockFirebaseStorage,
//     );
//   });

//   test("adding and getting posts from firebase", () async {
//     final post = Post(
//       postId: "1",
//       postUserId: "user1",
//       title: "Test Post",
//       description: "This is a test post",
//       photoUrl:
//           "https://images.unsplash.com/photo-1682687221080-5cb261c645cb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
//       createdAt: DateTime.now(),
//       likesCount: 0,
//       commentCount: 0,
//       likesList: [],
//     );

//     await postService.addPost(post);

//     final posts = await postService.getAllPosts();

//     expect(posts.length, 1);
//   });

//   test("updating post in firebase", () async {
//     final post = Post(
//       postId: "1",
//       postUserId: "user1",
//       title: "Test Post",
//       description: "This is a test post",
//       photoUrl:
//           "https://images.unsplash.com/photo-1682687221080-5cb261c645cb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
//       createdAt: DateTime.now(),
//       likesCount: 0,
//       commentCount: 0,
//       likesList: [],
//     );

//     await postService.addPost(post);

//     final updatedPost = Post(
//       postId: "1",
//       postUserId: "user1",
//       title: "Updated Test Post",
//       description: "This is an updated test post",
//       photoUrl:
//           "https://images.unsplash.com/photo-1682687221080-5cb261c645cb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
//       createdAt: DateTime.now(),
//       likesCount: 0,
//       commentCount: 0,
//       likesList: [],
//     );

//     await postService.updatePost(updatedPost);

//     final posts = await postService.getAllPosts();

//     expect(posts[0].title, "Updated Test Post");
//     expect(posts[0].description, "This is an updated test post");
//   });

//   test("deleting post from firebase", () async {
//     final post = Post(
//       postId: "1",
//       postUserId: "user1",
//       title: "Test Post",
//       description: "This is a test post",
//       photoUrl:
//           "https://images.unsplash.com/photo-1682687221080-5cb261c645cb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
//       createdAt: DateTime.now(),
//       likesCount: 0,
//       commentCount: 0,
//       likesList: [],
//     );

//     await postService.addPost(post);

//     await postService.deletePost("1");

//     final posts = await postService.getAllPosts();

//     expect(posts.length, 0);
//   });

//   test("adding and getting comments from firebase", () async {
//     final comment = Comment(
//       commentId: "1",
//       postId: "1",
//       commentUserId: "user1",
//       description: "This is a test comment",
//     );

//     await postService.addComment("1", "This is a test comment");

//     final comments = await postService.getCommentByPostId("1");

//     expect(comments.length, 1);
//   });

//   test("deleting comment from firebase", () async {
//     final comment = Comment(
//       commentId: "1",
//       postId: "1",
//       commentUserId: "user1",
//       description: "This is a test comment",
//     );

//     await postService.addComment("1", "This is a test comment");

//     await postService.deleteComment("1", "1");

//     final comments = await postService.getCommentByPostId("1");

//     expect(comments.length, 0);
//   });

//   test("liking and disliking post in firebase", () async {
//     final post = Post(
//       postId: "1",
//       postUserId: "user1",
//       title: "Test Post",
//       description: "This is a test post",
//       photoUrl:
//           "https://images.unsplash.com/photo-1682687221080-5cb261c645cb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
//       createdAt: DateTime.now(),
//       likesCount: 0,
//       commentCount: 0,
//       likesList: [],
//     );

//     await postService.addPost(post);

//     await postService.likePost(post);

//     var liked = await postService.isPostLiked(post);

//     expect(liked, true);

//     await postService.dislikePost(post);

//     liked = await postService.isPostLiked(post);

//     expect(liked, false);
//   });
// }
