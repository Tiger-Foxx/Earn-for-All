import 'package:earn_for_all/models/transactions.dart';
import 'package:earn_for_all/pages/other/Investissement.dart';
import 'package:earn_for_all/pages/other/succes/SuccesScreen.dart';
import 'package:earn_for_all/utils/fontions.dart';
import 'package:flutter/material.dart';

class Formulaire extends StatefulWidget {
  GlobalKey<FormState> cleGlobale;

  Formulaire({required this.cleGlobale});

  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  String _choix = "Trading";
  int _nombre = 0;
  int _numero = 0;
  bool _valide = false;
  transaction _transaction = transaction();
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
                      _transaction.reseau = choix;
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
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  onChanged: (String? valeur) {
                    setState(() {
                      try {
                        _nombre = int.parse(valeur!);
                        _transaction.montant = _nombre + 0.0;
                      } catch (e) {
                        _nombre = 0;
                      }
                    });
                  },
                  validator: (String? valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return "Ce champ est obligatoire";
                    }
                    if (_nombre < 15000 || _nombre > 500000) {
                      return "La valeur doit être comprise entre 15 000 et 500 000";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Montant XAF',
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  onChanged: (String? valeur) {
                    setState(() {
                      try {
                        _numero = int.parse(valeur!);
                        _transaction.numero_OM_MOMO = _numero.toString();
                      } catch (e) {
                        _numero = 0;
                      }
                    });
                  },
                  validator: (String? valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return "Ce champ est obligatoire";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Numero Compte OM/MOMO',
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (String? valeur) {
                    setState(() {
                      _transaction.nom_OM_MOMO = valeur;
                    });
                  },
                  validator: (String? valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return "Ce champ est obligatoire";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Nom Compte OM|MOMO',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA8A8A8),
                    ),
                    prefixIcon: Icon(Icons.person),
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
                      _transaction.date = DateTime.now();
                      _transaction.type = "depot";
                      _transaction.utilisateur = Fonctions.getUserEmail();
                      await Fonctions.ajoutertransaction(_transaction);
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (BuildContext context) {
                            return const SuccesScreenRetrait(); // votre page de chargement
                          });
                      await Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(context).pop(); // fermer la feuille
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvestPage(
                                    is_valid: true,
                                  )));
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
