// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:recychamp/firebase_options.dart';
import 'package:recychamp/models/chip_label_color.dart';
import 'package:recychamp/repositories/article_repository.dart';
import 'package:recychamp/repositories/badge_repository.dart';
import 'package:recychamp/repositories/cart_repository.dart';
import 'package:recychamp/repositories/challenge_repository.dart';
import 'package:recychamp/repositories/posts%20repository/post_repo.dart';
import 'package:recychamp/repositories/shop_repository.dart';
import 'package:recychamp/screens/Cart/bloc/cart_bloc.dart';
import 'package:recychamp/screens/ChallengeDetails/bloc/challenge_details_bloc.dart';
import 'package:recychamp/screens/ChallengeSubmissionView/bloc/submission_view_bloc.dart';
import 'package:recychamp/screens/Challenges/bloc/challenges_bloc.dart';
import 'package:recychamp/screens/Community/bloc/comments/bloc/comment_bloc.dart';
import 'package:recychamp/screens/Community/bloc/posts_bloc.dart';
import 'package:recychamp/screens/Dashboard/bloc/badge_bloc.dart';
import 'package:recychamp/screens/EducationalResources/bloc/article_details_bloc.dart';
// import 'package:recychamp/screens/Home/home.dart';
import 'package:recychamp/screens/Shop/bloc/shop_bloc.dart';
import 'package:recychamp/services/article_service.dart';
import 'package:recychamp/services/badge_service.dart';
import 'package:recychamp/services/cart_service.dart';
import 'package:recychamp/services/challenge_service.dart';
import 'package:recychamp/services/post_service.dart';
import 'package:recychamp/screens/Welcome/welcome.dart';
import 'package:recychamp/services/shop_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey =
      "pk_test_51OxXnMEf9JrvdLmiMP1HV9Wk3X4jFaYGSOn4rcUOiC30djKuRtOBpBg8wUc6vGWcuWyZXF3jYTCsufusIyeC9L8S00iMlssUpm";

  await dotenv.load(fileName: ".env");

  // * Manually sign in to implement challenge submission (roles: admin, organizer, parent)
  // * remove this when implementing authentication
  // signInManually();

  // logout();
  // Future<void> signInManually() async {
//   try {
//     // * admin = ubetatta@gmail.com
//     // * organizer = vinula@gmail.com
//     // * parent = parent@gmail.com
//     String email = 'ubetatta@gmail.com';
//     String password = '12345678';
// Future<void> signInManually() async {
//   try {
//     // * admin = ubetatta@gmail.com
//     // * organizer = vinula@gmail.com
//     // * parent = parent@gmail.com
//     String email = 'parent@gmail.com';
//     String password = '12345678';

//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     // Access the signed-in user
//     User user = userCredential.user!;

//     // Print user information
//     debugPrint('User signed in: ${user.uid}');
//   } catch (e) {
//     // Handle sign-in errors
//     throw Exception("Sign in error: $e");
//   }
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Login()
//     );
//   }
// }
  runApp(const MyApp());
}

Future<void> logout() async {
  FirebaseAuth.instance.signOut();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // * Add bloc providers for each states
    return MultiBlocProvider(
      providers: [
        // * challenge details state provider
        BlocProvider<ChallengeDetailsBloc>(
          create: (context) => ChallengeDetailsBloc(
            repository: ChallengeRepository(
              challengeService: ChallengeService(
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance),
            ),
          ),
        ),
        // * challenges state provider
        BlocProvider<ChallengesBloc>(
          create: (context) => ChallengesBloc(
            repository: ChallengeRepository(
              challengeService:
                  // * adding current firebase instance to the challenge service
                  ChallengeService(
                      firestore: FirebaseFirestore.instance,
                      storage: FirebaseStorage.instance),
            ),
          )..add(
              FetchChallengesEvent(),
            ),
        ),
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(
            repository: PostRepository(
              postService:
                  // * adding current firebase instance to the challenge service
                  PostService(
                      firestore: FirebaseFirestore.instance,
                      storage: FirebaseStorage.instance,
                      auth: FirebaseAuth.instance),
              // storage: FirebaseStorage.instance,
              // auth: FirebaseAuth.instance),
            ),
          ),
        ),
        BlocProvider<CommentBloc>(
          create: (context) => CommentBloc(
            postRepository: PostRepository(
              postService:
                  // * adding current firebase instance to the challenge service
                  PostService(
                      firestore: FirebaseFirestore.instance,
                      storage: FirebaseStorage.instance,
                      auth: FirebaseAuth.instance),
              // storage: FirebaseStorage.instance,
              // auth: FirebaseAuth.instance),
            ),
          ),
        ),
        BlocProvider<ArticleDetailsBloc>(
          create: (context) => ArticleDetailsBloc(
            repository: ArticleRepo(
              articleServise: ArticleService(
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage
                      .instance // Replace YourRepo with your actual repository
                  ),
            ),
          )..add(FetchArticleEvent()),
        ),
        // * submittion state provider
        BlocProvider<SubmissionViewBloc>(
          create: (context) => SubmissionViewBloc(
            repository: ChallengeRepository(
              challengeService:
                  // * adding current firebase instance to the challenge service
                  ChallengeService(
                      firestore: FirebaseFirestore.instance,
                      storage: FirebaseStorage.instance),
            ),
          ),
        ),
        // * badge state provider
        BlocProvider<BadgeBloc>(
          create: (context) => BadgeBloc(
            badgeRepository: BadgeRepository(
              badgeService: BadgeService(
                firestore: FirebaseFirestore.instance,
              ),
            ),
          )..add(SetBadgeEvent()),
        ),
        BlocProvider<ShopBloc>(
          create: (context) => ShopBloc(
            repository: ShopRepository(
              shopService: ShopService(
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance),
            ),
          )..add(FetchShopEvent()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(
            cartRepository: CartRepository(
              cartService: CartService(),
            ),
          ),
        ),
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
        // home: const Home(),
        home: Welcome(),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//  final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// title: Text(widget.title),
//       ),
//       body: Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//   );
//   }



