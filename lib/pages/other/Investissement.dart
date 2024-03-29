import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/utils/fontions.dart';
import 'package:earn_for_all/widgets/copiable_text.dart';
import 'package:earn_for_all/widgets/formulaire_invest.dart';
import 'package:flutter/material.dart';
import 'package:earn_for_all/utils/infos.dart';

class InvestPage extends StatefulWidget {
  bool? is_valid = false;
  InvestPage({super.key, this.is_valid});

  @override
  State<InvestPage> createState() => _InvestPageState();
}

class _InvestPageState extends State<InvestPage> {
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
                        widget.is_valid!
                            ? "Choisissez le reseau ou faire le depot\nLes numeros et adresses sont aussi desponibles dans la section INFO"
                            : "Entrez le montant que vous voulez investir,et choisissez Trading ou Pre-Halving, vous pouvez aussi payer en USDT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: mainFontColor),
                      ),
                    ),
                  ],
                ),
                !widget.is_valid!
                    ? FormulaireInvest(cleGlobale: _formKey)
                    : Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Fonctions.sendTel(informations.OM);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 199, 83, 6),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  fixedSize: Size(342, 64),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ORANGE MONEY",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFF4F4F4),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Image.asset("assets/images/OM.png"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CopyableTextButton(informations.OM),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Fonctions.sendTel(informations.MOMO);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 227, 182, 1),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  fixedSize: Size(342, 64),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "MTN MOMO",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFF4F4F4),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Image.asset("assets/images/MOMO.png"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CopyableTextButton(informations.MOMO),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ADDRESSE BEP 20 POUR LE DEPOT EN USDT",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: mainFontColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CopyableTextButton(informations.BEP20),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
