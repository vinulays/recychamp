import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/screens/ChallengeDetails/bloc/challenge_details_bloc.dart';
import 'package:recychamp/ui/form_text_area.dart';

class ChallengeSubmission extends StatefulWidget {
  final Challenge challenge;
  const ChallengeSubmission({super.key, required this.challenge});

  @override
  State<ChallengeSubmission> createState() => _ChallengeSubmissionState();
}

class _ChallengeSubmissionState extends State<ChallengeSubmission> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> imagePaths = [];

  // * getting selected image file paths and adding to the imagePaths array
  // * for sdkVersion > 32 Permission.photos (currently using sdkVersion 34)
  // * for sdkVersion < 32 Permission.storage
  Future<void> _getImages() async {
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: true, type: FileType.image);

      setState(() {
        if (result != null) {
          for (PlatformFile file in result.files) {
            String imagePath = file.path!;
            setState(() {
              imagePaths.add(imagePath);
              _formKey.currentState!.fields["imageURLs"]!.didChange(imagePaths);
            });
          }
        }
      });
    } else {
      debugPrint("access not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return BlocListener<ChallengeDetailsBloc, ChallengeDetailsState>(
        listener: (context, state) {
          // * going back to the previous page when submission is completed
          if (state is ChallengeSubmitted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }
        },
        child: Scaffold(
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
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
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        // todo: deleting the uploaded image if go back without submitting

                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Yes",
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
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
                                    text: Jiffy.parse(widget
                                            .challenge.endDateTime
                                            .toString())
                                        .format(pattern: "do MMMM yyyy"),
                                    style: GoogleFonts.poppins(
                                      color: DateTime.now().isBefore(
                                              widget.challenge.endDateTime)
                                          ? Colors.black.withOpacity(0.50)
                                          : Colors.red,
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
                            // * challenge submit form
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
                                      validators:
                                          FormBuilderValidators.compose([
                                        FormBuilderValidators.required(
                                            errorText:
                                                "Description is required"),
                                        FormBuilderValidators.minLength(20,
                                            errorText:
                                                "Description should have at least 20 letters"),
                                      ]),
                                    ),

                                    // * Attach photos for submission
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  color:
                                                      const Color(0xFFFF0000),
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
                                        // if (imageURL == null)
                                        // * submission photos upload button
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
                                                                      "imageURLs"]
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
                                                  color: Colors.black
                                                      .withOpacity(
                                                          0.6000000238418579),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              FormBuilderField(
                                                  name: "imageURLs",
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
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        padding:
                                                            MaterialStateProperty.all(
                                                                const EdgeInsets
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
                                                      onPressed: _getImages,
                                                      child: Text(
                                                        "Choose files",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    );
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (value) {
                                                    if (imagePaths.isEmpty) {
                                                      return "Cover photo is required";
                                                    }
                                                    return null;
                                                  })
                                            ],
                                          ),
                                        ),

                                        // * checking whether the form contains any errros related to the imageURLs
                                        if (_formKey.currentState != null &&
                                            _formKey
                                                    .currentState
                                                    ?.fields["imageURLs"]
                                                    ?.value ==
                                                null)
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              "At least one photo is required",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xffba000d)),
                                            ),
                                          )
                                      ],
                                    ),
                                    // * Uploaded submission images
                                    Wrap(
                                      spacing: 20,
                                      children: List.generate(
                                        imagePaths.length,
                                        (index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                SizedBox(
                                                  width: 120,
                                                  height: 120,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: FileImage(
                                                          File(imagePaths[
                                                              index]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    top: -12,
                                                    right: -8,
                                                    child: GestureDetector(
                                                      // * removing the image from image paths array when clicked the basket icon
                                                      onTap: () {
                                                        setState(() {
                                                          imagePaths
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 34,
                                                        width: 34,
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          );
                                        },
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

                                    // * registering rating bar in form builder using formbuilderfield
                                    FormBuilderField(
                                      name: "rating",
                                      builder: (FormFieldState<dynamic> field) {
                                        return RatingBar.builder(
                                          initialRating: 0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.only(right: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            _formKey.currentState!
                                                .setInternalFieldValue(
                                                    "rating", rating);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const FormTextArea(
                                      title:
                                          "Briefly describe your experiance in this challenge (optional)",
                                      isRequired: false,
                                      formBuilderName: "experience",
                                      maxLines: 4,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          child: TextButton(
                                              onPressed: () {
                                                // * calling submit challenge event
                                                if (_formKey.currentState!
                                                    .saveAndValidate()) {
                                                  context
                                                      .read<
                                                          ChallengeDetailsBloc>()
                                                      .add(SubmitChallengeEvent(
                                                          _formKey.currentState!
                                                              .value,
                                                          widget
                                                              .challenge.id!));
                                                }
                                              },
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.8),
                                                  ),
                                                ),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 17.88)),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.black),
                                              ),
                                              child: BlocBuilder<
                                                  ChallengeDetailsBloc,
                                                  ChallengeDetailsState>(
                                                builder: (context, state) {
                                                  if (state
                                                      is ChallengeSubmitting) {
                                                    return const SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 7,
                                                          color: Colors.white,
                                                          strokeCap:
                                                              StrokeCap.round,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Text(
                                                      "Submit",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white),
                                                    );
                                                  }
                                                },
                                              )),
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
        ));
  }
}
