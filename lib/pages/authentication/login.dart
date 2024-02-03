import 'package:earn_for_all/gen/assets.gen.dart';
import 'package:earn_for_all/pages/other/Splash_screen.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:earn_for_all/pages/authentication/login.dart';
import 'package:earn_for_all/pages/authentication/register.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/widgets/drawer_presentation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var lottieController;
  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(
      vsync: this,
    );

    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        lottieController.reset();
      }
    });
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  SizedBox(
                    height: 185,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logoEFA (1).jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Text(
                      'Content de te Revoir Sur ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF262626),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      'Earn For All',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.deepPurple,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.5),
                      child: Text(
                        'Remplissez ce formulaire pour vous connecter ou connectez-vous avec Google',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF262626),
                          height: 1.28,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: _button2(text: 'Connexion avec Google'),
                  ),
                  _textField(
                    hintText: 'Votre email',
                    prefixIcon:
                        const Icon(Icons.mail, color: Color(0xFFA8A8A8)),
                  ),
                  SizedBox(height: 14),
                  _textField(
                    hintText: 'Votre mot de passe',
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFFA8A8A8)),
                  ),
                  SizedBox(height: 60),
                  _button1(text: 'Se connecter'),
                  _button3(text: 'Creer un compte', isTransparent: true),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: DrawerPresentation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        backgroundColor: mainFontColor,
        child: const Icon(
          Icons.info,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _button3({required String text, bool isTransparent = false}) =>
      ElevatedButton(
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isTransparent ? Colors.transparent : Colors.deepPurple,
          elevation: 0,
          shadowColor: Colors.transparent,
          fixedSize: Size(342, 64),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isTransparent ? Colors.deepPurple : const Color(0xFFF4F4F4),
          ),
        ),
      );

  Widget _button1({required String text, bool isTransparent = false}) =>
      ElevatedButton(
        onPressed: () {
          showSuccessfulDialog();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isTransparent ? Colors.transparent : Colors.deepPurple,
          elevation: 0,
          shadowColor: Colors.transparent,
          fixedSize: Size(342, 64),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isTransparent ? Colors.deepPurple : const Color(0xFFF4F4F4),
          ),
        ),
      );

  Widget _button2({required String text, bool isTransparent = false}) => Center(
        child: ElevatedButton(
          onPressed: () async {
            await showSuccessfulDialog();
            Future.delayed(Duration(seconds: 0), () {
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isTransparent
                ? Colors.transparent
                : const Color.fromARGB(189, 104, 58, 183),
            elevation: 0,
            shadowColor: Colors.transparent,
            fixedSize: Size(250, 50),
          ),
          child: Row(
            children: [
              Icon(Icons.mail),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isTransparent ? Colors.white : Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _textField({required String hintText, required Widget prefixIcon}) =>
      TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFA8A8A8),
          ),
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 22),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
        ),
      );

  Future showSuccessfulDialog() => showDialog(
      context: context,
      builder: (context) => Dialog(
            backgroundColor: primary,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Lottie.asset("assets/lotties/ok_blue.json",
                  repeat: false,
                  controller: lottieController, onLoaded: (composition) {
                lottieController.duration = composition.duration;
                lottieController.forward();
              }),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Connexion Reussie",
                  style: TextStyle(
                      color: mainFontColor,
                      fontSize: 21,
                      fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 14),
            ]),
          ));
}
