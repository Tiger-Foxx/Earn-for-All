import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  // Une fonction qui envoie un email de réinitialisation à l'adresse fournie
  Future<void> envoyerEmailReinitialisation(String email) async {
    try {
      // Créer une instance de FirebaseAuth
      FirebaseAuth auth = FirebaseAuth.instance;
      // Envoyer l'email de réinitialisation
      await auth.sendPasswordResetEmail(email: email);
      // Afficher un message de succès
      print('Un email de réinitialisation a été envoyé à $email');
    } catch (e) {
      // Afficher un message d'erreur
      print('Une erreur est survenue: $e');
    }
  }

  // Une clé globale pour valider le formulaire
  final _formKey = GlobalKey<FormState>();
  // Un contrôleur pour accéder à la valeur du champ de texte
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mot de passe oublié'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Un champ de texte pour saisir l'email
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Entrez votre email',
                        border: OutlineInputBorder(),
                      ),
                      // Une fonction de validation pour vérifier si l'email est valide
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un email';
                        }
                        if (!value.contains('@')) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Un bouton pour valider le formulaire et envoyer l'email
                  ElevatedButton(
                    onPressed: () {
                      // Si le formulaire est valide, afficher un message
                      if (_formKey.currentState!.validate()) {
                        envoyerEmailReinitialisation(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Un email de réinitialisation a été envoyé à ${_emailController.text}'),
                          ),
                        );
                      }
                    },
                    child: Text('Valider'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
