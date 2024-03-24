import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/screens/Login/login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            Text(
              "Settings",
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            SizedBox(height: 20.0),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout, color: Colors.red),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));

                // Handle logout action
              },
            ),
            ListTile(
              title: Text('Delete Account'),
              leading: Icon(Icons.delete, color: Colors.black),
              onTap: () async {
                // Perform delete account action
                try {
                  await FirebaseAuth.instance.currentUser!.delete();
                  // Navigate to login screen after account deletion
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()));
                } catch (e) {
                  print("Error deleting account: $e");
                  // Handle error
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
