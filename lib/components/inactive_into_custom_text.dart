import 'package:flutter/material.dart';

import '../constants.dart';

class InactiveInfoCustomText extends StatelessWidget {
  InactiveInfoCustomText({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: kInactiveTextColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
