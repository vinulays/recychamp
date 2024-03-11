import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recychamp/screens/Calendar/constants.dart';

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
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1517849845537-4d257902454a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww"),
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
                                _selectImage(context, ImageSource.gallery);
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
                    // todo add challenge submit form
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
