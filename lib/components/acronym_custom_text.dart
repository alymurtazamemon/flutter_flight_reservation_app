import 'package:flutter/material.dart';

import '../constants.dart';

class AcronymCustomText extends StatelessWidget {
  AcronymCustomText({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: kAccentColor,
        fontSize: 35.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
