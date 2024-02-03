import 'package:earn_for_all/gen/assets.gen.dart';
import 'package:earn_for_all/models/USER.dart';
import 'package:earn_for_all/pages/other/Splash_screen.dart';
import 'package:earn_for_all/pages/other/home_page.dart';
import 'package:earn_for_all/pages/authentication/login.dart';
import 'package:earn_for_all/pages/authentication/register.dart';
import 'package:earn_for_all/services/Authentification.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/widgets/drawer_presentation.dart';
import 'package:email_validator/email_validator.dart';
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
  var utilisateur;
  bool _isObscure = true;
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

  // Créer une clé globale pour le formulaire
  final _formKey = GlobalKey<FormState>();
  // Créer un modèle d'utilisateur avec des attributs email et mot de passe
  USER _user = USER();
  Authentification inscripteur = Authentification();
  bool _isLoading = false;
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: _button2(text: 'Connexion avec Google'),
                        ),
                        if (_isLoading)
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                            width: 70,
                            height: 70,
                          ),
                        _textField(
                          hintText: 'Votre email',
                          prefixIcon:
                              const Icon(Icons.mail, color: Color(0xFFA8A8A8)),
                        ),
                        SizedBox(height: 14),
                        _textField2(
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
        onPressed: () async {
          // Valider et soumettre le formulaire
          if (_formKey.currentState!.validate()) {
            // Enregistrer les données dans le modèle d'utilisateur
            _formKey.currentState!.save();
            // Envoyer les données à une API externe
            setState(() {
              _isLoading = true;
            });
            utilisateur =
                await inscripteur.signIn(_user.email!, _user.password);
            setState(() {
              _isLoading = false;
            });

            var verif = utilisateur;
            if (verif != 0 || verif != null) {
              await showSuccessfulDialog();
              Future.delayed(Duration(seconds: 0), () {
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        "OUPS",
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.white),
                      ),
                      content: SizedBox(
                        height: 195,
                        child: Column(
                          children: [
                            Text(
                              "Verifiez, l'email, le mot de passe ou votre connexion internet",
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.white),
                            ),
                            Center(
                              child: Lottie.asset(
                                  "assets/lotties/animation_lkqn0ikf.json",
                                  animate: true),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
          }
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
        child: ElevatedButton.icon(
          icon: Image.asset(
            'assets/images/google.png',
            width: 26,
          ),
          onPressed: () async {
            // Mettre l'état de la connexion à vrai
            setState(() {
              _isLoading = true;
            });
            // Appeler la fonction signInWithGoogle avec await
            var utilisateur = await inscripteur.GoogleSignUp();
            // Si la connexion réussit, mettre l'état de la connexion à faux
            setState(() {
              _isLoading = false;
            });
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
          label: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isTransparent ? Colors.white : Colors.white,
            ),
          ),
        ),
      );

  Widget _textField({required String hintText, required Widget prefixIcon}) =>
      TextFormField(
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
        keyboardType: TextInputType
            .emailAddress, // pour avoir un clavier adapté aux emails
        // Ajouter un validateur pour le champ email
        validator: (value) {
          // Vérifier si le texte est vide
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer votre email';
          }
          // Vérifier si le texte respecte un format d'email
          if (!EmailValidator.validate(value)) {
            return 'Veuillez entrer un email valide';
          }
          // Si tout est ok, renvoyer null
          _user.email = value;
          return null;
        },
        onChanged: (value) {
          _user.email = value;
        },
      );

  Widget _textField2({required String hintText, required Widget prefixIcon}) =>
      TextFormField(
        obscureText: _isObscure,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              // Changer l'icône en fonction de la visibilité du mot de passe
              _isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              // Inverser la valeur de la variable booléenne
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
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
        keyboardType: TextInputType
            .emailAddress, // pour avoir un clavier adapté aux emails
        // Ajouter un validateur pour le champ email
        validator: (value) {
          // Vérifier si le texte est vide
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer votre mot de passe';
          }

          // Si tout est ok, renvoyer null
          _user.password = value;
          return null;
        },
        onChanged: (value) {
          _user.password = value;
        },
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
