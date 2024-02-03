import 'package:url_launcher/url_launcher.dart';

class Fonctions {
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
}
