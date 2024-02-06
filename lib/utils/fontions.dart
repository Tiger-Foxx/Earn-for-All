import 'package:earn_for_all/models/USER.dart';
import 'package:earn_for_all/models/messages_efa.dart';
import 'package:earn_for_all/models/transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Fonctions {
  static String getUserEmail() {
    var _Auth = FirebaseAuth.instance;

    // Obtenir l'objet User avec un null check
    User user = _Auth.currentUser!;
    // Retourner l'email de l'utilisateur
    return user.email.toString() ?? "";
  }

// Une fonction qui permet de récupérer toutes les transactions correspondant à un utilisateur donné
  static Future<List<transaction>> recuperertransactionsParUtilisateur(
      String email) async {
    // Créer une liste vide pour stocker les transactions
    List<transaction> transactions = [];
    try {
      // Créer une référence à la collection transactions
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('transactions');
      // Obtenir les documents de la collection qui correspondent à l'email de l'utilisateur
      QuerySnapshot querySnap = await colRef
          .where('utilisateur', isEqualTo: email)
          .orderBy('date', descending: true)
          .get();
      // Parcourir tous les documents
      for (DocumentSnapshot docSnap in querySnap.docs) {
        // Extraire les données du document
        Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
        // Créer un objet transaction à partir des données
        transaction transact = transaction(
          date: data['date'].toDate(),
          isValid: data['is_valid'],
          montant: data['montant'] + 0.0,
          nom_OM_MOMO: data['nom_OM_MOMO'],
          numero_OM_MOMO: data['numero_OM_MOMO'],
          reseau: data['reseau'],
          tel: data['tel'],
          type: data['type'],
          utilisateur: data['utilisateur'],
        );
        // Ajouter l'ID du document au modèle de transaction
        transact.id = docSnap.id;
        // Ajouter l'objet transaction à la liste
        transactions.add(transact);
      }
      // Retourner la liste des transactions
      return transactions;
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
      // Retourner une liste vide
      return transactions;
    }
  }

// Une fonction qui permet de récupérer toutes les transactions
  static Future<List<transaction>> recuperertransactions() async {
    // Créer une liste vide pour stocker les transactions
    List<transaction> transactions = [];
    try {
      // Créer une référence à la collection transactions
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('transactions');
      // Obtenir les documents de la collection qui correspondent à l'email de l'utilisateur
      QuerySnapshot querySnap =
          await colRef.orderBy('date', descending: true).get();
      // Parcourir tous les documents
      for (DocumentSnapshot docSnap in querySnap.docs) {
        // Extraire les données du document
        Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
        // Créer un objet transaction à partir des données
        transaction transact = transaction(
          date: data['date'].toDate(),
          isValid: data['is_valid'],
          montant: data['montant'] + 0.0,
          nom_OM_MOMO: data['nom_OM_MOMO'],
          numero_OM_MOMO: data['numero_OM_MOMO'],
          reseau: data['reseau'],
          tel: data['tel'],
          type: data['type'],
          utilisateur: data['utilisateur'],
        );
        // Ajouter l'ID du document au modèle de transaction
        transact.id = docSnap.id;
        // Ajouter l'objet transaction à la liste
        transactions.add(transact);
      }
      // Retourner la liste des transactions
      return transactions;
    } on Exception catch (_, e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite ici : $e");

      // Retourner une liste vide
      return transactions;
    }
  }

// Une fonction qui permet d'ajouter une transaction dans la collection firebase à partir d'un objet transaction
  static Future<void> ajoutertransaction(transaction transaction) async {
    try {
      // Créer une référence à la collection transactions
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('transactions');
      // Ajouter l'objet transaction dans la collection
      transaction.tel =
          (await recupererUtilisateurParEmail(getUserEmail())).tel;
      await colRef.add(transaction.toJson());
      // Afficher un message de succès
      print("La transaction a été ajoutée avec succès");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui permet de supprimer une transaction dont on connait l'id
  static Future<void> supprimerTransaction(String id) async {
    try {
      // Créer une référence au document correspondant à l'id
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('transactions').doc(id);
      // Supprimer le document
      await docRef.delete();
      // Afficher un message de succès
      print("La transaction a été supprimée avec succès");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui permet de valider une transaction dont on connait l'id
  static Future<void> validerTransaction(String id) async {
    try {
      // Créer une référence au document correspondant à l'id
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('transactions').doc(id);
      // Mettre à jour le champ isValid du document avec la valeur true
      await docRef.update({'is_valid': true});
      // Afficher un message de succès
      print("La transaction a été validée avec succès");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui récupère un utilisateur par son email
  static Future<USER> recupererUtilisateurParEmail(String email) async {
    // Créer une référence au document correspondant à l'email
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('utilisateurs').doc(email);
    // Obtenir le document
    DocumentSnapshot docSnap = await docRef.get();
    // Vérifier si le document existe
    if (docSnap.exists) {
      // Extraire les données du document
      Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
      // Créer un objet USER à partir des données
      USER utilisateur = USER(
        uid: docSnap.id,
        email: data['email'],
        codeParrainage: data['codeParrainage'],
        email_parrain: data['email_parrain'],
        est_parrainee: data['est_parrainee'],
        nb_parrainage: data['nb_parrainage'],
        soldeBchain: data['soldeBchain'] + 0.0,
        soldeHiving: data['soldeHiving'] + 0.0,
        tel: data['tel'],
        gainBchain: data['gainBchain'] + 0.0,
        gainHiving: data['gainHiving'] + 0.0,
      );
      // Retourner l'objet USER
      return utilisateur;
    } else {
      // Si le document n'existe pas, afficher un message d'erreur
      print("L'utilisateur n'existe pas");
      // Retourner un objet USER vide
      return USER();
    }
  }

// Une fonction qui récupère une liste de tous les utilisateurs de la collection utilisateurs
  static Future<List<USER>> recupererUtilisateurs() async {
    // Créer une liste vide pour stocker les objets USER
    List<USER> utilisateurs = [];
    try {
      // Créer une référence à la collection utilisateurs
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('utilisateurs');
      // Obtenir tous les documents de la collection
      QuerySnapshot querySnap = await colRef.get();
      // Parcourir tous les documents
      for (DocumentSnapshot docSnap in querySnap.docs) {
        // Extraire les données du document
        Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
        // Créer un objet USER à partir des données
        USER utilisateur = USER(
          uid: docSnap.id,
          email: data['email'],
          codeParrainage: data['codeParrainage'],
          email_parrain: data['email_parrain'],
          est_parrainee: data['est_parrainee'],
          nb_parrainage: data['nb_parrainage'],
          soldeBchain: data['soldeBchain'] + 0.0,
          soldeHiving: data['soldeHiving'] + 0.0,
          tel: data['tel'],
        );
        // Ajouter l'objet USER à la liste
        utilisateurs.add(utilisateur);
      }
      // Retourner la liste des utilisateurs
      return utilisateurs;
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
      // Retourner une liste vide
      return utilisateurs;
    }
  }

  // Une fonction qui crée un objet utilisateur dans Firestore si il n'existe pas déjà
  static Future<void> creerUtilisateur(
      String email, String codeParrainage, String numeroTelephone) async {
    try {
      // Créer une référence au document correspondant à l'email
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('utilisateurs').doc(email);
      // Vérifier si le document existe
      DocumentSnapshot docSnap = await docRef.get();
      if (docSnap.exists) {
        // Si le document existe, afficher un message
        print("L'utilisateur existe déjà");
      } else {
        // Si le document n'existe pas, créer un objet Map contenant les données à écrire
        Map<String, dynamic> data = {
          'codeParrainage': codeParrainage,
          'email': email,
          'email_parrain': '',
          'est_parrainee': false,
          'nb_parrainage': 0.0001,
          'soldeBchain': 0.00001,
          'soldeHiving': 0.00001,
          // Ajout du champ numéro de téléphone
          'tel': numeroTelephone,
          'gainBchain': 0.00001,
          'gainHiving': 0.00001,
        };
        // Écrire les données dans le document
        await docRef.set(data);
        // Afficher un message de succès
        print("TOUT EST OK");
      }
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui génère un code de parrainage aléatoire
  static String genererCodeParrainage() {
    // Une chaîne contenant tous les caractères possibles
    const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    // Une variable pour stocker le code généré
    String code = '';
    // Un générateur de nombres aléatoires
    Random random = Random();
    // Une boucle pour ajouter 7 caractères aléatoires au code
    for (int i = 0; i < 7; i++) {
      // Choisir un caractère aléatoire dans la chaîne
      int index = random.nextInt(caracteres.length);
      // Ajouter le caractère au code
      code += caracteres[index];
    }
    // Obtenir l'heure actuelle en secondes
    int heure = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    // Convertir l'heure en chaîne
    String heureString = heure.toString();
    // Ajouter l'heure au code
    code += heureString;
    // Retourner le code
    return code;
  }

  static void sendMsg(String message, String number) {
    // Encoder le message
    String encodedMessage = Uri.encodeComponent(message);

    // Construire l'URL
    String url = 'https://wa.me/$number?text=$encodedMessage';

    // Lancer l'URL
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch WhatsApp: $e');
    }
  }

  static void sendEmail(String message, String email) {
    String subject = "MESSAGE CLIENT EARN FOR ALL - BESOIN D'ASSISTANCE";
    // Encoder le message, l'email et le sujet
    String encodedMessage = Uri.encodeComponent(message);
    String encodedEmail = Uri.encodeComponent(email);
    String encodedSubject = Uri.encodeComponent(subject);

    // Construire l'URL
    String url =
        'mailto:$encodedEmail?subject=$encodedSubject&body=$encodedMessage';

    // Lancer l'URL
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch email: $e');
    }
  }

  static void sendTel(String number) {
    // Encoder le message

    // Construire l'URL
    number = Uri.encodeComponent(number);
    String url = 'tel:$number';

    print("apres encodage on a $url");

    // Lancer l'URL
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch URL: $e');
    }
  }

// Une fonction qui permet de mettre un utilisateur comme etant deja parrainee
  static Future<void> incrementerNbParrainage(String email) async {
    try {
      // Créer une référence au document correspondant à l'email
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('utilisateurs').doc(email);
      // Incrémenter le champ nb_parrainage du document avec la valeur 1
      await docRef.update({'nb_parrainage': FieldValue.increment(1)});
      // Afficher un message de succès
      print("Le nombre de parrainage a été incrémenté avec succès");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui permet de mettre un utilisateur comme etant parraine
  static Future<void> Metparrainee(String email) async {
    try {
      // Créer une référence au document correspondant à l'email
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('utilisateurs').doc(email);
      // Incrémenter le champ nb_parrainage du document avec la valeur 1
      await docRef.update({'est_parrainee': true});
      // Afficher un message de succès
      print("L'utilisateur a ete mis comme parrainee");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui permet de mettre un email comme email de parrain à un utilisateur
  static Future<void> mettreEmailParrain(
      String email, String emailParrain) async {
    try {
      // Créer une référence au document correspondant à l'email
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('utilisateurs').doc(email);
      // Mettre à jour le champ email_parrain du document avec la valeur emailParrain
      await docRef.update({'email_parrain': emailParrain});
      // Afficher un message de succès
      print("L'email de parrain a été mis à jour avec succès");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui permet de récupérer un utilisateur dont le code de parrainage est donné en paramètre
  static Future<USER> recupererUtilisateurParCodeParrainage(
      String codeParrainage) async {
    // Créer un objet USER vide
    USER utilisateur = USER();
    try {
      // Créer une référence à la collection utilisateurs
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('utilisateurs');
      // Obtenir le document de la collection qui correspond au code de parrainage
      QuerySnapshot querySnap = await colRef
          .where('codeParrainage', isEqualTo: codeParrainage)
          .limit(1)
          .get();
      // Vérifier si le document existe
      if (querySnap.size > 0) {
        // Extraire les données du document
        Map<String, dynamic> data =
            querySnap.docs[0].data() as Map<String, dynamic>;
        // Créer un objet USER à partir des données
        utilisateur = USER(
          email: data['email'],
          codeParrainage: data['codeParrainage'],
          email_parrain: data['email_parrain'],
          est_parrainee: data['est_parrainee'],
          nb_parrainage: data['nb_parrainage'],
          soldeBchain: data['soldeBchain'] + 0.0,
          soldeHiving: data['soldeHiving'] + 0.0,
          tel: data['tel'],
        );
      } else {
        // Si le document n'existe pas, afficher un message d'erreur
        print("Le code de parrainage n'est pas valide");
      }
      // Retourner l'objet USER
      return utilisateur;
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
      // Retourner un objet USER vide
      return utilisateur;
    }
  }

// Une fonction qui permet d'attribuer un parrain à un utilisateur dont l'email est donné en paramètre et le code de parrainage du parrain
  static Future<dynamic> parrainer(String email, String codeParrainage) async {
    try {
      // Récupérer l'utilisateur qui correspond à l'email
      USER utilisateur = await recupererUtilisateurParEmail(email);
      // Vérifier si l'utilisateur n'est pas déjà parrainé
      if (utilisateur.est_parrainee == false) {
        // Récupérer l'utilisateur qui correspond au code de parrainage
        USER parrain =
            await recupererUtilisateurParCodeParrainage(codeParrainage);
        // Vérifier si le parrain existe
        if (parrain.email != null && parrain.email != "") {
          // Mettre l'email du parrain comme email de parrain à l'utilisateur
          await mettreEmailParrain(email, parrain.email!);
          // Incrémenter le nombre de parrainage du parrain
          await incrementerNbParrainage(parrain.email!);
          //mettre l'utilisateur comme etant parraine
          await Metparrainee(email);
          // Afficher un message de succès
          print("Le parrainage a été effectué avec succès");
          return true;
        } else {
          // Si le parrain n'existe pas, afficher un message d'erreur
          print("Le code de parrainage n'est pas valide");
          return false;
        }
      } else {
        // Si l'utilisateur est déjà parrainé, afficher un message d'erreur
        print("L'utilisateur est déjà parrainé");
        return false;
      }
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
      return false;
    }
  }

// Une fonction qui prend en paramètre un nombre qui représente un pourcentage x
// et un paramètre qui indique le solde à augmenter (bchain ou hiving)
  static Future<void> distribuer(double x, String solde) async {
    try {
      // Créer une référence à la collection utilisateurs
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('utilisateurs');
      // Obtenir tous les documents de la collection
      QuerySnapshot querySnap = await colRef.get();
      // Parcourir tous les documents
      for (DocumentSnapshot docSnap in querySnap.docs) {
        // Extraire les données du document
        Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
        // Créer un objet USER à partir des données
        USER utilisateur = USER(
          email: data['email'],
          codeParrainage: data['codeParrainage'],
          email_parrain: data['email_parrain'],
          est_parrainee: data['est_parrainee'],
          nb_parrainage: data['nb_parrainage'],
          soldeBchain: data['soldeBchain'] + 0.0,
          soldeHiving: data['soldeHiving'] + 0.0,
          tel: data['tel'],
        );
        // Calculer le montant de l'augmentation du solde en fonction du paramètre x
        // et du paramètre solde
        double augmentation = 0;
        if (solde == "Trading") {
          // Calculer l'augmentation en fonction du soldeBchain de l'utilisateur
          augmentation = utilisateur.soldeBchain! * x / 100;
        } else if (solde == "Halving") {
          // Calculer l'augmentation en fonction du soldeHiving de l'utilisateur
          augmentation = utilisateur.soldeHiving! * x / 100;
        }
        // Mettre à jour le solde de l'utilisateur en fonction du paramètre solde
        if (solde == "Trading") {
          // Augmenter le soldeBchain de l'utilisateur
          await docSnap.reference.update({
            'soldeBchain': FieldValue.increment(augmentation),
            // Stocker la différence dans le champ gainBchain
            'gainBchain': augmentation + 0.0,
          });
        } else if (solde == "Halving") {
          // Augmenter le soldeHiving de l'utilisateur
          await docSnap.reference.update({
            'soldeHiving': FieldValue.increment(augmentation),
            // Stocker la différence dans le champ gainHiving
            'gainHiving': augmentation + 0.0,
          });
        }
      }
      // Reparcourir tous les documents
      for (DocumentSnapshot docSnap in querySnap.docs) {
        // Extraire les données du document
        Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
        // Créer un objet USER à partir des données
        USER utilisateur = USER(
          uid: data['uid'],
          email: data['email'],
          codeParrainage: data['codeParrainage'],
          email_parrain: data['email_parrain'],
          est_parrainee: data['est_parrainee'],
          nb_parrainage: data['nb_parrainage'],
          soldeBchain: data['soldeBchain'] + 0.0,
          soldeHiving: data['soldeHiving'] + 0.0,
          tel: data['tel'],
        );
        // Vérifier si l'utilisateur est parrainé
        if (utilisateur.est_parrainee == true) {
          // Récupérer le parrain de l'utilisateur
          USER parrain =
              await recupererUtilisateurParEmail(utilisateur.email_parrain!);
          // Calculer le montant du bonus du parrain en fonction du paramètre x
          // et du gain de l'utilisateur
          double bonus = 0;
          if (solde == "Trading") {
            // Calculer le bonus en fonction du gainBchain de l'utilisateur
            bonus = utilisateur.gainBchain! * 9 / 100;
            // Augmenter le soldeBchain du parrain
            DocumentReference docRef = FirebaseFirestore.instance
                .collection('utilisateurs')
                .doc(parrain.email);
            await docRef.update({
              'soldeBchain': FieldValue.increment(bonus),
              // Stocker la différence dans le champ gainParrainage
              'gainParrainage': FieldValue.increment(bonus),
            });
          } else if (solde == "Halving") {
            DocumentReference docRef = FirebaseFirestore.instance
                .collection('utilisateurs')
                .doc(parrain.email);
            // Calculer le bonus en fonction du gainHiving de l'utilisateur
            bonus = utilisateur.gainHiving! * 9 / 100 + 0.0;
            // Augmenter le soldeHiving du parrain
            await docRef.update({
              'soldeHiving': FieldValue.increment(bonus),
              // Stocker la différence dans le champ gainParrainage
              'gainParrainage': FieldValue.increment(bonus),
            });
          }
        }
      }
      // Afficher un message de succès
      print("La distribution a été effectuée avec succès");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui permet de récupérer tous les messages (avec ID) de la collection
  static Future<List<MessagesEFA>> recupererTousLesMessages() async {
    // Créer une liste vide pour stocker les messages
    List<MessagesEFA> messages = [];
    try {
      // Créer une référence à la collection messages
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('messages');
      // Obtenir tous les documents de la collection
      QuerySnapshot querySnap =
          await colRef.orderBy("date", descending: true).get();
      // Parcourir tous les documents
      for (DocumentSnapshot docSnap in querySnap.docs) {
        // Extraire les données du document
        Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
        // Créer un objet MessagesEFA à partir des données
        MessagesEFA message = MessagesEFA(
          id: docSnap.id, // Obtenir l'ID du document
          texte: data['texte'],

          date: data['date'].toDate(),
        );
        // Ajouter l'objet MessagesEFA à la liste
        messages.add(message);
      }
      // Retourner la liste des messages
      return messages;
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
      // Retourner une liste vide
      return messages;
    }
  }

// Une fonction qui permet de supprimer un message dont on connait l'ID
  static Future<void> supprimerMessage(String id) async {
    try {
      // Créer une référence au document correspondant à l'ID
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('messages').doc(id);
      // Supprimer le document
      await docRef.delete();
      // Afficher un message de succès
      print("Le message a été supprimé avec succès");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

// Une fonction qui permet d'ajouter des messages dans la collection firebase à partir d'un objet messagesEFA
  static Future<void> ajouterMessages(MessagesEFA message) async {
    try {
      // Créer une référence à la collection messages
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('messages');

      await colRef.add(message.toJson());
      // Afficher un message de succès
      print("Le message a été ajouté avec succès");
    } catch (e) {
      // Afficher un message d'erreur
      print("Une erreur s'est produite: $e");
    }
  }

  static Future<List<double>> calculerBudget() async {
    List<USER> utilisateurs = await recupererUtilisateurs();
    double budget_Halving = 0;
    double budget_Trading = 0;
    for (USER utilisateur in utilisateurs) {
      budget_Halving = budget_Halving + (utilisateur.soldeHiving ?? 0.0);
      budget_Trading = budget_Trading + (utilisateur.soldeBchain ?? 0.0);
    }
    double len = utilisateurs.length + 0.0;
    return List.from(<double>[budget_Halving, budget_Trading, len]);
  }

// Définir une fonction qui prend en paramètre l'email et le montant à ajouter au solde
  Future<void> incrementerSolde(
      String email, String type, double montant) async {
    // Définir une référence à la collection utilisateurs
    CollectionReference utilisateurs =
        FirebaseFirestore.instance.collection('utilisateurs');
    // Récupérer le document correspondant à l'email
    DocumentSnapshot document = await utilisateurs.doc(email).get();

    // Vérifier si le document existe
    if (document.exists) {
      // Récupérer le solde actuel

      // Mettre à jour le document avec le nouveau solde
      if (type == "Halving") {
        await utilisateurs
            .doc(email)
            .update({'soldeHiving': FieldValue.increment(montant)});
      } else {
        await utilisateurs
            .doc(email)
            .update({'soldeBchain': FieldValue.increment(montant)});
      }

      // Afficher un message de succès
      print('Le solde de $email a été mis à jour avec succès.');
    } else {
      // Afficher un message d'erreur
      print('Aucun utilisateur trouvé avec cet email.');
    }
  }

// Une fonction qui récupère un utilisateur par son email
  static Future<transaction> recupererTransactionParID(String id) async {
    // Créer une référence au document correspondant à l'email
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('transactions').doc(id);
    // Obtenir le document
    DocumentSnapshot docSnap = await docRef.get();
    // Vérifier si le document existe
    if (docSnap.exists) {
      // Extraire les données du document
      Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
      // Créer un objet USER à partir des données
      transaction transact = transaction(
        id: docSnap.id, // Obtenir l'ID du document
        montant: data['montant'],
        date: data['date'].toDate(),
        type: data['type'],
        utilisateur: data['utilisateur'],
        reseau: data['reseau'],
      );
      // Retourner l'objet USER
      return transact;
    } else {
      // Si le document n'existe pas, afficher un message d'erreur
      print("La transaction n'existe pas");
      // Retourner un objet USER vide
      return transaction();
    }
  }

  // Définir une fonction qui prend en paramètre l'identifiant du document firestore qui correspond à la transaction
  static Future<void> AppliquerTransaction(String id) async {
    CollectionReference transactions =
        FirebaseFirestore.instance.collection('transactions');
    // Récupérer le document correspondant à l'identifiant
    DocumentSnapshot document = await transactions.doc(id).get();
    CollectionReference utilisateurs =
        FirebaseFirestore.instance.collection('utilisateurs');
    // Vérifier si le document existe
    if (document.exists) {
      // Récupérer l'email de l'utilisateur
      transaction transactionCible = await recupererTransactionParID(id);

      // Vérifier le type de la transaction
      if (transactionCible.type == 'depot') {
        // Vérifier le réseau de la transaction
        if (transactionCible.reseau == 'Trading') {
          // Augmenter le soldeBchain de l'utilisateur
          await utilisateurs.doc(transactionCible.utilisateur).update({
            'soldeBchain':
                FieldValue.increment(transactionCible.montant ?? 0.0),
          });
        } else if (transactionCible.reseau == 'Halving') {
          // Augmenter le soldeHiving de l'utilisateur
          await utilisateurs.doc(transactionCible.utilisateur).update({
            'soldeHiving':
                FieldValue.increment(transactionCible.montant ?? 0.0),
          });
        }
      } else if (transactionCible.type == 'retrait') {
        // Vérifier le réseau de la transaction
        if (transactionCible.reseau == 'Trading') {
          // Vérifier si le soldeBchain de l'utilisateur est suffisant

          // Diminuer le soldeBchain de l'utilisateur
          await utilisateurs.doc(transactionCible.utilisateur).update({
            'soldeBchain':
                FieldValue.increment(-(transactionCible.montant ?? 0.0)),
          });
        } else if (transactionCible.reseau == 'Halving') {
          // Vérifier si le soldeHiving de l'utilisateur est suffisant

          // Diminuer le soldeHiving de l'utilisateur
          await utilisateurs.doc(transactionCible.utilisateur).update({
            'soldeHiving':
                FieldValue.increment(-(transactionCible.montant ?? 0.0)),
          });
        }
      }

      // Afficher un message de succès
      print('La transaction a été appliquée avec succès.');
    } else {
      // Afficher un message d'erreur
      print('Aucune transaction trouvée avec cet identifiant.');
    }
  }
}
