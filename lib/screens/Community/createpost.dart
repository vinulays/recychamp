import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recychamp/models/user.dart';
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
    Navigator.pop(parentContext); // Close the dialog
    final picker = ImagePicker();
    Uint8List file = (await picker.pickImage(source: source)) as Uint8List;
    setState(() {
      _file = file;
    });
  }

  _selectImageFromCamera(BuildContext parentContext) {
    _selectImage(parentContext, ImageSource.camera);
  }

  _selectImageFromGallery(BuildContext parentContext) {
    _selectImage(parentContext, ImageSource.gallery);
  }

  _showDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () => _selectImageFromCamera(context),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () => _selectImageFromGallery(context),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context, ImageSource.gallery),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text("Publish Post"),
              centerTitle: true,
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Publish",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ))
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(""),
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
                SizedBox(
                  height: 350,
                  width: 350,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1622254936966-4a3c4def576f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZW52aXJvbm1lbnRhbCUyMHByb3RlY3Rpb258ZW58MHx8MHx8fDA%3D"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
