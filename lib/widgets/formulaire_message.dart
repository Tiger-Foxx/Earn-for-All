import 'package:earn_for_all/pages/other/Investissement.dart';
import 'package:earn_for_all/pages/other/succes/SuccesScreen.dart';
import 'package:earn_for_all/pages/other/succes/SuccesScreen_generale.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:flutter/material.dart';

class FormulaireMessage extends StatefulWidget {
  var cleGlobale;

  FormulaireMessage({required this.cleGlobale});

  @override
  State<FormulaireMessage> createState() => _FormulaireMessageState();
}

class _FormulaireMessageState extends State<FormulaireMessage> {
  String _message = '';
  bool _valide = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: widget.cleGlobale,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  maxLength: 130,
                  maxLines: null,
                  onChanged: (String? message) {
                    _message = message ?? "";
                  },
                  decoration: InputDecoration(
                    hintText: 'Votre message',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA8A8A8),
                    ),
                    prefixIcon: Icon(Icons.message),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 17, vertical: 22),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD0D0D0))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD0D0D0))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD0D0D0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (true) {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (BuildContext context) {
                            return const SuccesScreenGenerale(); // votre page de chargement
                          });
                      await Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(context).pop(); // fermer la feuille
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                  child: Text("Envoyer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifierValidite() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _verifierValidite();
  }
}
