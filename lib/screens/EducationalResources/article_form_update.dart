import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                  TextFormField(
                    controller: _articleTitleController,
                    decoration: InputDecoration(
                      labelText: 'Article Title',
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
                    height: 10,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      // Add any validation for description if needed
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _articleImageController,
                    decoration: InputDecoration(labelText: 'Article Image'),
                    validator: (value) {
                      // Add any validation for article image if needed
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _articleTypeController,
                    decoration: InputDecoration(labelText: 'Article Type'),
                    validator: (value) {
                      // Add any validation for article type if needed
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(labelText: 'Content'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter article content';
                      }
                      return null;
                    },
                    maxLines: null, // Allow multiple lines for content
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
    // Dispose controllers when the widget is disposed
    _articleTitleController.dispose();
    _descriptionController.dispose();
    _articleImageController.dispose();
    _articleTypeController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
