import 'package:earn_for_all/theme/colors.dart';
import 'package:flutter/material.dart';

class TransactionAdmin extends StatelessWidget {
  const TransactionAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text("Transactions EFA"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            ...List.generate(
              3,
              (index) => TransactionDismissible(
                  message:
                      "Nous seront bientot les rois de l'investissement les amis paroles de EARN FOR ALL, notr application se porte de mieux en mieux tous les jours grace a vous ",
                  autor: "EARN FOR ALL",
                  date: "Feb , 2, 2024"),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 90,
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
              decoration: BoxDecoration(
                color: mainFontColor,
              ),
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contacter L\'administrateur',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Icon(
                        Icons.phone,
                        size: 27,
                        color: white,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}

class MessageContainer extends StatefulWidget {
  String message = '';
  String date = '';
  String autor = '';
  MessageContainer(
      {super.key,
      required this.message,
      required this.autor,
      required this.date});

  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
        padding: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xffD0D0D0)),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/images/logoEFA (1).jpg'),
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.autor,
                      style: TextStyle(
                        color: mainFontColor,
                        fontSize: 14,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.date,
                      style: TextStyle(
                        color: Color(0xFFA8A8A8),
                        fontSize: 12,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.message),
                    const SizedBox(width: 24),
                    Icon(Icons.more_vert),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Créer un widget MessageDismissible qui hérite de StatelessWidget
class TransactionDismissible extends StatelessWidget {
  // Déclarer les paramètres du message
  final String message;
  final String autor;
  final String date;

  // Définir le constructeur qui initialise les paramètres du message
  const TransactionDismissible({
    Key? key,
    required this.message,
    required this.autor,
    required this.date,
  }) : super(key: key);

  // Définir la fonction qui construit le widget
  @override
  Widget build(BuildContext context) {
    // Retourner un widget Dismissible qui rend le message glissable
    return Dismissible(
      // Spécifier la clé du widget comme le message
      key: Key(message),
      // Spécifier la direction du glissement comme vers la gauche
      direction: DismissDirection.endToStart,
      // Spécifier la fonction à appeler lors de la suppression
      onDismissed: (direction) {
        // Afficher un message de confirmation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transaction supprimé'),
          ),
        );
        // Appeler une autre fonction si besoin
        // ...
      },
      // Spécifier le widget à afficher en arrière-plan
      background: Container(
        // Mettre une couleur rouge
        color: Colors.red,
        // Mettre une icône de poubelle à droite
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      // Spécifier le widget à afficher en premier plan
      child: MessageContainer(
        // Passer les paramètres du message
        message: message,
        autor: autor,
        date: date,
      ),
    );
  }
}
