import 'package:earn_for_all/pages/other/Retrait.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:earn_for_all/pages/other/transection_page.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntermediateRetrait extends StatefulWidget {
  const IntermediateRetrait({Key? key}) : super(key: key);

  @override
  State<IntermediateRetrait> createState() => _IntermediateRetraitState();
}

class _IntermediateRetraitState extends State<IntermediateRetrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  'RETRAIT D\'ARGENT',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins',
                    color: mainFontColor,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  height: 170,
                  // color: Colors.green,
                  padding: EdgeInsets.only(left: 50, right: 50),

                  child: Lottie.asset('assets/lotties/retrait.json'),
                ),
                SizedBox(height: 3),
                Text(
                  "Vous voulez retirer de l'argent de votre solde, pour celà remplissez le formulaire ,puis attendez que la plateforme vous fasse un dépot",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "\nEn cas de soucis, contactez le service client dans la section INFOS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: mainFontColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      //TODO PUIS IL FAUDRA METTEE J A 1 DAns le constructeur de la page transection

                      //####################

                      return RetraitPage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainFontColor,
                elevation: 0,
                shadowColor: Colors.transparent,
                fixedSize: Size(342, 54),
              ),
              child: Text(
                'Effectuer le retrait',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
