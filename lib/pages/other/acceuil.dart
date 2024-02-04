import 'package:earn_for_all/models/USER.dart';
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

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  String? getUserEmail() {
    var _Auth = FirebaseAuth.instance;

    // Obtenir l'objet User avec un null check
    User user = _Auth.currentUser!;
    // Retourner l'email de l'utilisateur
    return user.email.toString();
  }

  USER utilisateurCourant = USER();

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String result = DateFormat('MMM d, yyyy').format(today);
    var size = MediaQuery.of(context).size;

    return FutureBuilder<USER>(
      future: Fonctions.recupererUtilisateurParEmail(Fonctions.getUserEmail()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          utilisateurCourant = snapshot.data!;
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
                                    "Solde total\n" +
                                        (utilisateurCourant.soldeBchain! +
                                                utilisateurCourant.soldeHiving!)
                                            .toString() +
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
                                    "parrainages\n" +
                                        (utilisateurCourant.nb_parrainage ?? 0)
                                            .toString() +
                                        ' XAF',
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
                                  (utilisateurCourant.soldeBchain!).toString() +
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
                                  "BlockChain",
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
                                  (utilisateurCourant.soldeHiving!).toString() +
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
                                  "Pre-Hiving",
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
                                itemCount: 1,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TransactionCard(
                          type: "Retrait",
                          date: result,
                          size: size,
                          price: "150 XAF"),
                      TransactionCard(
                          type: "Investi",
                          date: result,
                          size: size,
                          price: "150 XAF"),
                      TransactionCard(
                          type: "Retrait",
                          date: result,
                          size: size,
                          price: "150 XAF"),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
        } else if (snapshot.hasError) {
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
  String type = 'Envoie';
  String date = '';
  String price = '';
  var size;
  TransactionCard(
      {super.key,
      required this.type,
      required this.date,
      required this.size,
      required this.price});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                        child: widget.type.contains('Investi')
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
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: widget.type.contains('Investi')
                                    ? green
                                    : Colors.red),
                          )
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
    );
  }
}
