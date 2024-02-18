import 'package:earn_for_all/models/transactions.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/utils/fontions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class TransactionAdmin extends StatelessWidget {
  const TransactionAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Fonctions.recuperertransactions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<transaction> transactions = snapshot.data! as List<transaction>;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              title: Text("Transactions EFA"),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    (transactions.length > 0)
                        ? SingleChildScrollView(
                            child: SizedBox(
                              height: 400,
                              child: ListView.builder(
                                itemCount: transactions
                                    .length, // le nombre d'éléments dans la liste transactions
                                itemBuilder: (context, index) {
                                  // une fonction qui construit le widget à chaque position de la liste
                                  // On récupère la transaction à la position index
                                  transaction tx = transactions[index];
                                  // On retourne un widget TransactionCard avec les données de la transaction
                                  return TransactionDismissible(
                                      is_valid: tx.isValid,
                                      id: tx.id,
                                      message: "Nouveau " +
                                          tx.type.toString() +
                                          " de " +
                                          tx.utilisateur.toString() +
                                          " pour le compte " +
                                          tx.reseau.toString() +
                                          "|  numero OM/MOMO : (" +
                                          tx.numero_OM_MOMO.toString() +
                                          "|" +
                                          tx.nom_OM_MOMO.toString() +
                                          ")| telephone : " +
                                          tx.tel.toString() +
                                          (!(tx.isValid ?? false)
                                              ? "\nEn attente de validation... (appuyez longuement pour valider)"
                                              : "\n Deja Valide , glisser pour supprimer"),
                                      autor: tx.montant.toString() + " XAF",
                                      date: "Le " + tx.date.toString());
                                },
                              ),
                            ),
                          )
                        : Center(
                            child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  "Aucune transaction pour le moment",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: mainFontColor,
                                  ),
                                ),
                              ),
                              Container(
                                  child: Lottie.asset(
                                      "assets/lotties/astronot.json")),
                            ],
                          )),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 90,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding:
                          EdgeInsets.symmetric(horizontal: 21, vertical: 16),
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
            ),
          );
        } else if (snapshot.hasError) {
          print("Erreur :" + snapshot.error.toString());
          print("Stacktrace : ");
          print(snapshot.stackTrace!);
          return SafeArea(
            child: Center(
              child: Text("Une Erreur s'est produite"),
            ),
          );
        } else {
          return SafeArea(
            child: Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class MessageContainer extends StatefulWidget {
  String message = '';
  String date = '';
  String autor = '';
  bool? is_valid = false;
  String? id = "";
  MessageContainer({
    super.key,
    required this.message,
    required this.autor,
    required this.date,
    this.is_valid,
    this.id,
  });

  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  bool is_valid = false;
  @override
  Widget build(BuildContext context) {
    is_valid = widget.is_valid ?? false;
    return GestureDetector(
      onLongPress: () {
        // Vérifier si le téléphone supporte la vibration

        // Faire vibrer le téléphone pendant 3 secondes (3000 millisecondes)

        setState(() {
          widget.is_valid = true;
          is_valid = true;

          Fonctions.validerTransaction(widget.id ?? "");
          Fonctions.AppliquerTransaction(widget.id ?? "");
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transaction validee'),
          ),
        );
      },
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
                    !(is_valid)
                        ? Icon(Icons.timelapse, color: Colors.red)
                        : Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
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
  bool? is_valid = false;
  String? id = "";

  // Définir le constructeur qui initialise les paramètres du message
  TransactionDismissible({
    Key? key,
    this.is_valid = false,
    this.id = "",
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
      onDismissed: (direction) async {
        await Fonctions.supprimerTransaction(id!);
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
        is_valid: is_valid ?? false,
        id: id,
      ),
    );
  }
}
