import 'dart:async';

import 'package:firebase_api/helpers/keystore_helper.dart';
import 'package:firebase_api/helpers/preference_helper.dart';
import 'package:firebase_api/screens/login_screen.dart';
import 'package:firebase_api/screens/photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _email = readDataFromLocal('usermail');
  String _pwd = readDataFromLocal('pwd');

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
          child: LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
