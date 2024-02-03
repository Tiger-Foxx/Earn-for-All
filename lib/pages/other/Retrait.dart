import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/widgets/copiable_text.dart';
import 'package:earn_for_all/widgets/formulaire_invest.dart';
import 'package:earn_for_all/widgets/formulaire_retrait.dart';
import 'package:flutter/material.dart';

class RetraitPage extends StatefulWidget {
  bool? is_valid = false;
  RetraitPage({super.key, this.is_valid});

  @override
  State<RetraitPage> createState() => _RetraitPageState();
}

class _RetraitPageState extends State<RetraitPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                        "Entrez le montant que vous voulez Retirer ,et choisissez Hiving ou BlockChain",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: mainFontColor),
                      ),
                    ),
                  ],
                ),
                FormulaireRetrait(cleGlobale: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
