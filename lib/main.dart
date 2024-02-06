import 'package:earn_for_all/firebase_options.dart';
import 'package:earn_for_all/pages/other/Splash_screen.dart';
import 'package:earn_for_all/pages/authentication/login.dart';
import 'package:earn_for_all/pages/authentication/register.dart';
import 'package:earn_for_all/services/messaging/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await firebaseApi().initNotifications();

  await initNotifications();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    sendLocalNotification(
        1,
        "NOUVELLE OPERATION SUR EAN FOR ALL",
        "UNE NOUVELLE OPERATION A ETE EFFECTUEE SUR EAN FOR ALL",
        ""); //FONCTION QUE J'AI AJOUTE
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash_screen(),
    );
  }
}

// Créer une instance du plugin de notification locale
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialiser le plugin avec des paramètres spécifiques pour Android
Future<void> initNotifications() async {
  // Créer un objet de paramètres d'initialisation pour Android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');

  // Initialiser le plugin avec les paramètres d'initialisation pour Android
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(android: initializationSettingsAndroid),
  );
}

// Créer une fonction qui peut envoyer une notification locale à l'utilisateur
Future<void> sendLocalNotification(
    int id, String title, String body, String? payload) async {
  // Créer un objet de détails de notification pour Android
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  // Envoyer la notification locale en utilisant le plugin
  await flutterLocalNotificationsPlugin.show(id, title, body,
      NotificationDetails(android: androidPlatformChannelSpecifics),
      payload: payload);
}
