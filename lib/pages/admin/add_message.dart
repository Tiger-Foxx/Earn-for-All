import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/widgets/copiable_text.dart';
import 'package:earn_for_all/widgets/formulaire_distrib.dart';
import 'package:earn_for_all/widgets/formulaire_invest.dart';
import 'package:earn_for_all/widgets/formulaire_message.dart';
import 'package:flutter/material.dart';

class AddMessage extends StatefulWidget {
  bool? is_valid = false;
  AddMessage({super.key, this.is_valid});

  @override
  State<AddMessage> createState() => _AddMessageState();
}

class _AddMessageState extends State<AddMessage> {
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
                        "Saisissez le message que vous voulez envoyer aux utilisateurs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: mainFontColor),
                      ),
                    ),
                  ],
                ),
                FormulaireMessage(cleGlobale: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
