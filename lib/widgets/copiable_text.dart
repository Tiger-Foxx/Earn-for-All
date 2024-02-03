import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableTextButton extends StatefulWidget {
  final String text;

  CopyableTextButton(this.text);

  @override
  State<CopyableTextButton> createState() => _CopyableTextButtonState();
}

class _CopyableTextButtonState extends State<CopyableTextButton> {
  bool is_copied = false;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        setState(() {
          is_copied = !is_copied;
        });
        Clipboard.setData(ClipboardData(text: widget.text));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Texte copié',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        );
      },
      icon: Icon(
        !is_copied ? Icons.copy : Icons.check,
        color: Colors.blue,
      ),
      label: Text(widget.text,
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.blue, fontSize: 18)),
    );
  }
}
