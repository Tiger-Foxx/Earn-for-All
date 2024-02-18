import 'package:earn_for_all/models/messages_efa.dart';
import 'package:earn_for_all/theme/colors.dart';
import 'package:earn_for_all/utils/fontions.dart';
import 'package:earn_for_all/utils/infos.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Fonctions.recupererTousLesMessages(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessagesEFA> messages = snapshot.data! as List<MessagesEFA>;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              title: Text("Messages EFA"),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    (messages.length > 0)
                        ? SingleChildScrollView(
                            child: SizedBox(
                              height: 400,
                              child: ListView.builder(
                                itemCount: messages
                                    .length, // le nombre d'éléments dans la liste transactions
                                itemBuilder: (context, index) {
                                  // une fonction qui construit le widget à chaque position de la liste
                                  // On récupère la transaction à la position index
                                  MessagesEFA tx = messages[index];
                                  // On retourne un widget TransactionCard avec les données de la transaction
                                  return MessageContainer(
                                      message: tx.texte ?? "",
                                      autor: "EARN FOR ALL",
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
                                  "Aucun message  pour le moment",
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
                        onTap: () {
                          Fonctions.sendEmail(
                              "Bonjour, je m'appelle : ", informations.email);
                        },
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
    return Container(
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
                    fontSize: 14,
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
