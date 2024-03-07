import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/models/challenge_category.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/ui/form_date_time_picker.dart';
import 'package:recychamp/ui/form_drop_down.dart';
import 'package:recychamp/ui/form_input_field.dart';
import 'package:recychamp/ui/form_text_area.dart';
import 'package:recychamp/utils/challenge_categories.dart';
import 'package:recychamp/utils/challenge_utils.dart';
import 'package:path/path.dart';

class ChallengeForm extends StatefulWidget {
  final Challenge? challenge;
  final bool isUpdate;
  const ChallengeForm({super.key, this.challenge, required this.isUpdate});

  @override
  State<ChallengeForm> createState() => _ChallengeFormState();
}

class _ChallengeFormState extends State<ChallengeForm> {
  File? _image;
  String? imageURL;

  String? _imageName;
  String? _imageSize = "";
  double uploadPercentage = 0;
  bool isImageUpdated = false;

  final _formKey = GlobalKey<FormBuilderState>();

  // * get categories from the utils file
  final List<ChallengeCategory> _categories = challengeCategories;

  @override
  void initState() {
    super.initState();

    // * Filling the form data after the widget is initialized (only in the update form)
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isUpdate && _formKey.currentState != null) {
        _formKey.currentState!.patchValue({
          "title": widget.challenge!.title,
          "description": widget.challenge!.description,
          "type": widget.challenge!.type,
          "location": widget.challenge!.location,
          "country": widget.challenge!.country,
          "maximumParticipants":
              widget.challenge!.maximumParticipants.toString(),
          "rules": widget.challenge!.rules,
          "difficulty": widget.challenge!.difficulty,
          "categoryId": widget.challenge!.categoryId,
          "startDate": widget.challenge!.startDateTime,
          "startTime": widget.challenge!.startDateTime,
          "endDate": widget.challenge!.endDateTime,
          "endTime": widget.challenge!.endDateTime,
          "imageURL": widget.challenge!.imageURL
        });

        setState(() {
          imageURL = widget.challenge!.imageURL;
        });
      }
    });
  }

  // * selected image file from the file system (use flutter file picker library)
  Future<void> _getImage() async {
    PermissionStatus status = await Permission.photos.request();
    if (status.isGranted) {
      FilePickerResult? pickedImage = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);

      setState(() {
        if (pickedImage != null) {
          _image = File(pickedImage.files.single.path!);
          _getImageSize();
          _getImageName();
          _uploadImageToFirebase();
        }
      });
    }
  }

  //  * getting selected file size from utils file
  Future<void> _getImageSize() async {
    String sizeString = await getImageSize(_image!);
    setState(() {
      _imageSize = sizeString;
    });
  }

  // * get selected image name using flutter path library
  void _getImageName() {
    if (_image != null) {
      setState(() {
        _imageName = basename(_image!.path);
      });
    }
  }

  //  * deleting the uploaded image from the firebase when clicked closed button in upload progress
  Future<void> _deleteImageFromFirebase() async {
    Reference imageRef = FirebaseStorage.instance.refFromURL(imageURL!);
    await imageRef.delete();

    if (mounted) {
      setState(() {
        _image = null;
        imageURL = null;
        _imageName = "";
        uploadPercentage = 0;
        _imageSize = "";

        // * resetting the imageURL field
        _formKey.currentState?.setInternalFieldValue("imageURL", null);
        _formKey.currentState?.fields["imageURL"]
            ?.invalidate("Cover photo is required");
      });
    }
  }

  // * uploading image to firebase
  Future<void> _uploadImageToFirebase() async {
    try {
      if (_image != null) {
        String fileExtension = _image!.path.split('.').last;

        // * selecting where to store image file
        // * filename = date & time in milliseconds when image is uploading + file extension
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child("challengeThumbnails")
            .child('${DateTime.now().millisecondsSinceEpoch}.$fileExtension');

        firebase_storage.UploadTask uploadTask = ref.putFile(
          _image!,
          firebase_storage.SettableMetadata(
            contentType: 'image/$fileExtension',
          ),
        );

        // * getting upload percentage
        uploadTask.snapshotEvents.listen(
          (firebase_storage.TaskSnapshot snapshot) {
            double percentage =
                (snapshot.bytesTransferred / snapshot.totalBytes) * 100;

            // * formating percentage to have two decimal positions
            String percentageStr = percentage.toStringAsFixed(2);
            setState(() {
              uploadPercentage = double.parse(percentageStr);
            });
          },
          onError: (e) {
            throw Exception("Upload error");
          },
          // * getting download url after upload completion
          onDone: () async {
            final String downloadURL = await ref.getDownloadURL();
            // * adding downloadURL to the formData
            setState(
              () {
                isImageUpdated = true;
                imageURL = downloadURL;
                _formKey.currentState?.fields["imageURL"]
                    ?.didChange(downloadURL);
              },
            );
          },
        );
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
            child: Column(
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
                                        // * deleting the uploaded image if go back without submitting
                                        if (_image != null) {
                                          _deleteImageFromFirebase();
                                        }

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
                      "${(widget.isUpdate == true ? "Update" : "Add")} a Challenge",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
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
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // * Challenge title
                              FormInputField(
                                title: "Title",
                                isRequired: true,
                                formBuilderName: "title",
                                validators: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Title is required"),
                                  FormBuilderValidators.minLength(10,
                                      errorText:
                                          "Title should be longer than 10 letters"),
                                ]),
                              ),
                              // * Challenge description
                              FormTextArea(
                                title: "Description",
                                isRequired: true,
                                formBuilderName: "description",
                                maxLines: 7,
                                validators: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Description is required"),
                                  FormBuilderValidators.minLength(100,
                                      errorText:
                                          "Description should have at least 100 letters"),
                                ]),
                              ),
                              // * Challenge type
                              FormDropDown(
                                title: "Type",
                                isRequired: true,
                                formBuilderName: "type",
                                items: [
                                  DropdownMenuItem(
                                    value: "challenge",
                                    child: Text(
                                      "Challenge",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "event",
                                    child: Text(
                                      "Event",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                                validators: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Type is required")
                                ]),
                              ),
                              // * Challenge location
                              FormInputField(
                                title: "Location",
                                isRequired: true,
                                formBuilderName: "location",
                                validators: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Location is required"),
                                  FormBuilderValidators.minLength(10,
                                      errorText:
                                          "Location should have at least 10 letters")
                                ]),
                              ),
                              // * Challenge country
                              FormInputField(
                                title: "Country",
                                isRequired: true,
                                formBuilderName: "country",
                                validators: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Country is required"),
                                ]),
                              ),
                              // * Challenge start date & time
                              const Wrap(
                                spacing: 50,
                                children: [
                                  FormDateTimePicker(
                                    title: "Start Date",
                                    isRequired: true,
                                    formBuilderName: "startDate",
                                    iconURL: "assets/icons/calendar.svg",
                                    inputType: InputType.date,
                                  ),
                                  FormDateTimePicker(
                                      title: "Start Time",
                                      isRequired: true,
                                      formBuilderName: "startTime",
                                      iconURL:
                                          "assets/icons/challenge_details_clock.svg",
                                      inputType: InputType.time)
                                ],
                              ),
                              const Wrap(
                                spacing: 50,
                                children: [
                                  FormDateTimePicker(
                                      title: "End Date",
                                      isRequired: true,
                                      formBuilderName: "endDate",
                                      iconURL: "assets/icons/calendar.svg",
                                      inputType: InputType.date),
                                  FormDateTimePicker(
                                      title: "End Time",
                                      isRequired: true,
                                      formBuilderName: "endTime",
                                      iconURL:
                                          "assets/icons/challenge_details_clock.svg",
                                      inputType: InputType.time),
                                ],
                              ),
                              // * Challenge maximum participants
                              FormInputField(
                                title: "Maximum Participants",
                                isRequired: true,
                                formBuilderName: "maximumParticipants",
                                validators: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText:
                                          "Maximum Participants is required"),
                                  FormBuilderValidators.numeric(
                                      errorText:
                                          "Maximum Participants should be a number"),
                                  FormBuilderValidators.min(10,
                                      errorText:
                                          "Minimum Participants should be 10"),
                                  FormBuilderValidators.max(500,
                                      errorText:
                                          "Maximum Particpants should be less than 500")
                                ]),
                              ),
                              // * Challenge rules
                              FormTextArea(
                                title: "Rules",
                                isRequired: true,
                                formBuilderName: "rules",
                                maxLines: 4,
                                validators: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Rules is required"),
                                  FormBuilderValidators.minLength(20,
                                      errorText:
                                          "Description should have at least 20 letters"),
                                ]),
                              ),
                              //  * Challenge difficulty
                              FormDropDown(
                                title: "Difficulty",
                                isRequired: true,
                                formBuilderName: "difficulty",
                                items: [
                                  DropdownMenuItem(
                                    value: "Low",
                                    child: Text(
                                      "Low",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Medium",
                                    child: Text(
                                      "Medium",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "High",
                                    child: Text(
                                      "High",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                                validators: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Difficulty is required"),
                                ]),
                              ),
                              //  * Challenge / Event Category
                              FormDropDown(
                                  title: "Category",
                                  isRequired: true,
                                  formBuilderName: "categoryId",
                                  items: _categories
                                      .map(
                                        (category) => DropdownMenuItem(
                                          value: category.id,
                                          child: Text(
                                            category.name,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  validators: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: "Category is required"),
                                  ])),
                              // * Image

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Cover Photo",
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
                                      margin: const EdgeInsets.only(bottom: 8),
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ((_formKey.currentState !=
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
                                            "Upload a cover photo",
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
                                              builder: (FormFieldState<dynamic>
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
                                                            .all(
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
                                                  onPressed: _image == null
                                                      ? _getImage
                                                      : null,
                                                  child: Text(
                                                    "Choose file",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black),
                                                  ),
                                                );
                                              },
                                              autovalidateMode: AutovalidateMode
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
                                      _formKey.currentState?.fields["imageURL"]
                                              ?.value ==
                                          null)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "Cover photo is required",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: const Color(0xffba000d)),
                                      ),
                                    )
                                ],
                              ),
                              // * Image upload process (with firebase)
                              if (_image != null)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF75A488),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                // * image to be uploaded
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    image: DecorationImage(
                                                        image:
                                                            FileImage(_image!),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    _imageName!,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15),
                                                    // overflow: TextOverflow.visible,
                                                  ),
                                                )
                                              ],
                                            ),
                                            // * close button
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              child: GestureDetector(
                                                onTap: _deleteImageFromFirebase,
                                                child: SvgPicture.asset(
                                                  "assets/icons/close.svg",
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Colors.black,
                                                          BlendMode.srcIn),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: LinearPercentIndicator(
                                          animateFromLastPercent: true,
                                          barRadius: const Radius.circular(10),
                                          lineHeight: 5.0,
                                          percent: uploadPercentage / 100,
                                          animation: true,
                                          animationDuration: 1000,
                                          backgroundColor:
                                              const Color(0xffC8E8D5),
                                          progressColor:
                                              const Color(0xff75A488),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "$uploadPercentage%",
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black.withOpacity(
                                                    0.6000000238418579),
                                              ),
                                            ),
                                            Text(
                                              "$_imageSize",
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black.withOpacity(
                                                    0.6000000238418579),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              // * update form image container (shows the related image to the challenge/event)

                              if (imageURL != null &&
                                  widget.isUpdate == true &&
                                  isImageUpdated == false)
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
                                          imageUrl: imageURL!,
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
                                              _deleteImageFromFirebase();
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

                              // * submit & reset buttons
                              Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!
                                            .saveAndValidate()) {
                                          Map<String, dynamic> formData =
                                              Map<String, dynamic>.from(
                                                  _formKey.currentState!.value);
                                          // * Dispatch the add challenge event
                                          if (widget.isUpdate) {
                                            formData["id"] =
                                                widget.challenge!.id!;
                                            context.read<ChallengesBloc>().add(
                                                UpdateChallengeEvent(formData));
                                            _formKey.currentState!.reset();

                                            // * navigate to challenges screen after the update
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          } else {
                                            context.read<ChallengesBloc>().add(
                                                AddChallengeEvent(formData));
                                            _formKey.currentState!.reset();

                                            Navigator.of(context).pop();
                                          }
                                        }
                                      },
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
                                      child: (state is ChallengeAdding ||
                                              state is ChallengeUpdating)
                                          ? const CircularProgressIndicator()
                                          : Text(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
