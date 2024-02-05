import 'package:earn_for_all/pages/admin/home_page_admin.dart';
import 'package:earn_for_all/pages/other/Investissement.dart';
import 'package:earn_for_all/pages/other/Splash_screen.dart';
import 'package:earn_for_all/pages/other/succes/SuccesScreen.dart';
import 'package:earn_for_all/pages/other/succes/SuccesScreen_generale.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:earn_for_all/utils/fontions.dart';
import 'package:flutter/material.dart';

class FormulaireDistrib extends StatefulWidget {
  GlobalKey<FormState> cleGlobale;

  FormulaireDistrib({required this.cleGlobale});

  @override
  State<FormulaireDistrib> createState() => _FormulaireDistribState();
}

class _FormulaireDistribState extends State<FormulaireDistrib> {
  String _choix = "Trading";
  double _nombre = 0.0;
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
                child: DropdownButtonFormField(
                  value: _choix,
                  onChanged: (String? choix) {
                    setState(() {
                      _choix = choix!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: "Trading",
                      child: Text("Trading"),
                    ),
                    DropdownMenuItem(
                      value: "Halving",
                      child: Text("Pre-Halving"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  onChanged: (String? valeur) {
                    setState(() {
                      try {
                        _nombre = double.parse(valeur!);
                      } catch (e) {
                        _nombre = 0.0;
                      }
                    });
                  },
                  validator: (String? valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return "Ce champ est obligatoire";
                    }
                    if (_nombre < 0 || _nombre > 500) {
                      return "La valeur doit être comprise entre 0 et 500";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Pourcentage %',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA8A8A8),
                    ),
                    prefixIcon: Icon(Icons.card_giftcard),
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
                    if (widget.cleGlobale.currentState!.validate()) {
                      Fonctions.distribuer(_nombre, _choix);
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (BuildContext context) {
                            return const Splash_screen(); // votre page de chargement
                          });
                      await Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop(); // fermer la feuille
                      });
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Splash_screen.isAdmin
                                  ? HomePageAdmin()
                                  : HomePage()));
                    }
                  },
                  child: Text("Valider"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifierValidite() {
    _valide = _choix != null && _nombre > 15000 && _nombre < 500000;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _verifierValidite();
  }
}
