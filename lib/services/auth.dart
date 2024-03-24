import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:recychamp/screens/Home/home.dart';
import 'package:recychamp/resources/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;

    Map<String, dynamic> userInfoMap = {
      "email": userDetails!.email,
      "name": userDetails.displayName,
      "imgUrl": userDetails.photoURL,
      "id": userDetails.uid
    };
    await DatabaseMethods()
        .addUser(userDetails.uid, userInfoMap)
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
    }
  signInWithFacebook(BuildContext context) async{
  try{
    final LoginResult result = await FacebookAuth.instance.login();
          if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
 final User? user = userCredential.user;

        if (user != null) {
          Map<String, dynamic> userInfoMap = {
            "email": user.email,
            "name": user.displayName,
            "imgUrl": user.photoURL,
            "id": user.uid
          };
                await DatabaseMethods().addUser(user.uid, userInfoMap);
                Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      } else {
                // ignore: avoid_print
                print("Facebook sign-in failed or canceled");
}
    } catch (e) {
      // ignore: avoid_print
      print("Error signing in with Facebook: $e");
    }
  }

}

