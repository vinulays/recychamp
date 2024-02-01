import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recychamp/firebase_options.dart';
import 'package:recychamp/models/chip_label_color.dart';
import 'package:recychamp/screens/Home/home.dart';
// import 'package:recychamp/screens/Welcome/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RecyChamp',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF75A488)),
          useMaterial3: true,
          splashColor: Colors.transparent,
          chipTheme: const ChipThemeData(
              labelStyle: TextStyle(color: ChipLabelColor()))),
      // * Welcome screen (if not logged in)
      home: const Home(),
    );
  }
}
