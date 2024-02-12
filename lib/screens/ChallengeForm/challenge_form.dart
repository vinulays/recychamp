import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recychamp/models/challenge_category.dart';
import 'package:recychamp/repositories/challenge_category_repository.dart';
import 'package:recychamp/services/challenge_category_service.dart';
import 'package:recychamp/ui/form_date_time_picker.dart';
import 'package:recychamp/ui/form_drop_down.dart';
import 'package:recychamp/ui/form_input_field.dart';
import 'package:recychamp/ui/form_text_area.dart';

class ChallengeForm extends StatefulWidget {
  const ChallengeForm({super.key});

  @override
  State<ChallengeForm> createState() => _ChallengeFormState();
}

class _ChallengeFormState extends State<ChallengeForm> {
  File? _image;

  final ChallengeCategoryRepository _categoryRepository =
      ChallengeCategoryRepository(
    challengeCategoryService:
        ChallengeCategoryService(firestore: FirebaseFirestore.instance),
  );

  List<ChallengeCategory> _categories = [];

// * loading categories from firebase when initiating the widget
  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      List<ChallengeCategory> categories =
          await _categoryRepository.getChallengeCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      // Handle error
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
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
          children: [
            const SizedBox(
              height: 41.86,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    "assets/icons/go_back.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Add a Challenge",
                  style: GoogleFonts.almarai(
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
              child: SingleChildScrollView(
                child: FormBuilder(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // * Challenge title
                      const FormInputField(
                          title: "Title",
                          isRequired: true,
                          formBuilderName: "title"),
                      // * Challenge description
                      const FormTextArea(
                          title: "Description",
                          isRequired: true,
                          formBuilderName: "description",
                          maxLines: 7),
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
                              style: GoogleFonts.almarai(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "event",
                            child: Text(
                              "Event",
                              style: GoogleFonts.almarai(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      // * Challenge location
                      const FormInputField(
                          title: "Location",
                          isRequired: true,
                          formBuilderName: "location"),
                      // * Challenge country
                      const FormInputField(
                          title: "Country",
                          isRequired: true,
                          formBuilderName: "country"),
                      // * Challenge start date & time
                      const Wrap(
                        spacing: 50,
                        children: [
                          FormDateTimePicker(
                              title: "Start Date",
                              isRequired: true,
                              formBuilderName: "startDate",
                              iconURL: "assets/icons/calendar.svg",
                              inputType: InputType.date),
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
                      const FormInputField(
                          title: "Maximum Participants",
                          isRequired: true,
                          formBuilderName: "maximumParticipants"),
                      //  * Challenge difficulty
                      FormDropDown(
                          title: "Difficulty",
                          isRequired: true,
                          formBuilderName: "difficulty",
                          items: [
                            DropdownMenuItem(
                              value: "low",
                              child: Text(
                                "Low",
                                style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "medium",
                              child: Text(
                                "Medium",
                                style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "high",
                              child: Text(
                                "High",
                                style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                            ),
                          ]),
                      //  * Challenge / Event Category
                      FormDropDown(
                        title: "Category",
                        isRequired: true,
                        formBuilderName: "category",
                        items: _categories
                            .map(
                              (category) => DropdownMenuItem(
                                value: category.id,
                                child: Text(
                                  category.name,
                                  style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      // * Image
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Pick an Image",
                                  style: GoogleFonts.almarai(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: GoogleFonts.almarai(
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
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
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
                                  "Upload a cover photo",
                                  style: GoogleFonts.almarai(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "JPG, PNG, SVG",
                                  style: GoogleFonts.almarai(
                                    fontSize: 14,
                                    color: Colors.black
                                        .withOpacity(0.6000000238418579),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
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
                                  onPressed: () {},
                                  child: Text(
                                    "Choose file",
                                    style: GoogleFonts.almarai(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
