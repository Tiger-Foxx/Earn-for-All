import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/widgets/copiable_text.dart';
import 'package:earn_for_all/widgets/formulaire_distrib.dart';
import 'package:earn_for_all/widgets/formulaire_invest.dart';
import 'package:flutter/material.dart';

class Distribuer extends StatefulWidget {
  bool? is_valid = false;
  Distribuer({super.key, this.is_valid});

  @override
  State<Distribuer> createState() => _DistribuerState();
}

class _DistribuerState extends State<Distribuer> {
  void distribuer() {}
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.is_valid == null) {
      widget.is_valid = false;
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 45,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset(
                        "assets/images/logoEFA (1).jpg",
                        height: 100,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        "Entrez le pourcentage a distribuer aux investisseurs,et choisissez Hiving ou BlockChain",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: mainFontColor),
                      ),
                    ),
                  ],
                ),
                FormulaireDistrib(cleGlobale: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
