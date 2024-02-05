import 'package:flutter/material.dart';

class DrawerPresentation extends StatefulWidget {
  const DrawerPresentation({super.key});

  @override
  State<DrawerPresentation> createState() => _DrawerPresentationState();
}

class _DrawerPresentationState extends State<DrawerPresentation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape:
          BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      backgroundColor: Color.fromARGB(255, 63, 40, 101),
      width: 316,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 27, bottom: 14, top: 27),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    child: Image.asset(
                      "assets/images/logoEFA (1).jpg",
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EARN FOR ALL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Presentation',
                        style: TextStyle(
                          color: Color(0xFFA8A8A8),
                          fontSize: 12,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 27, vertical: 22),
                color: Color(0xff525252),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Presentation de l'application",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Bienvenue sur Earn for All, la plateforme qui rassemble les passionnés de la crypto-monnaie désireux de participer à des événements lucratifs pour lesquels ils n\'ont pas les fonds nécessaires. Notre objectif est simple : permettre à chacun de gagner en investissant collectivement dans des opportunités telles que les airdrops, les arbitrages crypto et les événements organisés par les plus grandes plateformes.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Chez Earn for All, nous croyons que l\'union fait la force. En collaborant et en réunissant nos ressources, nous pouvons maximiser nos gains et accéder à des opportunités inaccessibles individuellement. Les fonds collectés seront investis de manière stratégique et les bénéfices seront redistribués équitablement entre les participants 15 a 30 jours après l\'investissement initial.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Gains',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Text(
                      'Les gains potentiels sont prometteurs, avec des rendements allant de 25% à 400% de l\'investissement initial voir au delà. En rejoignant la communauté Earn for All, vous aurez enfin la possibilité de participer aux événements les plus prestigieux de l\'industrie crypto et de récolter les récompenses qui en découlent.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Ne manquez pas cette chance unique d\'atteindre vos objectifs financiers en investissant intelligemment dans le monde passionnant de la crypto-monnaie. Rejoignez-nous dès aujourd\'hui sur Earn for All et faites partie de notre communauté d\'investisseurs visionnaires!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
