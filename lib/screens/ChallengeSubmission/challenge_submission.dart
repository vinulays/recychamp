import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/ui/form_input_field.dart';
import 'package:recychamp/ui/form_text_area.dart';

class ChallengeSubmission extends StatefulWidget {
  final Challenge challenge;
  const ChallengeSubmission({super.key, required this.challenge});

  @override
  State<ChallengeSubmission> createState() => _ChallengeSubmissionState();
}

class _ChallengeSubmissionState extends State<ChallengeSubmission> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? imageURL;
  File? _image;

  Future<void> _getImage() async {
    FilePickerResult? pickedImage = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.files.single.path!);

        // todo: upload selected images before submission
        // _getImageSize();
        // _getImageName();
        // _uploadImageToFirebase();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 41.86,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            content: Text(
                              "You will lost unsaved data if you go back. Do you really want to go back?",
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "No",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    // * deleting the uploaded image if go back without submitting

                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Yes",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  )),
                            ],
                          );
                        });
                  },
                  child: SvgPicture.asset(
                    "assets/icons/go_back.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Submit Challenge",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ScrollbarTheme(
                data: const ScrollbarThemeData(
                  crossAxisMargin: -15,
                  mainAxisMargin: 30,
                ),
                child: Scrollbar(
                  radius: const Radius.circular(16.83),
                  thickness: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Title: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: widget.challenge.title,
                                style: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.50),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Instructions: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: widget.challenge.description,
                                style: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.50),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Due Date: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: Jiffy.parse(
                                        widget.challenge.endDateTime.toString())
                                    .format(pattern: "do MMMM yyyy"),
                                style: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.50),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Reward: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: "Platinum Warrior Badge",
                                style: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.50),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextArea(
                                  title:
                                      "Briefly describe what you did in this challenge",
                                  isRequired: true,
                                  formBuilderName: "description",
                                  maxLines: 4,
                                  validators: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: "Description is required"),
                                    FormBuilderValidators.minLength(100,
                                        errorText:
                                            "Description should have at least 100 letters"),
                                  ]),
                                ),

                                // * Attach photos for submission
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Submission Photos",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFFFF0000),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (imageURL == null)
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ((_formKey
                                                                .currentState !=
                                                            null &&
                                                        _formKey
                                                                .currentState
                                                                ?.fields[
                                                                    "imageURL"]
                                                                ?.value ==
                                                            null))
                                                    ? const Color(0xffba000d)
                                                    : const Color(0xFF75A488),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.upload),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Upload photos",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "JPG, PNG, SVG",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black.withOpacity(
                                                    0.6000000238418579),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            FormBuilderField(
                                                name: "imageURL",
                                                builder:
                                                    (FormFieldState<dynamic>
                                                        field) {
                                                  return TextButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10.88,
                                                                  horizontal:
                                                                      20)),
                                                      backgroundColor:
                                                          MaterialStateProperty.all<
                                                              Color>(const Color(
                                                                  0xFF75A488)
                                                              .withOpacity(
                                                                  0.6000000238418579)),
                                                    ),
                                                    onPressed: _image == null
                                                        ? _getImage
                                                        : null,
                                                    child: Text(
                                                      "Choose files",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  );
                                                },
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (_image == null) {
                                                    return "Cover photo is required";
                                                  }
                                                  return null;
                                                })
                                          ],
                                        ),
                                      ),

                                    // * checking whether the form contains any errros related to the imageURL
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState
                                                ?.fields["imageURL"]?.value ==
                                            null)
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "At least one photo is required",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: const Color(0xffba000d)),
                                        ),
                                      )
                                  ],
                                ),
                                // * Uploaded submission images
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/recychamp.appspot.com/o/challengeThumbnails%2F1709211636709.jpg?alt=media&token=7ce24606-fa27-409b-827a-e13cd7fa2659",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Positioned(
                                          top: -12,
                                          right: -8,
                                          child: GestureDetector(
                                            onTap: () {
                                              // _deleteImageFromFirebase();
                                            },
                                            child: Container(
                                              height: 34,
                                              width: 34,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),

                                // * Challenge rating
                                const SizedBox(
                                  height: 10,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Rate our challenge",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '*',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFFFF0000),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.only(right: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FormTextArea(
                                  title:
                                      "Briefly describe your experiance in this challenge (optional)",
                                  isRequired: false,
                                  formBuilderName: "description",
                                  maxLines: 4,
                                  validators: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: "Description is required"),
                                    FormBuilderValidators.minLength(100,
                                        errorText:
                                            "Description should have at least 100 letters"),
                                  ]),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 10),
                                      child: TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.8),
                                            ),
                                          ),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.symmetric(
                                                  vertical: 17.88)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black),
                                        ),
                                        child: Text(
                                          "Submit",
                                          style: GoogleFonts.poppins(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      ],
                    ),
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
