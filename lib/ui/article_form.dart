import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import 'dart:typed_data';
import 'package:flutter_svg/svg.dart';

import 'package:recychamp/screens/EducationalResources/bloc/article_details_bloc.dart';
import 'package:recychamp/services/article_service.dart';

class AricleForms extends StatefulWidget {
  const AricleForms({super.key});

  @override
  State<AricleForms> createState() => _AricleForm();
}

class _AricleForm extends State<AricleForms> {
  Uint8List? _file;
  final TextEditingController articleDescriptionController =
      TextEditingController();
  bool isLoading = false;
  String? selectedType;
  final TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _selectImage(BuildContext parentContext, ImageSource source) async {
    final picker = ImagePicker();
    Uint8List file = (await picker.pickImage(source: source)) as Uint8List;
    setState(() {
      _file = file;
    });
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
                                    Navigator.of(context).pop();
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

                      // Title Textfield
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
                                } else if (val.length < 25) {
                                  return 'Title must be at least 25 characters long';
                                } else {
                                  return null; // No error, input is valid
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
                        margin: const EdgeInsets.only(bottom: 20),
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
                              items: ["Nature", "Trees", "Plants", "Others"]
                                  .map((String type) {
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
                                } else if (val.length < 100) {
                                  return 'Description must be at least 100 characters long';
                                } else {
                                  return null; // No error, input is valid
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
                            Text(
                              "Image",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                color: Colors.black
                                    .withOpacity(0.6000000238418579),
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
                // submit button
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
                            "articleImage":
                                _file, // You might need to convert it to a String URL or store it differently based on your requirements
                            "articleType": selectedType,
                          };

                          ArticleService articleService = ArticleService(
                            firestore: FirebaseFirestore.instance,
                            storage: FirebaseStorage.instance,
                          );

                          try {
                            await articleService.addArticle(formData);
                            // Data added successfully
                            // You can perform additional actions or show a success message

                            // Clear the form
                            textController.clear();
                            articleDescriptionController.clear();
                            // Clear the selected image
                            setState(() {
                              _file = null;
                            });

                            // Navigate back to the previous screen
                            Navigator.pop(context, true);
                          } catch (e) {
                            rethrow;
                            // Handle errors
                            // You can show an error message to the user
                          }
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
