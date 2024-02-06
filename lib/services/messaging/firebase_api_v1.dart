import 'dart:convert';
import 'dart:io';
import 'package:earn_for_all/utils/infos.dart';
import 'package:googleapis_auth/auth_io.dart';
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

class firebaseApi_v1 {
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
      'message': {
        'token': token,
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
        // Ajouter des champs spécifiques à chaque plateforme si besoin
        'android': {
          // Par exemple, tu peux spécifier le son, la couleur, l'icône, etc.
        },
        'webpush': {
          // Par exemple, tu peux spécifier les en-têtes, les données ou les notifications
        },
        'apns': {
          // Par exemple, tu peux spécifier les en-têtes, les données ou les notifications
        }
      }
    };
    return message;
  }

// Envoyer le message FCM à l'aide de l'API HTTP v1 de FCM
  Future<bool> sendFCMMessage(Map<String, dynamic> message) async {
    // Remplacer par l'ID de ton projet Firebase
    String projectId = 'earn-for-all-6d227';
    // Remplacer par le chemin vers ta clé privée
    String keyPath = "service-account.json";

    // Créer une instance de ServiceAccountCredentials à partir de la clé privée
    ServiceAccountCredentials credentials = ServiceAccountCredentials.fromJson(
        jsonDecode(File(keyPath).readAsStringSync()));

    // Créer une instance de ClientId à partir des identifiants du service
    ClientId clientid = ClientId(credentials.email, '');
    // Créer une liste des scopes requis pour l'API FCM
    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging'
    ];
    // Créer une instance de AutoRefreshingAuthClient qui gère automatiquement le rafraîchissement du jeton d'accès
    AutoRefreshingAuthClient client =
        await clientViaServiceAccount(credentials, scopes);

    // Construire l'URL du point de terminaison avec la version et l'ID du projet
    String postUrl =
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';
    // Envoyer la requête HTTP avec le client authentifié et le message JSON
    final response = await client.post(
      Uri.parse(postUrl),
      headers: {
        'Content-Type': 'application/json',
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
    await firebaseApi_v1().sendFCMMessage(await firebaseApi_v1()
        .createFCMMessage(
            await firebaseApi_v1().getToken(informations.email),
            "NOUVEL INVESTISSEMENT SUR EARN FOR ALL",
            "UNE PERSONNE VIENS DE FAIRE UN INVESTISSEMENT SUR EARN FOR ALL"));
    print("le jeton : " + await firebaseApi_v1().getToken(informations.email));
  }

  Future<void> sendRetraitNotif() async {
    await firebaseApi_v1().sendFCMMessage(await firebaseApi_v1()
        .createFCMMessage(
            await firebaseApi_v1().getToken(informations.email),
            "NOUVEAU RETRAIT SUR EARN FOR ALL",
            "UNE PERSONNE VIENS DE FAIRE UN RETRAIT SUR EARN FOR ALL"));
    print("le jeton : " + await firebaseApi_v1().getToken(informations.email));
  }
}
