import 'package:flutter/material.dart';
import 'ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainMenu(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
      );
    }
  }
}