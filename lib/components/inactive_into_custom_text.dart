import 'package:flutter/material.dart';

import '../constants.dart';

class InactiveInfoCustomText extends StatelessWidget {
  InactiveInfoCustomText({@required this.text, this.height});

  final String text;
  final height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        height: height,
        color: kInactiveTextColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
