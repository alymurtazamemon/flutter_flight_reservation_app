import 'package:flutter/material.dart';

class EmiratesLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: Image(image: AssetImage('images/flight_center_logo.png')),
    );
  }
}
