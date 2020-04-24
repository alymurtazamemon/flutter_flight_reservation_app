import 'package:flutter/material.dart';

class ActiveInfoCustomText extends StatelessWidget {
  ActiveInfoCustomText({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
