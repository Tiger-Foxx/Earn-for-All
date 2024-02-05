import 'package:earn_for_all/models/USER.dart';
import 'package:earn_for_all/models/transactions.dart';
import 'package:earn_for_all/pages/authentication/login.dart';
import 'package:earn_for_all/pages/other/Splash_screen.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:earn_for_all/services/Authentification.dart';
import 'package:earn_for_all/utils/fontions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:intl/intl.dart';
import "dart:math";

import 'package:lottie/lottie.dart';

class DailyPageAdmin extends StatefulWidget {
  const DailyPageAdmin({super.key});
  static USER UtilisateurCourantGeneral = USER();
  @override
  State<DailyPageAdmin> createState() => _DailyPageAdminState();
}

class _DailyPageAdminState extends State<DailyPageAdmin> {
  String? getUserEmail() {
    var _Auth = FirebaseAuth.instance;

    // Obtenir l'objet User avec un null check
    User user = _Auth.currentUser!;
    // Retourner l'email de l'utilisateur
    return user.email.toString();
  }

  USER utilisateurCourant = USER();
  List<double> budgetsHT = <double>[0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String result = DateFormat('MMM d, yyyy').format(today);
    var size = MediaQuery.of(context).size;

    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        Fonctions.recupererUtilisateurParEmail(Fonctions.getUserEmail()),
        Fonctions.recuperertransactionsParUtilisateur(Fonctions.getUserEmail()),
        Fonctions.calculerBudget(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          utilisateurCourant = snapshot.data![0] as USER;
          DailyPageAdmin.UtilisateurCourantGeneral = utilisateurCourant;
          List<transaction> transactions =
              snapshot.data![1] as List<transaction>;
          budgetsHT = snapshot.data![2] as List<double>;
          return SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 25, right: 20, left: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => HomePage.scaffoldKey.currentState
                                  ?.openDrawer(),
                              child: Icon(
                                Icons.menu,
                                size: 37,
                                color: mainFontColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    builder: (BuildContext context) {
                                      return const Splash_screen(); // votre page de chargement
                                    });
                                await Future.delayed(const Duration(seconds: 2),
                                    () {
                                  Navigator.of(context)
                                      .pop(); // fermer la feuille
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                                Authentification().signOut();
                              },
                              child: Icon(
                                Icons.logout,
                                size: 37,
                                color: mainFontColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/USER.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: (size.width - 40) * 0.6,
                              child: Column(
                                children: [
                                  Text(
                                    getUserEmail() ?? "",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: mainFontColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Total Invest Pre-Halving\n" +
                                        (budgetsHT[0]).truncate().toString() +
                                        ' XAF',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Total Invest-Trading\n" +
                                        (budgetsHT[1]).truncate().toString() +
                                        " XAF",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Utilisateurs : " +
                                        (budgetsHT[2]).truncate().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  (utilisateurCourant.soldeBchain!)
                                          .truncate()
                                          .toString() +
                                      " XAF",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: mainFontColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Trading",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                      color: black),
                                ),
                              ],
                            ),
                            Container(
                              width: 0.5,
                              height: 40,
                              color: black.withOpacity(0.3),
                            ),
                            Column(
                              children: [
                                Text(
                                  (utilisateurCourant.gainBchain! +
                                              utilisateurCourant.gainHiving!)
                                          .truncate()
                                          .toString() +
                                      " XAF",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: mainFontColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Gains",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                      color: black),
                                ),
                              ],
                            ),
                            Container(
                              width: 0.5,
                              height: 40,
                              color: black.withOpacity(0.3),
                            ),
                            Column(
                              children: [
                                Text(
                                  (utilisateurCourant.soldeHiving!)
                                          .truncate()
                                          .toString() +
                                      " XAF",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: mainFontColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Pre-Halving",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                      color: black),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Récents",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: mainFontColor,
                                  )),
                              IconBadge(
                                icon: Icon(Icons.payment),
                                itemCount: transactions.length,
                                badgeColor: Colors.red,
                                itemColor: mainFontColor,
                                hideZero: true,
                                top: -1,
                                onTap: () {
                                  print('test');
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      // Text("Overview",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 20,
                      //       color: mainFontColor,
                      //     )),
                      Text(result,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: mainFontColor,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                (transactions.length > 0)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 300,
                            child: ListView.builder(
                              itemCount: transactions
                                  .length, // le nombre d'éléments dans la liste transactions
                              itemBuilder: (context, index) {
                                // une fonction qui construit le widget à chaque position de la liste
                                // On récupère la transaction à la position index
                                transaction tx = transactions[index];
                                // On retourne un widget TransactionCard avec les données de la transaction
                                return TransactionCard(
                                  valid: tx.isValid,
                                  type: tx.type!,
                                  date: tx.date!.toString(),
                                  size: size,
                                  price: tx.montant!.truncate().toString(),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "Aucune transaction pour le moment",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: mainFontColor,
                              ),
                            ),
                          ),
                          Container(
                              child:
                                  Lottie.asset("assets/lotties/astronot.json")),
                        ],
                      ))
              ],
            ),
          ));
        } else if (snapshot.hasError) {
          print("Erreur :" + snapshot.error.toString());
          print("Stacktrace : ");
          print(snapshot.stackTrace!);
          return SafeArea(
            child: Center(
              child: Text("Une Erreur s'est produite"),
            ),
          );
        } else {
          return SafeArea(
            child: Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class TransactionCard extends StatefulWidget {
  String type = 'depot';
  String date = '';
  String price = '';
  bool? valid = true;
  var size;
  TransactionCard(
      {super.key,
      required this.type,
      required this.date,
      required this.size,
      required this.price,
      this.valid});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 100,
              margin: EdgeInsets.only(
                top: 20,
                left: 25,
                right: 25,
              ),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 20, left: 20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: arrowbgColor,
                        borderRadius: BorderRadius.circular(15),
                        // shape: BoxShape.circle
                      ),
                      child: Center(
                          child: widget.type.contains('depot')
                              ? Icon(Icons.arrow_upward_rounded)
                              : Icon(Icons.arrow_downward_rounded)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        width: (widget.size.width - 90) * 0.85,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.type,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.date,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: black.withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.price,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: widget.type.contains('depot')
                                      ? green
                                      : Colors.red),
                            ),
                            (!(widget.valid ?? true))
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.timelapse,
                                      color: Colors.red,
                                      size: 17,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 17,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
