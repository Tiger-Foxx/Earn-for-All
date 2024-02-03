import 'package:earn_for_all/pages/other/Investissement.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Intermediate extends StatefulWidget {
  const Intermediate({Key? key}) : super(key: key);

  @override
  State<Intermediate> createState() => _IntermediateState();
}

class _IntermediateState extends State<Intermediate> {
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
                  'INVESTISSEMENT',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins',
                    color: mainFontColor,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 200,
                  // color: Colors.green,
                  padding: EdgeInsets.only(left: 50, right: 50),

                  child: Lottie.asset('assets/lotties/invest.json'),
                ),
                SizedBox(height: 11),
                Text(
                  "Vous voulez investir sur la plateforme, pour cela remplissez le montant ,puis effectuez le depot Orange OU MTN sur une des adresses de la Plateforme\nToutes les adresses sont disponibles dans la section INFOS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "En cas de soucis, contactez le service client",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: mainFontColor,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => InvestPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainFontColor,
                elevation: 0,
                shadowColor: Colors.transparent,
                fixedSize: Size(342, 54),
              ),
              child: Text(
                'Continuer',
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
