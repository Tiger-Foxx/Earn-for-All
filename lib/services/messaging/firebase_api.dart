import 'dart:convert';
import 'package:earn_for_all/utils/infos.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('body : ${message.notification?.body}');
  print('payload : ${message.data}');
}

class firebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Créer une référence à la collection tokens
  CollectionReference tokens = FirebaseFirestore.instance.collection('tokens');

// Définir une fonction asynchrone qui renvoie le token correspondant à l'email
  Future<String> getToken(String email) async {
    // Obtenir le document qui a pour ID l'email
    DocumentSnapshot doc = await tokens.doc(email).get();
    // Obtenir la valeur du champ token
    String token = doc.get('token');
    // Retourner le token
    return token;
  }

  Future<void> registerToken() async {
    // Get the current user's name or email
    var token = await _firebaseMessaging.getToken();
    // Get the current user object
    User? user = FirebaseAuth.instance.currentUser;
// Get the email of the current user
    String? email = user?.email;
    FirebaseFirestore.instance
        .collection('tokens')
        .doc(email) //email doit etre l'id du document
        .set({'token': token});
  }

  Future<void> handlemsg(RemoteMessage message) async {
    launchUrl(
        Uri.parse(
            "https://console.firebase.google.com/project/cryptoapp-a71a5/firestore/data/~2Fachats"),
        mode: LaunchMode.externalApplication);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    var FCMToken = await _firebaseMessaging.getToken();

    print('Token : $FCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handlemsg);
    await registerToken();
  }

// Créer un message FCM avec le jeton de l'utilisateur et le contenu de la notification
  Future<Map<String, dynamic>> createFCMMessage(
      String token, String title, String body) async {
    Map<String, dynamic> message = {
      'to': token,
      'notification': {
        'title': title,
        'body': body,
        'image':
            'https://a.c-dn.net/c/content/dam/publicsites/sgx/images/Email/Trading_Cryptocurrencies_Effectively_Using_PriceAction.jpg/jcr:content/renditions/original-size.webp'
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
        'link':
            'https://console.firebase.google.com/project/earn-for-all-6d227/firestore/data/~2Futilisateurs',
      },
    };
    return message;
  }

  // Envoyer le message FCM à l'aide de l'API HTTP v1 de FCM
  Future<bool> sendFCMMessage(Map<String, dynamic> message) async {
    String serverKey =
        'AAAA3wFT_oA:APA91bET_mFikPGb3d6XBQpuo1JW_EO6QzERy-ORZB32wRYgWe5S_98Zlg5C9m1pkK2mh0m1aE2pmSPT_YQk45bBvQ27zF-DHBEi6sOa5IFGdNT1SG5riE1V8JQA6EqvT5IrX3gsvJuF';
    String postUrl =
        'https://fcm.googleapis.com/fcm/send'; // Remplacer par l'ID de votre projet Firebase
    final response = await http.post(
      Uri.parse(postUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> sendInvestNotif() async {
    await firebaseApi().sendFCMMessage(await firebaseApi().createFCMMessage(
        await firebaseApi().getToken(informations.email),
        "NOUVEL INVESTISSEMENT SUR EARN FOR ALL",
        "UNE PERSONNE VIENS DE FAIRE UN INVESTISSEMENT SUR EARN FOR ALL"));
    print("le jeton : " + await firebaseApi().getToken(informations.email));
  }

  Future<void> sendMessageNotif() async {
    await firebaseApi().sendFCMMessage(await firebaseApi().createFCMMessageTopic(
        "all",
        "NOUVEAU MESSAGE SUR EARN FOR ALL",
        "L'ADMINISTRATEUR VIENS DE LAISSER UN NOUVEAU MESSAGE SUR EARN FOR ALL"));
    print("le jeton : " + await firebaseApi().getToken(informations.email));
  }

  Future<void> sendDistributionNotif() async {
    await firebaseApi().sendFCMMessage(await firebaseApi()
        .createFCMMessageTopic("all", "DISTRIBUTION EARN FOR ALL",
            "LES BENEFICES VIENENT D'ETRES REDISTRIBUES SUR EARN FOR ALL"));
    print("le jeton : " + await firebaseApi().getToken(informations.email));
  }

  Future<void> sendRetraitNotif() async {
    await firebaseApi().sendFCMMessage(await firebaseApi().createFCMMessage(
        await firebaseApi().getToken(informations.email),
        "NOUVEAU RETRAIT SUR EARN FOR ALL",
        "UNE PERSONNE VIENS DE FAIRE UN RETRAIT SUR EARN FOR ALL"));
    print("le jeton : " + await firebaseApi().getToken(informations.email));
  }

// Créer une fonction qui inscrit un utilisateur à un topic
  Future<void> subscribeToTopic(String topic) async {
    String serverKey =
        'AAAA3wFT_oA:APA91bET_mFikPGb3d6XBQpuo1JW_EO6QzERy-ORZB32wRYgWe5S_98Zlg5C9m1pkK2mh0m1aE2pmSPT_YQk45bBvQ27zF-DHBEi6sOa5IFGdNT1SG5riE1V8JQA6EqvT5IrX3gsvJuF';

    // Obtenir le jeton FCM de l'utilisateur
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    // Créer un objet de paramètres pour la requête HTTP
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey'
    };

    Map<String, dynamic> body = {
      'to': '/topics/$topic',
      'registration_tokens': [token]
    };
    // Envoyer la requête HTTP à l'API FCM pour abonner l'utilisateur au topic
    final response = await http.post(
      Uri.parse('https://iid.googleapis.com/iid/v1:batchAdd'),
      headers: headers,
      body: jsonEncode(body),
    );
    // Vérifier le résultat de la requête
    if (response.statusCode == 200) {
      print('Utilisateur  abonné au topic $topic');
    } else {
      print(
          'Erreur lors de l\'abonnement au topic \'$topic\' : ${response.body}');
    }
  }

// Créer un message FCM avec le nom du topic et le contenu de la notification
  Future<Map<String, dynamic>> createFCMMessageTopic(
      String topic, String title, String body) async {
    Map<String, dynamic> message = {
      'to': '/topics/$topic', // Utiliser le champ to avec le préfixe /topics/
      'notification': {
        'title': title,
        'body': body,
        'image':
            'https://a.c-dn.net/c/content/dam/publicsites/sgx/images/Email/Trading_Cryptocurrencies_Effectively_Using_PriceAction.jpg/jcr:content/renditions/original-size.webp'
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
        'link':
            'https://console.firebase.google.com/project/earn-for-all-6d227/firestore/data/~2Futilisateurs',
      },
    };
    return message;
  }
}
