import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:recychamp/screens/Home/home.dart';
import 'package:recychamp/screens/Login/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

    String email = "", password = "", name = "";
    TextEditingController namecontroller = new TextEditingController();
    TextEditingController passwordcontroller = new TextEditingController();
    TextEditingController mailcontroller = new TextEditingController();


    final _formkey =GlobalKey<FormState>();

    registration() async {

      if (password != null && namecontroller.text != "" && mailcontroller.text != ""){
        try{
          UserCredential userCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registeed Successfully", style: TextStyle(fontSize: 20.0),)));
          Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password'){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orangeAccent, content: Text("Password provided is too weak", style: TextStyle(fontSize: 18.0),)));

          }else if(e.code == "email-already-in-use"){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orangeAccent, content: Text("Account already exists", style: TextStyle(fontSize: 18.0),
            )));
          }
        }
      }
    }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/image.jpg",fit: BoxFit.cover,
                  )),
                  SizedBox(
                    height: 30.0,
                    ),
            
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    padding: 
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              decoration: BoxDecoration(
                color: Color(0xFFedf0f8),
                borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please Enter Name';

                    }
                    return null;
                    },
                    controller: namecontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name",
                      hintStyle: TextStyle(color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      ),
                      ),
                      SizedBox(height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical:2.0, horizontal:30.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value){
                              if (value == null || value.isEmpty){
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
                        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal:30.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(validator: (value) {
                            if (value == null || value.isEmpty){
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
             obscureText: true,  ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email=mailcontroller.text;
                            name= namecontroller.text;
                            password=passwordcontroller.text;
                          });
                        }
                        registration();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFF273671),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            "Sign Up",
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
              height: 40.0,
            ),
            Text(
              "or LogIn with",
              style: TextStyle(
                  color: Color(0xFF273671),
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/google.png",
                  height: 45,
                  width: 45,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 30.0,
                ),
                Image.asset(
                  "images/apple1.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                        color: Color(0xFF8c8e98),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500)),
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
                        color: Color(0xFF273671),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}