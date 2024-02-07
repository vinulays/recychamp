import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recychamp/firebase_options.dart';
import 'package:recychamp/models/chip_label_color.dart';
import 'package:recychamp/repositories/challenge_repository.dart';
import 'package:recychamp/screens/ChallengeDetails/bloc/challenge_details_bloc.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/Home/home.dart';
import 'package:recychamp/services/challenge_service.dart';
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
    // * Add bloc providers for each states
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChallengeDetailsBloc>(
            create: (context) => ChallengeDetailsBloc()),
        BlocProvider<ChallengesBloc>(
          create: (context) => ChallengesBloc(
            repository: ChallengeRepository(
              challengeService:
                  ChallengeService(firestore: FirebaseFirestore.instance),
            ),
          )..add(
              FetchChallengesEvent(),
            ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RecyChamp',
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF75A488)),
            useMaterial3: true,
            splashColor: Colors.transparent,
            chipTheme: const ChipThemeData(
                labelStyle: TextStyle(color: ChipLabelColor()))),
        // * Welcome screen (if not logged in)
        home: const Home(),
      ),
    );
  }
}
