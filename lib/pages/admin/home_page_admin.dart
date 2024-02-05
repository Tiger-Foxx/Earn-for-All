import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:earn_for_all/pages/admin/acceuil_admin.dart';
import 'package:earn_for_all/pages/admin/messages_screens_admin.dart';
import 'package:earn_for_all/pages/other/Splash_screen.dart';
import 'package:earn_for_all/pages/other/informations_page.dart';
import 'package:earn_for_all/pages/intermediares/intermediateInvest.dart';
import 'package:earn_for_all/pages/intermediares/intermediateRetrait.dart';
import 'package:earn_for_all/pages/other/messages_screens.dart';
import 'package:earn_for_all/pages/admin/drawer_admin.dart';
import 'package:earn_for_all/widgets/drawer_parrainage.dart';
import 'package:earn_for_all/widgets/drawer_presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:earn_for_all/pages/other/acceuil.dart';
import 'package:earn_for_all/pages/other/transection_page.dart';
import 'package:earn_for_all/theme/colors.dart';

class HomePageAdmin extends StatefulWidget {
  static var scaffoldKey;

  HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  int pageIndex = 0;

  List<Widget> pages = [
    DailyPageAdmin(), //acceuil
    IntermediateRetrait(), //retrait
    MessagesScreenAdmin(), // messages
    InformationPage(), //infos et service client
  ];

  @override
  Widget build(BuildContext context) {
    // Créer une GlobalKey de type ScaffoldState
    HomePageAdmin.scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
        key: HomePageAdmin.scaffoldKey,
        backgroundColor: primary,
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: SafeArea(
          child: SizedBox(
            // height: 30,
            // width: 40,
            child: FloatingActionButton(
              onPressed: () async {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Intermediate()));
              },
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
              backgroundColor: buttoncolor,
              // shape:
              //     BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        drawerScrimColor: Colors.transparent,
        drawer: DrawerAdmin());
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      CupertinoIcons.home,
      CupertinoIcons.creditcard,
      CupertinoIcons.chat_bubble,
      CupertinoIcons.info_circle,
    ];
    return AnimatedBottomNavigationBar(
        backgroundColor: primary,
        icons: iconItems,
        splashColor: secondary,
        inactiveColor: black.withOpacity(0.5),
        gapLocation: GapLocation.center,
        activeIndex: pageIndex,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        iconSize: 25,
        rightCornerRadius: 10,
        elevation: 2,
        onTap: (index) {
          setTabs(index);
        });
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
