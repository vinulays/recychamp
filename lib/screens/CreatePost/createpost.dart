import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recychamp/models/post.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import 'package:recychamp/services/post_service.dart';

class CreatePost extends StatefulWidget {
  final Post? post;
  final bool isUpdate;
  const CreatePost({super.key, this.post, required this.isUpdate});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String userImageURL = "";

  Uint8List? _file;
  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postDescriptionController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late final PostService _postService;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize PostService with Firestore and FirebaseStorage instances
    _postService = PostService(
      firestore: FirebaseFirestore.instance,
      storage: FirebaseStorage.instance,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isUpdate) {
        setState(() {
          _postTitleController.text = widget.post!.title;
          _postDescriptionController.text = widget.post!.description;
        });
        // setState(() {
        //   imageURL = widget.challenge!.imageURL;
        // });
      }
    });

    getUserImage();
  }

  Future<void> getUserImage() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        String? imageURL = await userSnapshot.get("imageUrl");

        setState(() {
          userImageURL = imageURL!;
        });
      }
    } catch (error) {
      throw Exception("Error getting image: $error");
    }
  }
  // void _selectImage(BuildContext parentContext, ImageSource source) async {
  //   final picker = ImagePicker();
  //   Uint8List file = (await picker.pickImage(source: source)) as Uint8List;
  //   setState(() {
  //     _file = file;
  //   });
  // }

  Future<void> _selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _file = bytes;
      });
    }
  }

  Future<void> _publishPost() async {
    // Check if any of the required fields are empty
    if (_postTitleController.text.isEmpty ||
        _postDescriptionController.text.isEmpty ||
        _file == null) {
      // Display a message to the user indicating that a field is missing
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields and choose a photo')),
      );
      return; // Exit the method without publishing the post
    }

    final userId = FirebaseAuth.instance.currentUser!.uid;
    final imageUrl = await _uploadImage();

    final post = Post(
      postUserId: userId,
      title: _postTitleController.text,
      description: _postDescriptionController.text,
      photoUrl: imageUrl,
      createdAt: DateTime.now(),
      likesCount: 0,
      commentList: [],
    );

    await _postService.addPost(post);

    // Clear input fields and selected image
    _postTitleController.clear();
    _postDescriptionController.clear();
    setState(() {
      _file = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post published successfully')),
    );
  }

  Future<void> _updatePost() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final imageUrl = await _uploadImage();

    final post = Post(
      postId: widget.post?.postId,
      title: _postTitleController.text,
      description: _postDescriptionController.text,
      createdAt: DateTime.now(),
    );

    await _postService.updatePost(post);

    // Clear input fields and selected image
    _postTitleController.clear();
    _postDescriptionController.clear();
    setState(() {
      _file = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post updated successfully')),
    );
  }

  Future<String> _uploadImage() async {
    if (_file == null) {
      return '';
    }

    final ref = FirebaseStorage.instance
        .ref()
        .child('postImages')
        .child(DateTime.now().toString());
    final uploadTask = ref.putData(_file!);
    final snapshot = await uploadTask.whenComplete(() => null);
    final imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  // void _publishPost() async {
  //   try {
  //     String imageUrl = '';
  //     // Upload the image if available
  //     if (_file != null) {
  //       imageUrl = await _postService.uploadImage(_file!);
  //     }

  //     String userId = FirebaseAuth.instance.currentUser!.uid;

  //     // Create a new Post object
  //     Post post = Post(
  //       postUserId: userId,
  //       title: _postTitleController.text,
  //       description: _PostDescriptionController.text,
  //       photoUrl: imageUrl,
  //       createdAt: DateTime.now(),
  //       likesCount: 0,
  //       commentList: []
  //     );

  //     // Add the post to Firestore
  //     await _postService.addPost(post);

  //     // Show success message
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Post published successfully')),
  //     );

  //     // Clear input fields and selected image
  //     _postTitleController.clear();
  //     _PostDescriptionController.clear();
  //     setState(() {
  //       _file = null;
  //     });
  //   } catch (e) {
  //     // Show error message if post publishing fails
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to publish post: $e')),
  //     );
  //   }
  // }

  // _selectImageFromCamera(BuildContext parentContext) {
  //   _selectImage(parentContext, ImageSource.camera);
  // }

  // _selectImageFromGallery(BuildContext parentContext) {
  //   _selectImage(parentContext, ImageSource.gallery);
  // }

  // _showDialog(BuildContext parentContext) {
  //   showDialog(
  //     context: parentContext,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         title: const Text('Create a Post'),
  //         children: <Widget>[
  //           SimpleDialogOption(
  //             padding: const EdgeInsets.all(20),
  //             child: const Text('Take a photo'),
  //             onPressed: () => _selectImageFromCamera(context),
  //           ),
  //           SimpleDialogOption(
  //             padding: const EdgeInsets.all(20),
  //             child: const Text('Choose from Gallery'),
  //             onPressed: () => _selectImageFromGallery(context),
  //           ),
  //           SimpleDialogOption(
  //             padding: const EdgeInsets.all(20),
  //             child: const Text("Cancel"),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                "assets/icons/go_back.svg",
                                colorFilter: const ColorFilter.mode(
                                    Colors.black, BlendMode.srcIn),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text("Create Post",
                                style: kFontFamily(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userImageURL),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Chamoth Mendis",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextField(
                      controller: _postTitleController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: "Title.....",
                        hintMaxLines: 8,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF75A488), width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF75A488), width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextField(
                      controller: _postDescriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Description.....",
                        hintMaxLines: 8,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF75A488), width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF75A488), width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF75A488), width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Upload a photo",
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "JPG, PNG, SVG",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.6000000238418579),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormBuilderField(
                          name: "imageURL",
                          builder: (FormFieldState<dynamic> field) {
                            return TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 10.88, horizontal: 20)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFF75A488)
                                            .withOpacity(0.6000000238418579)),
                              ),
                              onPressed: () {
                                _selectImage();
                              },
                              child: Text(
                                "Choose file",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            );
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 350,
                  //   width: 350,
                  //   child: Container(
                  //     width: 150,
                  //     height: 150,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey),
                  //       borderRadius: BorderRadius.circular(10),
                  //       image: DecorationImage(
                  //         image: NetworkImage(
                  //             "https://images.unsplash.com/photo-1622254936966-4a3c4def576f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZW52aXJvbm1lbnRhbCUyMHByb3RlY3Rpb258ZW58MHx8MHx8fDA%3D"),
                  //         fit: BoxFit.fill,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // submit button
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // post publish

                    if (widget.isUpdate) {
                      _updatePost();
                    } else {
                      _publishPost();
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.8),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 17.88)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: Text(
                    "Publish",
                    style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
