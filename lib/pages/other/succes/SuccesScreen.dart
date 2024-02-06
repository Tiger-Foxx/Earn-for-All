import 'package:earn_for_all/pages/other/Investissement.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:earn_for_all/pages/authentication/login.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccesScreenRetrait extends StatefulWidget {
  static const routeName = 'splash';
  const SuccesScreenRetrait({super.key});

  @override
  State<SuccesScreenRetrait> createState() => _SuccesScreenRetraitState();
}

class _SuccesScreenRetraitState extends State<SuccesScreenRetrait> {
  @override
  void initState() {
    super.initState();
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
              Lottie.asset('assets/lotties/ok_green.json'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Validation réussie\n\nEn attente de votre dépot... ",
                  textAlign: TextAlign.center,
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
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => (InvestPage()),
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
