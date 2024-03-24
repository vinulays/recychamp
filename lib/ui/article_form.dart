import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recychamp/models/article_model.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import 'dart:typed_data';
import 'package:flutter_svg/svg.dart';

import 'package:recychamp/screens/EducationalResources/bloc/article_details_bloc.dart';
import 'package:recychamp/services/article_service.dart';

class AricleForms extends StatefulWidget {
  const AricleForms({
    Key? key,
  }) : super(key: key);

  @override
  State<AricleForms> createState() => _AricleForm();
}

class _AricleForm extends State<AricleForms> {
  Uint8List? _file;
  final TextEditingController articleDescriptionController =
      TextEditingController();
  final TextEditingController articleContentController =
      TextEditingController();
  bool isLoading = false;
  String? selectedType;
  final TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String? _imageUrl;

  Future<String?> _uploadImage(File imageFile) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('article_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  void _selectImage(BuildContext parentContext, ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path).readAsBytesSync();
      });
      final imageUrl = await _uploadImage(File(pickedFile.path));
      if (imageUrl != null) {
        setState(() {
          _imageUrl = imageUrl;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
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
                                    // Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text(
                                              "Go back",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            content: Text(
                                              "You will lost unsaved data if you go back. Do you really want to go back?",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14),
                                                  )),
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14),
                                                  )),
                                            ],
                                          );
                                        });
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/go_back.svg",
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black, BlendMode.srcIn),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text("Add an Article",
                                    style: kFontFamily(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            TextFormField(
                              maxLines: 1,
                              controller: textController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please enter a title';
                                } else if (val.length > 30) {
                                  return 'Title must be maximum 30 characters long';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter title...",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF75A488),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF75A488),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            DropdownButtonFormField<String>(
                              value: selectedType,
                              items: [
                                "Nature",
                                "PlantTrees",
                                "Eco-Friendly",
                                "Recy-Challenges",
                                "Recy-Guides",
                                "Others"
                              ].map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedType = value;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF75A488),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF75A488),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            TextFormField(
                              maxLines: 5,
                              controller: articleDescriptionController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please enter a description';
                                } else if (val.length > 150) {
                                  return 'Description should not be more than 120 characters long';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter description...",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF75A488),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF75A488),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Content",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            TextFormField(
                              maxLines: 10,
                              controller: articleContentController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please enter a content';
                                } else if (val.length < 250) {
                                  return 'Content must be at least 250 characters long';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter content...",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF75A488),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF75A488),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 450,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF75A488), width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Image",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _imageUrl != null
                                ? Image.network(_imageUrl!)
                                : _file != null
                                    ? Image.memory(_file!)
                                    : const Icon(Icons.upload),
                            const SizedBox(
                              height: 5,
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
                                            const Color(0xFF75A488).withOpacity(
                                                0.6000000238418579)),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        // Extract form data
                        if (_formKey.currentState?.validate() ?? false) {
                          Map<String, dynamic> formData = {
                            "articleTitle": textController.text,
                            "description": articleDescriptionController.text,
                            "articleImage": _imageUrl ?? '',
                            "articleType": selectedType,
                            "content": articleContentController.text,
                          };

                          context
                              .read<ArticleDetailsBloc>()
                              .add(AddArticleEvent(formData));

                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        "Add Article",
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
        ),
      ),
    );
  }
}
