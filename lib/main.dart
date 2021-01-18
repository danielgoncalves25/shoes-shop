import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_app/screens/Cart.dart';

import './services/services.dart';
import './screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'Sneakers-App',
      options: const FirebaseOptions(
          appId: '$fireBaseAppId',
          apiKey: '$fireBaseKey',
          messagingSenderId: 'my_messagingSenderId',
          projectId: 'sneaker-app-dd2ba'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authentication>(
          create: (_) =>
              Authentication(FirebaseAuth.instance, FirebaseFirestore.instance),
        ),
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),
        Provider<Home>(
          create: (_) => Home(),
        ),
        StreamProvider(
            create: (context) => context.read<Authentication>().authState),
        StreamProvider(
            create: (context) => context.read<Authentication>().userData),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.blueAccent,
          fontFamily: 'Oswald',
          textTheme: TextTheme(
            headline1: GoogleFonts.oswald(
              fontSize: 32,
            ),
            headline6: GoogleFonts.oswald(
              fontSize: 14,
            ),
          ),
        ),
        home: AuthenicationWrapper(),
        routes: {
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/cart': (context) => Cart()
        },
      ),
    );
  }
}

class AuthenicationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return firebaseUser != null ? TabScreen() : Login();
  }
}
