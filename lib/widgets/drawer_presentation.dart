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
                      "Chers investisseurs potentiels,\n\nNous sommes ravi de vous présenter une opportunité d'investissement unique qui allie expertise en trading, anticipation des événements crypto, et gestion prudente des fonds. Notre site offre un environnement sécurisé et transparent où vos investissements sont traités avec le plus grand soin.\n\nNous comprenons que la sécurité des fonds est une priorité absolue pour tout investisseur sérieux. C'est pourquoi nous avons mis en place des mesures de sécurité de pointe pour protéger vos actifs. nous nous engageons à assurer la sécurité de chaque centime que vous investissez avec nous.\n\nParlons maintenant des gains. Notre approche flexible et dynamique du trading nous permet de générer des rendements compétitifs pouvant varier entre 2 et 5% par jour, en fonction des conditions du marché et du travail effectué par notre équipe d'experts. Nous croyons en la transparence totale, c'est pourquoi les gains sont redistribués instantanément, vous permettant ainsi de profiter rapidement de vos investissements.\n\nDe plus, nous intégrons une stratégie innovante basée sur les événements crypto et les airdrops, ce qui nous permet de générer des rendements même lorsque le marché semble moins favorable. Cette approche nous offre une flexibilité inégalée pour amortir les fluctuations du marché et maintenir des performances solides à long terme.\n\nNous comprenons que chaque investisseur est unique, c'est pourquoi nous mettons sur pied tout les moyens possible afin de satisfaire chaque investisseur. Que vous soyez novice dans le monde du trading crypto ou un investisseur chevronné, notre équipe dévouée est là pour vous accompagner à chaque étape de votre parcours d'investissement\n\nRejoignez-nous dès aujourd'hui et découvrez un nouveau standard d'excellence en matière d'investissement crypto. Vos fonds sont entre de bonnes mains, et ensemble, nous bâtirons un avenir financier solide et prospère.\n\nS'agissent de notre zone d'investissement axé sur le pré-halving.\n\nNous sommes au cœur d'une révolution numérique sans précédent, où les cryptomonnaies ont conquis une place centrale dans le paysage financier mondial. Et parmi ces cryptomonnaies, le Bitcoin se distingue comme une véritable pépite d'or numérique.\n\nVous êtes-vous déjà demandé comment maximiser vos investissements dans le Bitcoin ? Notre site offre une solution unique en son genre. Nous mettons en avant l'opportunité d'investir avant le halving, un événement crucial dans le cycle de vie du Bitcoin.\n\nLe halving, cet événement mystérieux et tant attendu par la communauté des crypto-traders, réduit de moitié la récompense des mineurs de Bitcoin. Cela crée une rare opportunité pour les investisseurs avertis de capitaliser sur le potentiel de croissance exponentielle du Bitcoin.\n\nNotre approche est simple mais puissante : nous investissons judicieusement avant le halving, capitalisons sur la hausse post-halving, et partageons les gains avec nos investisseurs fidèles. C'est une stratégie éprouvée qui a déjà fait ses preuves, et nous sommes déterminés à continuer sur cette lancée de succès.\n\nEn nous rejoignant, vous devenez partie prenante d'une communauté d'investisseurs visionnaires, prêts à saisir les opportunités là où d'autres voient seulement des défis. Avec notre équipe d'experts passionnés et notre approche rigoureuse de l'investissement, nous sommes prêts à vous accompagner dans votre parcours vers la prospérité financière.\n\nNe manquez pas cette chance exceptionnelle de faire partie de l'histoire de la révolution financière mondiale. Rejoignez-nous dès aujourd'hui et ensemble, nous atteindrons de nouveaux sommets dans le monde des cryptomonnaies.\n\nMerci de votre attention et au plaisir de vous accueillir parmi nous.",
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
