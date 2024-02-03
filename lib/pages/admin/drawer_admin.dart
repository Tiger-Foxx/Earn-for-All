import 'package:earn_for_all/pages/admin/add_message.dart';
import 'package:earn_for_all/pages/admin/distribuer.dart';
import 'package:earn_for_all/pages/admin/transactions_admin.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/widgets/copiable_text.dart';
import 'package:flutter/material.dart';

class DrawerAdmin extends StatefulWidget {
  const DrawerAdmin({super.key});

  @override
  State<DrawerAdmin> createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  bool is_parrain = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                        'BIENVENUE , ADMINISTRATEUR',
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
                      "Seul l'administrateur peut voir ce panneau.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddMessage()));
                          },
                          child: Column(
                            children: [
                              Divider(),
                              ListTile(
                                leading: Icon(
                                  Icons.add,
                                  color: primary,
                                ),
                                title: Text(
                                  'AJOUTER UN MESSAGE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: primary),
                                ),
                                subtitle: Text(
                                  "laissez un message aux utilisateur",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: primary),
                                ),
                                hoverColor: mainFontColor,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Distribuer()));
                          },
                          child: Column(
                            children: [
                              Divider(),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: primary,
                                ),
                                title: Text(
                                  'DISTRIBUER',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: primary),
                                ),
                                subtitle: Text(
                                  "Distribuez les gains aux utilisateurs",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: primary),
                                ),
                                hoverColor: mainFontColor,
                                tileColor: primary,
                                textColor: Colors.white,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransactionAdmin()));
                          },
                          child: Column(
                            children: [
                              Divider(),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: primary,
                                ),
                                title: Text(
                                  'TRANSACTIONS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: primary),
                                ),
                                subtitle: Text(
                                  "VOIR LES TRANSACTIONS EN COURS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: primary),
                                ),
                                hoverColor: mainFontColor,
                                tileColor: primary,
                                textColor: Colors.white,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
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
