import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recychamp/models/user.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import 'package:recychamp/screens/Community/user_provider.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Uint8List? _file;
  final TextEditingController _PostDescriptionController =
      TextEditingController();
  bool isLoading = false;

  void _selectImage(BuildContext parentContext, ImageSource source) async {
    final picker = ImagePicker();
    Uint8List file = (await picker.pickImage(source: source)) as Uint8List;
    setState(() {
      _file = file;
    });
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectImage(context, ImageSource.gallery);
        },
        backgroundColor: const Color(0xFF75A488),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(
          Icons.attach_file_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 130,
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
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
                const Icon(Icons.settings)
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1517849845537-4d257902454a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww"),
                ),
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Description.....",
                    hintMaxLines: 8,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
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
    );
  }
}
