import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/widgets/copiable_text.dart';
import 'package:flutter/material.dart';

class DrawerParrainage extends StatefulWidget {
  String? codeParrainage = "";
  DrawerParrainage({super.key, this.codeParrainage});

  @override
  State<DrawerParrainage> createState() => _DrawerParrainageState();
}

class _DrawerParrainageState extends State<DrawerParrainage> {
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
                        'PARRAINAGE',
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
                      "Regardez ICI votre code de parrainage, ou entrez le code de votre parrain,\nParrainer des personnes offre de gains supplementaires",
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
                        Text(
                          'Votre Code\n(Cliquez pour copier)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Work Sans',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CopyableTextButton("ASAHJADF5784541457DFSDFSF465547"),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Entrez ICI le code de votre parrain',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "CODE : XXXXXXXXXXXXXXXX",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: white,
                        ),
                        prefixIcon: Icon(
                          Icons.key_rounded,
                          color: white,
                        ),
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
                    SizedBox(
                      height: 28,
                    ),
                    ElevatedButton(
                      onPressed: !is_parrain
                          ? () {
                              setState(() {
                                is_parrain = !is_parrain;
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        fixedSize: Size(342, 64),
                      ),
                      child: Text(
                        'Valider',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF4F4F4),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Pour Chaque personne que vous parrainez , vous pouvez generer j\'usqua 25% de gains supplementaires',
                      textAlign: TextAlign.center,
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
