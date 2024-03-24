import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recychamp/screens/Home/home.dart';
import 'package:recychamp/screens/Login/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recychamp/utils/signup_utils.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = "", password = "", confirmPassword = "", name = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();

  Uint8List? _image;
  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (passwordcontroller.text.isNotEmpty &&
        namecontroller.text.isNotEmpty &&
        mailcontroller.text.isNotEmpty &&
        confirmPasswordcontroller.text.isNotEmpty) {
      if (passwordcontroller.text == confirmPasswordcontroller.text) {
        password = passwordcontroller.text;
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({'role': 'parent'});

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          )));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Password provided is too weak",
                  style: TextStyle(fontSize: 18.0),
                )));
          } else if (e.code == "email-already-in-use") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Account already exists",
                  style: TextStyle(fontSize: 18.0),
                )));
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Password does not match",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      }
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // imageProfile(),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account.",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Create an account to",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("save the world!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              Stack(children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://www.pngitem.com/pimgs/m/22-223968_default-profile-picture-circle-hd-png-download.png")),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo),
                  ),
                  bottom: -10,
                  left: 80,
                ),
              ]),
              SizedBox(
                height: 20.0,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFedf0f8),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                          controller: namecontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(
                                  color: Color(0xFFb2b7bf), fontSize: 18.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFedf0f8),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            }
                            return null;
                          },
                          controller: mailcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Color(0xFFb2b7bf), fontSize: 18.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFedf0f8),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Color(0xFFb2b7bf), fontSize: 18.0)),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFedf0f8),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Confirm Password';
                            }
                            return null;
                          },
                          controller: confirmPasswordcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                  color: Color(0xFFb2b7bf), fontSize: 18.0)),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = mailcontroller.text;
                              name = namecontroller.text;
                              password = passwordcontroller.text;
                            });
                          }
                          registration();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                                color: Color(0x9B037532),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500),
                            ))),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(
                          color: Color.fromARGB(219, 0, 0, 0),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Or continue with",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/google.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
