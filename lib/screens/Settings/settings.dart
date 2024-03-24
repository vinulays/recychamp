import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recychamp/screens/Login/login.dart';

class SettingsPage extends StatelessWidget {
  // ignore: use_super_parameters
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 0, 0, 0)),
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
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 20.0),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout, color: Color.fromARGB(255, 244, 54, 54)),
              onTap: () {

                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()));

              },
            ),
            ListTile(
              title: const Text('Delete Account'),
              leading: const Icon(Icons.delete, color: Color.fromARGB(255, 0, 0, 0)),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.currentUser!.delete();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Login()));
                } catch (e) {
                  // ignore: avoid_print
                  print("Error deleting account: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
