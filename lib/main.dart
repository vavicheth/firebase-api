import 'package:firebase_api/screens/news_screen.dart';
import 'package:firebase_api/screens/photos_screen.dart';
import 'package:firebase_api/screens/register_screen.dart';
import 'package:firebase_api/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
