import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:like_button/like_button.dart';
import 'package:recychamp/models/comment.dart';
import 'package:recychamp/models/post.dart';
import 'package:recychamp/screens/CreatePost/createpost.dart';
import 'package:recychamp/services/post_service.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final PostService postService;
  const PostCard({super.key, required this.post, required this.postService});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  PostService postService = PostService(
      firestore: FirebaseFirestore.instance, storage: FirebaseStorage.instance);
  final TextEditingController _commentController = TextEditingController();
  List<Comment> comments = [];
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    void deletePost() {
      // Display a dialog box to confirm deletion
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Post"),
            content: const Text("Are you sure you want to delete this post?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  // Delete the post from Firestore
                  try {
                    // Call the deletePost method from your PostService
                    await widget.postService.deletePost(widget.post.postId!);
                    Navigator.of(context).pop(); // Close the dialog
                  } catch (e) {
                    // Handle any errors
                    print("Failed to delete post: $e");
                    // Optionally, display an error message
                    // You can also handle this error in a more user-friendly way
                  }
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }

    return Container(
      margin: EdgeInsets.only(
          left: deviceData.size.width * 0.05,
          right: deviceData.size.width * 0.05,
          bottom: deviceData.size.width * 0.05),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Colors.black.withOpacity(0.10000000149011612),
          ),
          borderRadius: BorderRadius.circular(12.62),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBpY3xlbnwwfHwwfHx8MA%3D%3D"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.32,
                      ),
                    ),
                    Text(
                      'Posted ${Jiffy.parse(widget.post.createdAt.toString()).format(pattern: "MMMM do")}',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF747474),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.22,
                      ),
                    )
                  ],
                ),
                Column(children: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(
                            value: 0, child: Text("Delete Post")),
                        const PopupMenuItem<int>(
                            value: 1, child: Text("Update Post")),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                        deletePost();
                      } else if (value == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreatePost(
                              isUpdate: true,
                              post: widget.post,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ]),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.post.title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.40,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 200,
              decoration: ShapeDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.post.photoUrl!),
                      fit: BoxFit.cover),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.83))),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.post.description,
              style: GoogleFonts.poppins(
                color: const Color(0xFF1E1E1E),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(
                  onTap: (_) {
                    return postService.likePost(widget.post);
                  },
                  size: 30,
                  circleColor:
                      const CircleColor(start: Colors.red, end: Colors.red),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Colors.red,
                    dotSecondaryColor: Colors.red,
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      CupertinoIcons.heart_fill,
                      color: isLiked ? Colors.red : Colors.grey,
                      size: 30,
                    );
                  },
                  likeCount: widget.post.likesCount,
                  // countBuilder: (int count, bool isLiked, String text) {
                  //   var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                  //   Widget result;
                  //   if (count == 0) {
                  //     result = Text(
                  //       "love",
                  //       style: TextStyle(color: color),
                  //     );
                  //   } else
                  //     result = Text(
                  //       text,
                  //       style: TextStyle(color: color),
                  //     );
                  //   return result;
                  // },
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListView(children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          widget.post.commentList?.length,
                                      itemBuilder: (context, index) {
                                        Comment comment =
                                            widget.post.commentList![index];
                                        return Container(
                                          margin: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    width: 46,
                                                    height: 46,
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww"),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.15)),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5,
                                                            horizontal: 7),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Chamoth Mendis",
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                              comment
                                                                  .description,
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ]),
                                ),
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: deviceData.size.width * 0.05),
                                  child: TextField(
                                    controller: _commentController,
                                    onSubmitted: (query) {},
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(14),
                                        suffixIconConstraints:
                                            const BoxConstraints(
                                                maxHeight: 26, minWidth: 26),
                                        suffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: InkWell(
                                            onTap: () {
                                              widget.postService
                                                  .addCommentToPost(
                                                      widget.post.postId!,
                                                      _commentController.text);
                                            },
                                            child: const Icon(Icons.send),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xffE6EEEA),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(12.62),
                                        ),
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 17,
                                            color: const Color(0xff75A488)),
                                        hintText: "Comment as Chamoth Mendis"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.comment_rounded,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Comments (${widget.post.commentList?.length})",
                        style: GoogleFonts.poppins(fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
