import 'package:earn_for_all/theme/colors.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text("Messages EFA"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            ...List.generate(
              3,
              (index) => MessageContainer(
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
    );
  }
}
