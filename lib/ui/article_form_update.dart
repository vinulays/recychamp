import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recychamp/models/article_model.dart';
import 'package:recychamp/screens/Calendar/constants.dart';
import 'package:recychamp/screens/EducationalResources/bloc/article_details_bloc.dart';

class UpdateArticleForm extends StatefulWidget {
  final Article article;

  UpdateArticleForm({required this.article});

  @override
  _UpdateArticleFormState createState() => _UpdateArticleFormState();
}

class _UpdateArticleFormState extends State<UpdateArticleForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _articleTitleController;
  late TextEditingController _descriptionController;
  late TextEditingController _articleImageController;
  late TextEditingController _articleTypeController;
  late TextEditingController _contentController;
  String? selectedType;
  @override
  void initState() {
    super.initState();
    _articleTitleController =
        TextEditingController(text: widget.article.articleTitle);
    _descriptionController =
        TextEditingController(text: widget.article.description);
    _articleImageController =
        TextEditingController(text: widget.article.articleImage);
    _articleTypeController =
        TextEditingController(text: widget.article.articleType);
    _contentController = TextEditingController(text: widget.article.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Article',
              style: kFontFamily(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    "Title",
                    style: kFontFamily(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  TextFormField(
                    controller: _articleTitleController,
                    decoration: InputDecoration(
                      hintText: "Enter new title...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF75A488),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: kFontFamily(fontSize: 14),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter article title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Description",
                    style: kFontFamily(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: "Enter new Description...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF75A488),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      // Add any validation for description if needed
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Article Image",
                    style: kFontFamily(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  TextFormField(
                    controller: _articleImageController,
                    decoration: InputDecoration(
                      hintText: "Get new Image...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF75A488),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Type",
                    style: kFontFamily(
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
                        _articleTypeController.text = selectedType!;
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
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Content",
                    style: kFontFamily(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      hintText: "Enter new Content...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF75A488),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter article content';
                      }
                      return null;
                    },
                    maxLines: 10,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, submit update
                          BlocProvider.of<ArticleDetailsBloc>(context).add(
                            UpdateArticleEvent({
                              'id': widget.article.id,
                              'articleTitle': _articleTitleController.text,
                              'description': _descriptionController.text,
                              'articleImage': _articleImageController.text,
                              'articleType': _articleTypeController.text,
                              'content': _contentController.text,
                            }),
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: kFontFamily(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    // dispose controllers after widget dispose
    _articleTitleController.dispose();
    _descriptionController.dispose();
    _articleImageController.dispose();
    _articleTypeController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
