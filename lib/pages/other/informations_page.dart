import 'package:earn_for_all/utils/fontions.dart';
import 'package:earn_for_all/utils/infos.dart';
import 'package:earn_for_all/widgets/copiable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(CupertinoIcons.back,color: black,),
      //   actions: [Icon(CupertinoIcons.search,color: black,)],
      //   backgroundColor: primary,elevation: 0,),
      backgroundColor: primary,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: primary, boxShadow: [
              BoxShadow(
                  color: grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3)
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 25, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(CupertinoIcons.back),
                      Icon(CupertinoIcons.search)
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Informations Earn For ALL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tout sur nous",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),
          InfoWidget(
              ontap: () {
                Fonctions.sendEmail(
                    "Bonjour, je m'appelle : ", informations.email);
              },
              icone: Icon(Icons.message),
              titre: "Service client Email",
              size: size,
              text: "EMAIL EARN FOR ALL-SERVICE CLIENT"),
          CopyableTextButton(informations.email),
          InfoWidget(
              ontap: () {
                Fonctions.sendTel(informations.OM);
              },
              icone: Icon(Icons.payment),
              titre: "ORANGE MONEY",
              size: size,
              text: informations.OM_name),
          CopyableTextButton(informations.OM),
          InfoWidget(
              ontap: () {
                Fonctions.sendTel(informations.MOMO);
              },
              icone: Icon(Icons.payment),
              titre: "MTN MOMO",
              size: size,
              text: informations.MOMO_name),
          CopyableTextButton(informations.MOMO),
          InfoWidget(
              ontap: () {
                Fonctions.sendEmail(
                    "Bonjour, je m'appelle : ", informations.email);
              },
              icone: Icon(Icons.message),
              titre: "EMAIL",
              size: size,
              text: "EMAIL EARN FOR ALL"),
          CopyableTextButton(informations.email),
          InfoWidget(
              icone: Icon(Icons.payment),
              titre: "BEP 20",
              size: size,
              text: "ADRESSE BRP 20 EARN FOR ALL"),
          CopyableTextButton(informations.BEP20),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/logoEFA (1).jpg",
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () {
              Fonctions.sendEmail(
                  "Bonjour, je m'appelle : ", informations.email);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: buttoncolor, borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Text(
                  "Contacter",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class InfoWidget extends StatefulWidget {
  Icon? icone;
  String? text;
  String? titre;
  var size;
  var ontap;
  InfoWidget(
      {super.key,
      required this.icone,
      required this.titre,
      required this.size,
      required this.text,
      this.ontap});

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.ontap == null) {
      widget.ontap = () {
        print("tap");
      };
    }
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.ontap,
            child: Container(
              margin: EdgeInsets.only(
                top: 10,
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
                    top: 10, bottom: 20, right: 20, left: 20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      // decoration: BoxDecoration(
                      //   color: arrowbgColor,
                      //   borderRadius: BorderRadius.circular(15),
                      //   // shape: BoxShape.circle
                      // ),
                      child: Center(child: widget.icone),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: (widget.size.width - 90) * 0.7,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.titre!,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.text!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: black.withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
