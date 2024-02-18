import 'package:earn_for_all/models/transactions.dart';
import 'package:earn_for_all/pages/admin/acceuil_admin.dart';
import 'package:earn_for_all/pages/admin/home_page_admin.dart';
import 'package:earn_for_all/pages/other/Investissement.dart';
import 'package:earn_for_all/pages/other/Splash_screen.dart';
import 'package:earn_for_all/pages/other/acceuil.dart';
import 'package:earn_for_all/pages/other/succes/SuccesScreen.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:earn_for_all/services/messaging/firebase_api.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/utils/fontions.dart';
import 'package:flutter/material.dart';

class FormulaireRetrait extends StatefulWidget {
  GlobalKey<FormState> cleGlobale;

  FormulaireRetrait({required this.cleGlobale});

  @override
  State<FormulaireRetrait> createState() => _FormulaireRetraitState();
}

class _FormulaireRetraitState extends State<FormulaireRetrait> {
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
                      _transaction.reseau = _choix;
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
                    if (_choix == "Trading") {
                      if ((((Splash_screen.isAdmin
                                      ? DailyPageAdmin
                                          .UtilisateurCourantGeneral.soldeBchain
                                      : DailyPage.UtilisateurCourantGeneral
                                          .soldeBchain) ??
                                  0.0) *
                              100 /
                              100) <
                          _nombre + 0.0) {
                        return "plus que votre budget";
                      }
                    }
                    if (_choix == "Halving") {
                      if ((((Splash_screen.isAdmin
                                      ? DailyPageAdmin
                                          .UtilisateurCourantGeneral.soldeHiving
                                      : DailyPage.UtilisateurCourantGeneral
                                          .soldeHiving) ??
                                  0.0) *
                              100 /
                              100) <
                          (_nombre + 0.0)) {
                        return "plus que votre budget";
                      }
                    }
                    if (_nombre < 2500) {
                      return "minimum 2500 XAF ";
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
              SizedBox(
                width: 300,
                child: Text(
                  "Vous recevrez : " +
                      ((_transaction.montant ?? 0.0) * 98 / 100)
                          .truncate()
                          .toString() +
                      " XAF",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: mainFontColor),
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
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
                    hintText: 'Numero receveur OM|MOMO',
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
                      _transaction.reseau = _choix;
                      _transaction.date = DateTime.now();
                      _transaction.type = "retrait";
                      _transaction.utilisateur = Fonctions.getUserEmail();
                      await Fonctions.ajoutertransaction(_transaction);
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (BuildContext context) {
                            firebaseApi().sendRetraitNotif();
                            return const SuccesScreenRetrait(); // votre page de chargement
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
    _valide = _choix != null && _nombre > 3500 && _nombre < 500000;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _verifierValidite();
  }
}
