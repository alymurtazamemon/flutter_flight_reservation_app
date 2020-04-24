import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/constants.dart';

class CustomHorizontalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.0,
      thickness: 1.5,
      color: kLinesColor,
    );
  }
}
