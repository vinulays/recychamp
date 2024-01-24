import 'package:flutter/material.dart';
import 'package:recychamp/screens/Home/home.dart';
// import 'package:recychamp/screens/Welcome/welcome.dart';

void main() {
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          splashColor: Colors.transparent),
      // * Welcome screen (if not logged in)
      home: const Home(),
    );
  }
}
