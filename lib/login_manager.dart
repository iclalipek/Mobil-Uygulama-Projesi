import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/home.dart';
import 'package:mobile_project/screens/login.dart';

class LoginManager extends StatefulWidget {
  const LoginManager({super.key});

  @override
  State<LoginManager> createState() => _LoginManagerState();
}

class _LoginManagerState extends State<LoginManager> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const LoginScreen();
          }
        });
  }
}
