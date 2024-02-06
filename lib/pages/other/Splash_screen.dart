import 'package:earn_for_all/pages/admin/home_page_admin.dart';
import 'package:earn_for_all/pages/authentication/login.dart';
import 'package:earn_for_all/pages/intro/onboarding_screen.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/utils/fontions.dart';
import 'package:earn_for_all/utils/infos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash_screen extends StatefulWidget {
  static const routeName = 'splash';
  static bool isAdmin = false;
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, _createRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primary,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              Lottie.asset('assets/lotties/charge (2).json'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Chargement... ",
                  style: TextStyle(color: mainFontColor, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      if (Fonctions.getUserEmail() == informations.email) {
        Splash_screen.isAdmin = true;
      }
    } catch (e) {}
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        if (_auth.currentUser != null) {
          if (Fonctions.getUserEmail() == informations.email) {
            Splash_screen.isAdmin = true;
          } else {
            Splash_screen.isAdmin = false;
          }
        }
        if (Splash_screen.isAdmin) {
          return (_auth.currentUser == null
              ? OnboardingScreen()
              : HomePageAdmin());
        } else {
          return (_auth.currentUser == null ? OnboardingScreen() : HomePage());
        }
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
