import 'package:earn_for_all/pages/other/Splash_screen.dart';
import 'package:earn_for_all/pages/authentication/login.dart';
import 'package:earn_for_all/pages/authentication/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash_screen(),
    );
  }
}
